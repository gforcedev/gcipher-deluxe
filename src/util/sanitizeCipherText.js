module.exports = function sanitizeCipherText(s) {
	return s.toUpperCase().replace(/[^A-Z]/g, '');
};
