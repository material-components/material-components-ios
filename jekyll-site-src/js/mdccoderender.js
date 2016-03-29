/**
 * @fileoverview
 * Material code renderer provides a wrapper around CodeMirror and renders code
 * snippets into material design styling.
 */

(function() {
  'use strict';
  // A Boolean value to control line numbers generation. Device width smaller
  // than 600px will be considered as mobile device.
  var _mobileSized = false;
  // Default language setting when no value is provided by kramdown.
  var _defaultLang = 'objc';
  // A Map between kramdown language name and codeMirror name.
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
    },
    text: {
      language: 'Text',
      mode: 'text/plain'
    }
  };

  /**
   * Generate single code mirror obj from source
   * @param {!Element} source An DOM element that contains the code snippet.
   * @param {boolean | false} lineno An boolean value for line number.
   * @return {Object} An Object of codeMirror bject and language.
   */
  function renderSimpleCodeRenderer(source, lineno) {
    function shellFilter() {
      var lines = cm.display.wrapper.querySelectorAll('.CodeMirror-line>span');
      for (var i = 0; i < lines.length; i++) {
        var line = lines[i];
        if (line.querySelector('.cm-def') &&
          line.innerText.indexOf('$') !== -1) {
            var childrenOfLine = line.childNodes;
            for (var j = 0; j < childrenOfLine.length; j++) {
              if (childrenOfLine[j].classList &&
                 childrenOfLine[j].classList.contains('cm-def') !== -1) {
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
    var kramdownLang = source.classList.length == 0 ?
        _defaultLang : source.classList[0].replace('language-', '');
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

    // If the language is Shell, this piece of logic process user path properly
    if (language === 'Shell') {
      shellFilter();
    }
    return {
      language: language,
      cm: cm
    };
  }


  /**
   * Generate multiple code mirror objects and form the material code renderer.
   * @param {Element} renderer An DOM element that wraps multiple code snippets.
   * @param {string} id An string to identify the renderer.
   * @return {Object} An Object of codeMirror bject and language.
   */
  function renderComplexCodeRenderer(renderer, id) {
    // Allowed Language for complex material code render.
    var _complexRendererAllowedLang = ['Objective-C', 'Swift'];
    // A Utility class to set/get page selected language.
    var selectedLanguage = {
      set: function(value) {
        value = _complexRendererAllowedLang.indexOf(value) !== -1 ?
                value : _complexRendererAllowedLang[0];
        if (typeof(window.sessionStorage) !== 'undefined') {
          window.sessionStorage.setItem('selectedLanguage', value);
        }
        else {
          selectedLanguage._value = value;
        }
      },
      get: function() {
        var value;
        if (typeof(window.sessionStorage) !== 'undefined') {
          value = window.sessionStorage.getItem('selectedLanguage');
        }
        else {
          value = selectedLanguage._value;
        }
        return value || _complexRendererAllowedLang[0];
      }
    };
    /**
     * Generate Single radio button element from frontend template
     * @param {string} groupname An string to identify the group of radio button
     * belongs to.
     * @param {string} label The displayed name of the radio button.
     * @return {Element} An unattached DOM Node for a radio button.
     */
    function MaterialRadioButton(groupname, label) {
      var radioLabel = document.getElementById('tmpl-radio-button')
                      .cloneNode(true);
      radioLabel.setAttribute('id', '');
      var radioInput = radioLabel.querySelector('.radio-input');
      radioInput.setAttribute('name', groupname);
      radioInput.setAttribute('value', label);
      var languageSpan = radioLabel.querySelector('.language-name');
      languageSpan.innerText = label;

      radioLabel.addEventListener('click', function(e) {
        var lang = this.querySelector('.radio-input').value;
        if (selectedLanguage.get() == lang) {
          return false;
        }
        selectedLanguage.set(this.querySelector('.radio-input').value);
        var evt = document.createEvent('HTMLEvents');
        evt.initEvent('selectLangChange', false, true);
        document.dispatchEvent(evt);
      });
      return radioLabel;
    }

    var sources = renderer.querySelectorAll('pre code');
    var availableLanguage = [];
    // Before generate:
    // 1. Take care of invalid code snippet case.
    for (var i = 0; sources && i < sources.length; i++) {
      var source = sources[i];
      var kramdownLang = source.classList.length == 0 ? '' :
        source.classList[0].replace('language-', '');
      var language = kramdownToCodeMirrorMap[kramdownLang].language;
      if (_complexRendererAllowedLang.indexOf[language] === -1) {
        source.parentNode.removeChild(source);
      }
      else {
        availableLanguage.push(language);
      }
    }
    // 2. Take care of non code snippet case after invalid snippets are deleted.
    if (!sources || sources.length === 0) {
      renderer.parentNode.removeChild(renderer);
      return;
    }
    // Generate Complex Code Renderer:
    // 1. Variables set up
    var maxHeight = 0;
    var radioForm = document.createElement('form');
    radioForm.classList.add('language');
    var cmMap = {};
    var radioName = 'MaterialCodeRenderer' + id;
    var useLineNumbers = !_mobileSized;
    if (useLineNumbers) {
      renderer.classList.add('line-numbers');
    }
    // 2. Convert code snippet to code mirror
    for (var i = 0; i < sources.length; i++) {
      var source = sources[i];
      var simpleRender = renderSimpleCodeRenderer(source, useLineNumbers);
      var radioEl = new MaterialRadioButton(radioName, simpleRender.language);
      var clientHeight = simpleRender.cm.getScrollInfo().clientHeight;
      maxHeight = maxHeight < clientHeight ? clientHeight : maxHeight;
      radioForm.appendChild(radioEl);
      cmMap[simpleRender.language] = simpleRender.cm;
    }
    // 3. Add radioForm into DOM
    renderer.insertBefore(radioForm, renderer.firstChild);
    // 4. Listen to selectLangChange event and change code snippet in display.
    radioForm.addEventListener('selectLangChange', function() {
      var targetLanguage = selectedLanguage.get();
      targetLanguage = availableLanguage.indexOf(targetLanguage) == -1 ?
                       availableLanguage[0] : targetLanguage;
      radioForm.querySelector('.radio-input[value="' +
                              targetLanguage + '"]').checked = true;
      renderer.querySelector('.CodeMirror.active').classList.remove('active');
      cmMap[targetLanguage].display.wrapper.classList.add('active');
      return false;
    });
    // 5. Set the code renderer container height to the highest code mirror.
    renderer.style.height = maxHeight + radioForm.offsetHeight + 'px';

    // After Generation:
    // Initialize with targetLanguage
    var targetLanguage = selectedLanguage.get();
    targetLanguage = availableLanguage.indexOf(targetLanguage) == -1 ?
                     availableLanguage[0] : targetLanguage;
    radioForm.querySelector('.radio-input[value="' +
                             targetLanguage + '"]').checked = true;
    cmMap[targetLanguage].display.wrapper.classList.add('active');
  }


  window.addEventListener('load', function() {
    if (document.body.clientWidth < 600) {
      _mobileSized = true;
    }
    // First: renders material code wrapper
    var complexrenders = document.querySelectorAll('.material-code-render');
    for (var i = 0; i < complexrenders.length; i++) {
      // RendererIndex assigns a unique id to each code renderer. The id will
      // be used by radioForm for each code renderer to form radio button group.
      renderComplexCodeRenderer(complexrenders[i], i);
    }
    // Second: renders all other code snippet
    var simplerenders = document.querySelectorAll('pre code');
    for (var j = 0; j < simplerenders.length; j++) {
      renderSimpleCodeRenderer(simplerenders[j]);
    }
    // Listen to selectLangChange event at document level and forward that event
    // to exsiting material code renders
    document.addEventListener('selectLangChange', function(e) {
      console.log('value changes');
      for (var i = 0; i < complexrenders.length; i++) {
        var evt = new e.constructor(e.type, e);
        complexrenders[i].querySelector('.language').dispatchEvent(evt);
      }
    });
  });
})();