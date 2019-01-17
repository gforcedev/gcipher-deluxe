A (different) Cipher cracking program - an experiment with using lua or python scripts using node's childProcess.
It likely won't replace the other gcipher, unless the performance issues with monoalphabetic sub can be fixed.

Currently, only Caesar and Vigenere are fully functional, as well as the word guesser.

Known issues:
  - posts can happen in any order
  - monoalphabetic sub takes a long time, and isn't very reliable.

Word guessing python is from https://norvig.com/ngrams/ used under the MIT license. (https://opensource.org/licenses/mit-license.php)
