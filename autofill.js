import { $, $$, downloadBlob } from './dom-utils'

function extractQueryString() {
  var params = {};
  var url = new URL(window.location);
  for(var hashParam of url.hash.substr(1).split(/&/)) {
    var kv = decodeURIComponent(hashParam).split(/=/);
    if (kv[0] == "reason") {
      if (!("reasons" in params)) {
        params["reasons"] = [];
      }
      params["reasons"].push(kv[1]);
    } else {
      params[kv[0]] = kv[1];
    }
  }
  return params;
}

function autofill (formInputs, reasonInputs) {
  var urlParams = extractQueryString();

  var formInputTypes = ["text", "number"];
  formInputs.forEach((input) => {
    if (formInputTypes.indexOf(input.type) > -1) {
      if (input.name in urlParams) {
        input.value = urlParams[input.name];
      }
    }

  });

  reasonInputs.forEach((input) => {
    if (input.type == "checkbox" && input.name == "field-reason") {
      if ("reasons" in urlParams) {
        urlParams["reasons"].forEach(function(paramValue) {
            if (input.value == paramValue) {
              input.checked = true;
              return;
            }
          }
        );
      }
    }
  });
}

function autogen(formInputs) {
  $("#generate-btn").click();
}

export function gofill() {
	const formInputs = $$('#form-profile input')
	const reasonInputs = [...$$('input[name="field-reason"]')]
	autofill(formInputs, reasonInputs)

       // FIX: generate time
       const getCurrentTime = () => {
           const date = new Date()
           return date.toLocaleTimeString('fr-FR', { hour: '2-digit', minute: '2-digit'})
       }
      var element = document.getElementById('field-heuresortie');
      element.value = getCurrentTime()
      // ENDFIX

      autogen();
}

/*
import { gofill } from './autofill'

(function() { 
	gofill() 
})();
*/
