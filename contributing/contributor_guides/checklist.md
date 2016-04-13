# The checklist

Over time we have curated a growing checklist of things we feel improve the experience of using a
custom UIKit component. Many of these checks are performed by humans but we're now increasing the
number of checks that can be performed by scripts.

## Running the checklist

To run the checklist, execute the following command from the root of this repo:

~~~bash
scripts/check_components
~~~

This command will run every check on every component. The output will look something like this:

~~~
<some check>:
<component failing the check>
<another component failing the check>
<another check>:
<a third check>:
~~~

Each check is expected to output each component that is failing the check.

For example, our `missing_readme` check simply verifies whether each component has a README.md file
in its root directory. If a component is missing a README.md, the check outputs the component's
name, like so:

~~~
FontDiskLoader
private/Color
private/Icons/icons/ic_arrow_back
private/ThumbTrack
RobotoFontLoader
~~~

## Creating checks

Creating a check is as simple creating an executable script in the `scripts/check/` directory. Your
script will not be provided any arguments or stdin and is expected to output a components that fail
the check, one component per line.

### Snippets

Use the following snippets to bootstrap your checks.

*Find all components and perform a simple conditional*

~~~bash
find components -type d -name 'src' | while read path; do
  folder=$(dirname $path)
  component=$(echo $folder | cut -d'/' -f2-)

  if [ <your check logic> ]; then
    echo $component # This component failed the check
  fi
done
~~~
