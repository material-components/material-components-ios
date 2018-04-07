const {danger, warn, fail} = require('danger')

const affectedFiles = danger.git.modified_files
  .concat(danger.git.created_files)
  .concat(danger.git.deleted_files)

if (danger.github.pr.body.length < 10) {
  warn('Please provide a detailed description of the change.');
}

if (!danger.github.pr.body.includes("pivotaltracker.com")
    || danger.github.pr.body.includes("No pivotal story required.")) {
  fail('Please either provide a link to a pivotal story or include the text "No pivotal story required." in your PR description.');
}

const modifiedComponentFiles = affectedFiles.filter(p => p.includes("components/"))

if (modifiedComponentFiles.length > 0) {
  message(modifiedComponentFiles.join(", "))
}
