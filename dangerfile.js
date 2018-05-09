const {danger, warn, fail} = require('danger')

if (danger.github.pr.body.length < 10) {
  warn('This PR does not include a description.');
}
