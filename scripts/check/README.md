# Component checking scripts

Scripts in this directory check a "component" for various things. They are generally run by the
driver script `scripts/check_components`, but can be run by themselves.

## Script requirements

1.  Each script should take a single directory path to a component and perform some check on the
    component. For example, a script might check to see that a component has a README.md file.
    * If the component passes the check, print nothing and exit with a status of zero (success).
    * If the component does not pass the check, print a brief error message and exit with a non-zero
      status (failure).
2. To be identified as a check script to be run by the `scripts/check_components` driver script, each
check script should be marked executable (e.g. `chmod +x check/the_check_script`).

