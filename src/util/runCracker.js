const { spawn } = require('child_process');
const sanitizeCipherText = require('./sanitizeCipherText');
const process = require('process');

module.exports = class CipherHandler {
  constructor() {
    const child = spawn('lua', ['luaCracking/main.lua'], {
        shell: true
    });
    
    child.stderr.on('data', (data) => {
  		console.log('child.stderr');
  	});
  	
    child.stdout.setEncoding('utf8');
	
	this.child = child;
  	
  }
  
  crack(cracker, cipherText) {
    return new Promise((resolve, reject) => {
      const time = + new Date();
      // console.log(sanitizeCipherText(cipherText));
    	this.child.stdin.write(`${cracker},${sanitizeCipherText(cipherText)}\n`);
    	this.child.stdout.once('data', (data) => {
        resolve(data);
        console.log(`Cracked in ${(new Date() - time)}ms`);
      });
    });
  }
};
