# Component checking scripts

These scripts are generally run by `scripts/check_components`, but can be run by themselves.

## Script requirements

Each script should take a single component directory path and perform some check on the component,
for example, checking to see that it has a README.md file.

If the component passes the check, print nothing and exit with a status of zero (success).

If the component does not pass the check, print a brief error message and exit with a non-zero
status (failure).

