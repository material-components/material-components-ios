/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

/**
 GitHub loads its webpages using pjax, meaning we never really get a full document-did-load
 event firing after the initial load. This means if you open the pull requests page and then
 click a pull request, this js file is only executed when you load the initial pull requests page.
 Because the DOM is changing dynamically and we don't have a way to register live events to DOM
 elements as they're created, we need to poll the page for any squash-and-merge buttons.
 */
(function() {
  /*
   On PR pages, finds a "Squash and Merge" button and adds a click event listener that replaces
   the commit description with the PR description.
   */
  function scanForSquashAndMergeButtons() {
    if (document.location.href.indexOf('/pull/') === -1) {
      return;
    }
    var squashContainer = document.getElementsByClassName('btn-group-squash')[0];
    if (!squashContainer) {
      return;
    }
    var squashButton = squashContainer.querySelector('button[type="submit"]');
  
    if (squashButton.getAttribute('squashmerge')) {
      return;
    }

    squashButton.addEventListener('click', function() {
      // GitHub populates the commit message with a bit of a delay, so we also need to delay our
      // population of the message.
      setTimeout(function() {
        var mergeMessageField = document.getElementById('merge_message_field');
        var prTextarea = document.getElementsByClassName('comment-form-textarea')[0];
        mergeMessageField.value = prTextarea.value;
      }, 50);
    });
    squashButton.setAttribute('squashmerge', 'true');
  }

  const pollInterval = 1000; // Milliseconds

  /*
   Polls the current page for a squash and merge button.
   */
  function poll() {
    scanForSquashAndMergeButtons();

    setTimeout(poll, pollInterval);
  }

  setTimeout(poll, pollInterval);
})();
