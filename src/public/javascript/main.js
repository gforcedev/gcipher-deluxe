/* global $ */

let mode = 'moar';

$(document).on('paste','#cipher-text-input', function() {
	setTimeout(function() {
		let asd = strip_tags( $('#cipher-text-input').html(), '<b><b/><i></i>');
		$('#cipher-text-input').html(asd);
	},100);
});

function strip_tags (input, allowed) {
    /* http://kevin.vanzonneveld.net*/

    if ( input == undefined ) { return ''; }

    allowed = (((allowed || "") + "").toLowerCase().match(/<[a-z][a-z0-9]*>/g) || []).join(''); // making sure the allowed arg is a string containing only tags in lowercase (<a><b><c>)
    var tags = /<\/?([a-z][a-z0-9]*)\b[^>]*>/gi,
        commentsAndPhpTags = /<!--[\s\S]*?-->|<\?(?:php)?[\s\S]*?\?>/gi;
    return input.replace(commentsAndPhpTags, '').replace(tags, function ($0, $1) {
        return allowed.indexOf('<' + $1.toLowerCase() + '>') > -1 ? $0 : '';
    });
}



let curCipher = 'caesar';

$(function() {
	$('#submit').click(() => {
		const time = +new Date();
		$.post('https://gcipher-challenge-gforcedev.c9users.io/crack', {
			ct: $('#cipher-text-input').text(),
			cipher: curCipher
		},
		(data) => {
			$('#plain-text-output').html(data);
			console.log(`Time: ${+new Date() - time}`);
		});
	});
	
	$('#word-guess').click(() => {
		if (mode === 'less') {
			mode = 'moar';
			$('#word-guess').html('GIMME SPACES!!!');
			$('#plain-text-output').html($('#plain-text-output').text().replace(/\s/g, ''));
		} else {
		const time = +new Date();
			$.post('https://gcipher-challenge-gforcedev.c9users.io/wordguess', {
				text: $('#plain-text-output').text()
			},
			(data) => {
				$('#plain-text-output').html(data);
				console.log(`Time: ${+new Date() - time}`);
				$('#word-guess').html('DELET THE SPACES!!!');
				mode = 'less';
			});
		}
	});
	
	$('.cipher-tab').click(function() {
		curCipher = $(this).attr('value');
		$('.is-active').removeClass('is-active');
		$(this).addClass('is-active');
	});
});
