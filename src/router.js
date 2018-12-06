let _requestID = 0;
// const keys = new Map();

module.exports = app => {
	/* GET home page. */
	app.get('/', function(req, res) {
		res.render('index', { title: 'Gcipher-Challenge' });
	});

	app.post('/wordguess', async (req, res) => {
		const output = await app._wordGuesser.guess(req.body.text);
		res.send(output);
	});

	// Handle cracker requests
	app.post('/crack', async (req, res) => {
		// const requestID = _requestID++;
		// const requestIP = req.connection.remoteAddress;
		// if (activeRequests.has(requestIP)) {
		// 	return res.send('Pls don\'t spam me :(');
		// }
		// activeRequests.set(requestIP, requestID);
		// console.log(activeRequests.get(requestIP));
		// console.log('s1');
		const output = await app._cipherHandler.crack(req.body.cipher, req.body.ct);
		// console.log('s2');
		// activeRequests.delete(requestIP);
		res.send(output);
	});
};