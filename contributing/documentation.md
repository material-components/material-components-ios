# Documentation

Every component is expected to provide complete API documentation for every public API and a
top-level README.md file that includes the following:

- A description of the component in relation to the Material spec.
- A looping, animated gif of the component.
- Links to Design and API documentation.
- A list of related components, if any.
- An overview that describes the primary APIs for the component.
- Installation steps.
- Usage guides. Must include at least one typical use article.
- Extensions articles, if any.

## Documentation conventions

```
components/
  Component/
    .vars        <- A list of variables that can be used by the template generators.
    README.md    <- This is an auto-generated file. Do not modify it directly.
    docs/        <- All documentation source lives here.
      README.md  <- The root index of your component's documentation.
      article.md <- An article that is linked to from your root index.
      assets/    <- All pngs, gifs live here.
```

## docs/README.md template

Use the following template command as a starting point for component documentation:

```bash
./scripts/apply_template ComponentName scripts/templates/component/docs/README.md.template components/ComponentName/docs/README.md
```

This will create a README.md in your component's `docs/` directory.

### .vars file

The `.vars` defines common template variables for a component. This file should be a list of
`variable_name=value` lines.

The list of possible variables are:

```markdown
component=
component_name=
a_component_name=
root_path=
icon_id=
short_description=
color_themer_api=
typography_themer_api=
themer_parameter_name=
guidelines_short_link=
guidelines_title=
```

If a variable is not provided and a template requires it, then the template will be generated with
the missing variables shown as placeholders still.

### Badges

To generate badges for a component, use the following snippet.

```markdown
<!-- badges -->
```

### Design & API links

To generate design and API links, use the following snippet. Note that this requires that you've
installed [jazzy](https://github.com/realm/jazzy).

```markdown
<!-- design-and-api -->
```

### Embedding articles

To embed an article in the generated readme, use the following syntax:

```markdown
- [Article title](article-file.md)
```

### Showing a table of contents

The following snippet will tell the readme generator to create a table of contents.

```markdown
<!-- toc -->
```

### Showing installation steps

Use the following snippet to generate installation docs for your component:

```markdown
## Installation

- [Typical installation](../../../docs/component-installation.md)
```

- - -

## Generating documentation

To generate the root README.md file for a given component, run:

```bash
./scripts/generate_readme ActivityIndicator
```

This will generate the root README.md from `docs/README.md` and any linked-to articles.
