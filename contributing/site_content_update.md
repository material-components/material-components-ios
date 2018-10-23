# Site Content Update

## Overview
Material Components for iOS site consists of 2 parts:
[document site](https://material.io/components/ios/) and API reference site of each
components (e.g,
[AppBar API](https://material.io/components/ios/catalog/app-bars/api-docs/Classes/MDCAppBarContainerViewController.html), etc...)

This document will walk you through the process for updating the contents on
document site and API reference, or adding new sections to the document site.
You only need to edit markdown files in most cases, however, if you wish to make
further changes to the templates, please read to [Site
Development](./site_development.md).


## Updating Content

### Document Site and GitHub README.md

#### Syntax

The Material Components site uses [Jekyll](https://jekyllrb.com/) to help
transform Markdown files into static HTML. This means although it is consistent
with GitHub Flavored Markdown for most cases, we do have some style classes and
special javascript to handle complicate rendering for the website. Please refer
to [Writing READMES](./writing_readmes.md) for the syntax we use.

#### Structure

The document site and GitHub README.md have the exact 1:1 mapping structure, except for the homepage.

- homepage -> site-index.md
- docs -> docs/README.md
- docs/[tutorial_name] -> docs/[tutorial_name]/README.md
- components -> components/README.md
- components/[component_name] -> components/[component_name]/README.md
- contributing -> contributing/README.md

#### Add new sections

If you are going to add new sections to the website, you need to modify the configuration file, so that the build system will be aware of the modified structure during build process.

To set it up, run

```
scripts/build_site.sh --setup

# Modify the navigation data file
vim site-source/jekyll-site-src/_data/navigation.yaml
```

In this case, you should change your working directory into `site-source` and run any git commands in that folder.

```
cd site-source
# and do git commit & push here...
```

This relates to how the site is organized. If you are curious about that, you may read the appendix at the end of [Site Development](./site_development.md).

### API Reference

Material Components for iOS uses [jazzy](https://github.com/realm/jazzy) to transform the inline comments in the header files and make it into API reference document. See [their syntax](https://github.com/realm/jazzy#supported-keywords) for updating inline comments in components header files.

## Build and Preview locally

Run the following command and follow the instructions on the command line.

    scripts/build_site.sh

The site should be served at [127.0.0.1:4000](http://127.0.0.1:4000) after build by default.

## Deploy to production

You need to be one of the Material Components for iOS core members in order to deploy the site for the moment. However, we will incorporate the changes to the site for every weekly cut release as well.

If you are able to deploy the site, run

```bash
# Run these to install gsutil for the first time
curl https://sdk.cloud.google.com | bash
exec -l $SHELL
#Set up the gsutil authentication information, it doesn't matter which app engine project you choose.
gcloud init

# Deploy it!
scripts/build_site.sh --deploy production
```

Open the [Material Components for iOS](https://material.io/components/ios/) site
and make sure your modification is there.
