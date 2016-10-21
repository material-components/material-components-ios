# Deprecation policy

Change is inevitable. Progress cannot be stopped. The ability to deprecate features, components and paradigms is essential to the health of this project. 

However, the price paid in disruption and maintenance is real; deprecating without warning, too often, or for poor rationale is a hinderance to adoption and contribution. It must be done with care and process.

## Get the 'thumbs up'

Propose your deprecation on GitHub as an Issue with the label 'type:Deprecation'. Much like a feature proposal, the contributors have a responsibility to carefully judge the consequences of breaking changes against possible gains. 

We should collaboratively answer the following questions:

1. Should this code be deprecated? Is it really worth the time and effort for everyone?
1. Why is the code being deprecated? Why should client teams switch?
1. What are client teams supposed to replace the code with?
1. What is the impact?
1. How much is the current code being used? (Show your numbers.)
1. How much work will it be for clients to switch? (Is the change automatable, etc.)
1. What is a good deprecation timeline?
1. Small/automatable changes can be done in a month.
1. Larger/manual changes can be done in a quarter/three months.
1. Adjust up or down based on the size/complexity of the change.
1. Who’s on point? It’s good to have a single person to keep track of things.

## Make sure replacement code is ready

* For minor changes, has the catalog been updated to use and demo it? 
* For major changes, has the new code had time to bake and is there at least one client team using it without problems?  
* Is the new code documented in the headers and site?

## Pin down the schedule

Assuming that you’re looking at a one-month deprecation, then the schedule looks roughly like this:

1. *T minus 4 weeks*: Deprecation is announced but no breaking or behavior changes are introduced. If new code is being added, do so now.
1. *T minus 3 weeks*: Old code is marked as deprecated, generating warnings.
1. *T minus one day*: Impending breakage is announced.
1. *T minus zero*: Breaking changes are made.
1. *T plus one week*: Possible rollbacks or fixes for client teams.

A three-month deprecation is similar with more time for switching client code:

1. *T minus 12 weeks*: Announce.
1. *T minus 9 weeks*: Mark code as deprecated.
1. *T minus one week*: Announce breakage.
1. *T minus zero*: Breaking changes are made.
1. *T plus one week*: Possible rollbacks or fixes for client teams.

Map this schedule onto reality: 

* Is there a holiday/conference coming up that would prevent client teams from being able to work with you? 
* Is the change simple but affects many teams so more time might be required? 
* Is the to-be-replaced code particularly problematic for some reason? 
* Does the deprecation fall near a release of the operating system or new devices?

## Do the work

Before announcing the deprecation, add it to the [Active Deprecations](http://github.com/google/material-components-ios/DEPRECATIONS.md) document. Include the rationale, the schedule, what client teams have to do, and which Issue in GitHub represents it. That Issue will stay open until the deletion PR is submitted.

TODO: Include announcement instructions. Generally, this is done via blog.

Deprecate APIs using the macro provide by Apple in AvailabilityMacros.h that includes a message:
* DEPRECATED_MSG_ATTRIBUTE(msg)

This macro requires an explanation string which should be similar to: ”This API will be removed on D/M/YYYY. Please use XYZ instead. See Issue #n for more details.”

For any code that should be eventually deleted, add the following comment nearby to make it easier to find and remove the code: // DEPRECATION(github.com/google/material-components-ios/issues/n)

Once you submit the breaking PR, don’t immediately pile on subsequent PRs that would conflict with an emergency rollback.

## Checklist

This is an idealized summary of how to replace old code with new code.

1. Create an alternative
1. Discuss the change via GitHub Issue.
1. Create and vet the new code.
1. Document the old code so new users don’t start using it.
1. Publicize and do the deprecation
1. Create a schedule.
1. Mark the old code as deprecated.
1. Continue fixing and helping the client teams.
1. Clean up
1. Delete the old code.
1. Handle any unexpected fallout.
1. Close the Issue.
