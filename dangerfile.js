const {danger, warn} = require('danger')

if (danger.github.pr.body.length < 10) {
  warn('Please include a description of your PR changes.');
}
