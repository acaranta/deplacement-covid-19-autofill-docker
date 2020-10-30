
function setFormValues()
{
	var form = document.forms["form-profile"];
	var args = location.search.substr(1).split(/&/);
	if (form.elements.length > 0) {
		for (var i=0; i<args.length; ++i) {
			var tmp = args[i].split(/=/);
			if (tmp[0] != "") {
				form.elements["field-"+decodeURIComponent(tmp[0])].value = decodeURIComponent(tmp[1].replace("+", " "));
			}
		}
	}

}

(function() { 
	setFormValues();
})();
