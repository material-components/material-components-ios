const {danger, warn, fail} = require('danger')

if (danger.github.pr.body.length < 10) {
  warn('Please provide a detailed description of the change.');
}
