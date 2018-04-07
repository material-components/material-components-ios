const {danger, warn, fail} = require('danger')

const modified = danger.git.modified_files

if (danger.github.pr.body.length < 10) {
  warn('Please provide a detailed description of the change.');
}

if (!danger.github.pr.body.includes("pivotaltracker.com")
    || danger.github.pr.body.includes("No pivotal story required.")) {
  fail('Please either provide a link to a pivotal story or include the text "No pivotal story required." in your PR description.');
}

message(modified.join(", "))
