MDCCodeRender = (function(){
  'use strict';
	var rendererIndex = 0;
  var kramdownToCodeMirrorMap = {
    objc: {
      language: 'Objective-C',
      mode: 'text/x-objectivec'
    },
    swift: {
      language: 'Swift',
      mode: 'text/x-swift'
    },
    bash: {
      language: 'Shell',
      mode: 'text/x-sh'
    },
    shell: {
      language: 'Shell',
      mode: 'text/x-sh'
    },
    ruby: {
      language: 'Ruby',
      mode: 'text/x-ruby'
    }
  };
  var mobileSized = false;


  // Returns an unattached DOM Node for a radio button
  function MaterialRadioButton(groupname, label) {
    var radioLabel = document.getElementById('tmpl-radio-button').cloneNode(true);
    radioLabel.setAttribute('id', '');
    var radioInput = radioLabel.querySelector('.radio-input');
    radioInput.setAttribute('name', groupname);
    radioInput.setAttribute('value', label);
    var languageSpan = radioLabel.querySelector('.language-name');
    languageSpan.innerText = label;

    radioLabel.querySelector('.source-radio.unchecked').addEventListener('click', function() {
			var evt = document.createEvent("HTMLEvents");
    	evt.initEvent("change", true, true);
			this.parentNode.previousSibling.checked = true;
			this.parentNode.previousSibling.dispatchEvent(evt);
		});
		return radioLabel;
	}


  function renderSimpleCodeRenderer(source, lineno) {
    if(!source) {
      // a very aggressive way for wrongly discleared renderer - delete them!
      source.parentNode.removeChild(source);
      return;
    }
    var kramdownLang = source.classList[0].replace('language-', '');
    var language = kramdownToCodeMirrorMap[kramdownLang].language;
    var mode = kramdownToCodeMirrorMap[kramdownLang].mode;
    var cm = CodeMirror(function(elt) {
      source.parentNode.parentNode.replaceChild(elt, source.parentNode);
    }, {
      value: source.innerText.trim(),
      mode: mode,
      lineNumbers: lineno || false,
      readOnly: 'nocursor'
    });

    // add some logic to process user path properly
    if(language === 'Shell') {
      var lines = cm.display.wrapper.querySelectorAll('.CodeMirror-line>span');
      for(var i = 0; i < lines.length; i++) {
        var line = lines[i];
        if(line.querySelector('.cm-def') && line.innerText.indexOf('$') !== -1) {
          var childrenOfLine = line.childNodes;
          for(var j = 0; j < childrenOfLine.length; j++) {
            if(childrenOfLine[j].classList && childrenOfLine[j].classList.contains('cm-def') !== -1) {
              break;
            }
            var span = document.createElement('span');
            span.classList.add('cm-userpath');
            span.innerHTML = childrenOfLine[j].nodeValue;
            line.replaceChild(span, line.childNodes[j]);
          }
        }
      }
    }

    return {
      language: language,
      mode: mode,
      cm: cm
    };
	}


	function renderComplexCodeRenderer(renderer) {
    var sources = renderer.querySelectorAll('pre code');
    if(!sources || sources.length === 0) {
      // a very aggressive way for wrongly discleared renderer - delete them!
      renderer.parentNode.removeChild(renderer);
      return;
    }
		var maxHeight = 0;
		var radioForm = document.createElement('form');
		radioForm.classList.add('language');
		var cmMap = {};
    var radioName = 'MaterialCodeRenderer' + rendererIndex;
    var useLineNumbers = !mobileSized;

    if (useLineNumbers) {
      renderer.classList.add('line-numbers');
    }

		for(var i = 0; i < sources.length; i++) {
			var source = sources[i];
      var simpleRender = renderSimpleCodeRenderer(source, useLineNumbers);
      var radioEl = new MaterialRadioButton(radioName, simpleRender.language);
		  //var clientHeight = simpleRender.cm.getScrollInfo().clientHeight + 48;
		  var clientHeight = simpleRender.cm.getScrollInfo().clientHeight;
		  maxHeight = maxHeight < clientHeight? clientHeight : maxHeight;
		  radioForm.appendChild(radioEl);
		  cmMap[simpleRender.language] = simpleRender.cm;
		}
		radioForm.addEventListener('change', function(e) {
			console.log("value changes")
      var selectedRadio = radioForm.querySelector('input[name="' + radioName + '"]:checked');
			var targetLanguage = selectedRadio.value;
			renderer.querySelector('.CodeMirror.active').classList.remove('active');
			cmMap[targetLanguage].display.wrapper.classList.add('active');
		});
		renderer.insertBefore(radioForm, renderer.firstChild);
		renderer.style.height = maxHeight + radioForm.offsetHeight + 'px';
		rendererIndex++;

		//select the first one
		radioForm.querySelector('.radio input[type=radio]:first-child').checked = true;
		renderer.querySelector('.CodeMirror').classList.add('active');
	}



  window.addEventListener('load', function() {
    if (document.body.clientWidth < 600) {
      mobileSized = true;
    }
  	var complexrenders = document.querySelectorAll('.material-code-render');
  	for(var i = 0; i < complexrenders.length; i++) {
  		renderComplexCodeRenderer(complexrenders[i]);
  	}
    var simplerenders = document.querySelectorAll('pre code');
    for(var j = 0; j < simplerenders.length; j++) {
      renderSimpleCodeRenderer(simplerenders[j]);
    }
  });

})();
