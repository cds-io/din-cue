#!/usr/bin/env node

// Import necessary modules
import readline from 'readline';

// Set up readline interface for reading from stdin
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

// Variables to manage the current error processing state
let currentError = [];
let processingError = false;

// Regular expression to detect specific error types
const errorTypeRegex = new RegExp(`UniqueItems|subsetCheck`);

// Listen for each line of input
rl.on('line', (line) => {
  if (!processingError && /^\S/.test(line) && errorTypeRegex.test(line)) {
    // Start of a new error message
    currentError.push(line);
    processingError = true;
  } else if (processingError && /^\s/.test(line)) {
    // Part of the current error message (stack trace or continuation)
    currentError.push(line);
  } else if (processingError && /^\S/.test(line)) {
    // End of current error message and possible start of a new one
    processingError = false;
    processError(currentError.join('\n'));
    currentError = [line];
    if (errorTypeRegex.test(line)) {
      processingError = true;
    }
  } else if (!processingError) {
    // Non-error line, reset currentError
    currentError = [];
  }
});

// Process remaining error if any after the input ends
rl.on('close', () => {
  if (currentError.length > 0) {
    processError(currentError.join('\n'));
  }
});

// Function to identify and process different types of errors
function processError(errorMessage) {
  console.error(`Error encountered: ${errorMessage}`);
  
  if (/field not allowed:/.test(errorMessage)) {
    const fieldMatch = errorMessage.match(/(?:.*_subsetCheck\.)?(.*): field not allowed:/);
    const field = fieldMatch ? fieldMatch[1] : 'unknown';
    console.error(`Error Type: Field not allowed. The field "${field}" is not recognized.`);
    // Handle this specific error type
  } else if (/does not satisfy list.UniqueItems/.test(errorMessage)) {
    console.error('Error Type: Unique items constraint violated.');
    handleDuplicateMethods(errorMessage);
  } else {
    console.error('Error Type: General or unclassified error.');
    // Handle general or other types of errors
  }
}

// Function to handle specific 'UniqueItems' error by identifying duplicates
function handleDuplicateMethods(errorMessage) {
  const methods = errorMessage.match(/\[(.*?)\]/)?.[1]?.split(',').map(item => item.trim());
  if (methods) {
    const seen = new Set();
    const duplicates = new Set();
    methods.forEach(item => {
      if (seen.has(item)) {
        duplicates.add(item);
      } else {
        seen.add(item);
      }
    });
    if (duplicates.size > 0) {
      console.error('\nDuplicate method(s) detected:');
      duplicates.forEach(duplicate => console.error(`\t- ${duplicate}`));
      console.error('\n');
    }
  }
}

