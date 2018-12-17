# Site Development

**This document talks about Material Components for iOS site development. If you are trying to
updating the contents of site, please refer to [Site Content Update](./site_content_update.md)
instead.**


## Overview

Material Components for iOS site consists of 2 parts: [document
site](https://material.io/components/ios/) and API reference site of each components
(e.g, [AppBar
API](https://material.io/components/ios/catalog/app-bars/api-docs/Classes/MDCAppBarContainerViewController.html),
etc...)

This document will walk you through how you get the sources, modify and deploy the site. If you are
curious about how the sources are organized, you may also read the [in depth
explanation](#appendix-how) at the last of this document.


## Get the sources of the site

**If you have ever built the site (no matter run it locally or deploy to the production), you may
skip this step.**

Make sure you are under **develop** branch and have the latest code pulled. Then run the following
script.

```scripts/build_site.sh --setup```

The sources of the site will be pulled under a folder called *site-source* under your root folder of
the repository.


## Develop the site

### Develop the document site

Material component for ios uses [jekyll](https://jekyllrb.com/) to help transform the markdowns into
static HTML.

The sources *site-source/jekyll-site-src* respect the [directory structure
requirements](https://jekyllrb.com/docs/structure/) of jekyll with a few exceptions. Here is an
overview of the directory structure for mdc:

- _includes & _layout: the template used by the document site with [liquid
  tag](https://github.com/Shopify/liquid/wiki)

- _sass: the style of the document site

    - base.scss: the basic style of the default html tags. Most of the styles respect [material
      design guideline](https://material.io/guidelines/)

    - _globals.scss: the variables and responsive grid definitions.

    - _layout: the style defined for document site. You will modify this file for most of the cases.

    - _layout-api: the style defined for API reference site. This is a bit confusing but API
      reference is actually built in as part of the document site and we want to use the syle we
have for the document site.

    - _icons & _step-sequence & _codemirror-syntax-highlighting: These are the utility class for all
      icons, step by step guidance and code renderer for example code.

- css: the css that specify which above styles should be included

- _data: the definition of the navigation side bar

- other assets: images, js, thirdparty

Attention should be paid that *components*, *contributing*, *docs* are all copied files and will be
override at the time when document site is built. So if you are trying to modify the content of
these files, please read [Site Content Update](/site_content_update.md).

Since the document site uses the feature of jekyll like [Front
Matter](https://jekyllrb.com/docs/frontmatter/),
[Configure](https://jekyllrb.com/docs/configuration/), we suggest you to read jekyll's document if
you are going to develop the site.


### Develop the API reference site

Material component for ios uses [jazzy](https://github.com/realm/jazzy) to transform the inline
comments in the header files and make it into API reference document.

The sources *site-source/apidocs-site-src* contains the theme and assets. When you build the API
reference, the API reference will be generated and copied to each components folder under
*jekyll-site-src/components* and later be build as part of the document site. Because of that, if
you are trying to modify the styling of the site, we suggest you to modify
*site-source/jekyll-site-src/_scss/_layout-api.scss* instead of css in *theme/assets/css* folder.


## Deploy the site

### Serve the site locally

Run the following command and follow the hint in the command line.

    scripts/build_site.sh

The site should be served at [127.0.0.1:4000](http://127.0.0.1:4000) after build by default.


### Commit the changes

You should change your working directory into *site-source* and run git command in that folder

```
cd site-source
# and do git commit here...
```


We recommend you to read appendix at the last of this document if you want to know how the sources
are organized.


### Deploy the site to production

You need to be one of the Material component core members in order to deploy the site for the
moment. However, we will incorporate the changes to the site for every weekly cut release as well.

If you are able to deploy the site, run

```
# Run these to install gsutil for the first time
curl https://sdk.cloud.google.com | bash
exec -l $SHELL
# Set up the gsutil authentication information, it doesn't matter which app engine project you
# choose.
gcloud init

# Deploy it!
scripts/build_site.sh --deploy production
```

Open [Material Component site](https://material.io/components/ios/) and make
sure your modification is there.


## TODO: Modify the site build script

## Appendix - How are the sources organized?

### Overview & Architecture Graph

Material component ios repository is the place where all components and their documents live. Just
like most of other open source projects, core developers and community members will be actively
improving the components on master/develop branch. Meanwhile, we also want our website get those
updates as soon as the changes are pushed and merged, but leave the process as simple as pull out a
rabbit from the magic hat, without you switching between branches.

The secret sauce we use is "locally nested structure", where contents and templates are separated in
2 branches (master/develop and site-source) but locally nested one under the other. It is easily to
understand with the following graph:

![mdc local folder and branch structure](./mdc-local-folder-and-branch-structure.png)

It is pretty clear that the site should be thought as 2 parts: the contents and the templates. In
our case, the contents are documents of the components.

As shown in the graph, the document lives together with the component it is documenting, so that
whoever update the component will be able to quickly find the document needed to update and commit
together with the code. On the other hand, the templates live on another branch called "site-source"
and they describe what the website should be look like. Since we separate contents and templates
into branches, it decouples site and components development.

But then how can we let the developers preview their updates to make sure they are not breaking the
site? The answer lies in the local folder structure. In the repository folder, we cloned another
repository, put it in a folder called site-source and switch the branch in that folder to
site-source. Let's actually look at the build process to see what is happening there. But before we
dive into that, we should also re-emphasize that this folder is gitignored so git won't ever notice
nor ever commit you local build and previews.

### Build Process

The build process has 2 steps:

- Build the api reference
- Build the document site

Since the api reference is part of the contents of the document site, so step 1 need to be carried
out before step 2.

In step 1, we build the api reference from the inline comments of the components using
[Jazzy](./site_content_update.md#api-reference). The api reference are output to the jekyll folder
in preparation for step 2.

In step 2, the documents sepcified in ```site-source/jekyll-site-src/_data/navigation.yaml``` are
copied to the corresponding place and rename to index.md for servering purpose. Jekyll processes
these files and generates static html into ```site-source/site-build```.

After build, local server might run servering the static html for developer to preview or it will be
deployed to the production server. We would like to add a git hook, so that when update get merged
into master branch, the site will be rebuild and pushed at the same time secretly from the
developer.


### Intent behind this

Although the structure seems hard to understand at first glance, it have several benefits once you
get the gists.

- Benefits of decoupling

  The components developers and site developers' work should not ever interfere with each other. We
need to ensure in the worst scenario that if one of them need to roll back several commits, the
other team should not even notice that happened, which obviously cannot be achieved if the contents
and templates lives in the same branch.

- Single source of truth and clear responsibility

  There is only a single source of the truth for both the contents and templates. While the site
developer has the authority for styling the site as they like, they probably won't have insights of
the detailed contents that should be put on the website, component developers vise versa. We barely
defined the syntax as the protocol for communication, so each party can work on its own thing and
hold their absolute authority on that.

- Preserve document on github

  Since we only have one set of truth for content and all the other are clearly copies of them, we
preserve the README.md in the place that github can still find them, so you can read them directly
on github and even if you are not linked to the internet, you will be able to see all document in
your local repository

- Benefit of non-blocking

  The component developers should never be blocked by the site developers when updating the content,
nor should bother the site developers to stop what they are doing and help them with merely an
content update. In this case, we are not only separating the authority but also make it possible for
each party to update on their own pace.

- Intuitively find what you need to update

  The site has exactly 1:1 map onto the source that generate the page. For example, if you are
updating the components/Button/ page, you can find the document right at
components/Button/README.md, which is also right besides the Button.h and Button.m file

- Simply works

  You actually don't need to understand all the structure if you are not curious. You can write the
components, update the documents and preview, or you can update the style and see without switch
branches. You don't need to understand all the nitty-gritty about all these, it simply works.
