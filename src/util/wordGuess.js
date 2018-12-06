const { spawn } = require('child_process');
const sanitizeCipherText = require('./sanitizeCipherText');
const process = require('process');

module.exports = class WordGuesser {
  constructor() {
    const child = spawn('python', ['ngrams.py'], {
        cwd: 'wordGuessing/',
        shell: true
    });
    
    child.stderr.on('data', (data) => {
  		console.log(data.toString());
  	});
  	
    child.stdout.setEncoding('utf8');
	
	this.child = child;
  	
  }
  
  guess(text) {
    return new Promise((resolve, reject) => {
      const time = + new Date();
      this.child.stdout.once('data', (data) => {
        resolve(data);
        console.log(`Guessed in ${(new Date() - time)}ms`);
      });
    	this.child.stdin.write(text);
    	this.child.stdin.write('\n');
    });
  }
};
