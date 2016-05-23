# Site Development

**This document talks about material components for ios site development. If you are trying to updating the contents of site, please refer to [Site Content Update](./site_content_update.md) instead.**


## Overview

Material components for ios site consists of 2 parts: [document site](https://material-ext.appspot.com/mdc-ios-preview/) and API reference site of each components (e.g, [AppBar API](https://material-ext.appspot.com/mdc-ios-preview/components/AppBar/apidocs/Classes/MDCAppBarContainerViewController.html), etc...)

This document will walk you through how you get the sources, modify and deploy the site. If you are curious about how the sources are organized, you may also read the [in depth explanation](#appendix-how) at the last of this document.


## Get the sources of the site

**If you have ever built the site (no matter run it locally or deploy to the production), you may skip this step.**

Make sure you are under **develop** branch and have the latest code pulled. Then run the following script.

```scripts/build-site.sh --setup```

The sources of the site will be pulled under a folder called *site-source* under your root folder of the repository.


## Develop the site

### Develop the document site

Material component for ios uses [jekyll](https://jekyllrb.com/) to help transform the markdowns into static HTML.

The sources *site-source/jekyll-site-src* respect the [directory structure requirements](https://jekyllrb.com/docs/structure/) of jekyll with a few exceptions. Here is an overview of the directory structure for mdc:

- _includes & _layout: the template used by the document site with [liquid tag](https://github.com/Shopify/liquid/wiki)

- _sass: the style of the document site

    - base.scss: the basic style of the default html tags. Most of the styles respect [material design guideline](https://www.google.com/design/spec/)

    - _globals.scss: the variables and responsive grid definitions.

    - _layout: the style defined for document site. You will modify this file for most of the cases.

    - _layout-api: the style defined for API reference site. This is a bit confusing but API reference is actually built in as part of the document site and we want to utilize the syle we have for the document site.

    - _icons & _step-sequence & _codemirror-syntax-highlighting: These are the utility class for all icons, step by step guidance and code renderer for example code.

- css: the css that specify which above styles should be included

- _data: the definition of the navigation side bar

- other assets: images, js, thirdparty

Attention should be paid that *components*, *contributing*, *howto* are all copied files and will be override at the time when document site is built. So if you are trying to modify the content of these files, please read [Site Content Update](/site_content_update.md).

Since the document site uses the feature of jekyll like [Front Matter](https://jekyllrb.com/docs/frontmatter/), [Configure](https://jekyllrb.com/docs/configuration/), we suggest you to read jekyll's document if you are going to develop the site.


### Develop the API reference site

Material component for ios uses [jazzy](https://github.com/realm/jazzy) to transform the inline comments in the header files and make it into API reference document. 

The sources *site-source/apidocs-site-src* contains the theme and assets. When you build the API reference, the API reference will be generated and copied to each components folder under *jekyll-site-src/components* and later be build as part of the document site. Because of that, if you are trying to modify the styling of the site, we suggest you to modify *site-source/jekyll-site-src/_scss/_layout-api.scss* instead of css in *theme/assets/css* folder.


## Deploy the site

### Serve the site locally

Run the following command and follow the hint in the command line.

    scripts/build-site.sh 

The site should be served at [127.0.0.1:4000](http://127.0.0.1:4000) after build by default.


### Commit the changes

You should change your working directory into *site-source* and run git command in that folder

```
cd site-source
# and do git commit here...
```


We recommand you to read appendix at the last of this document if you want to know how the sources are organized.


### Deploy the site to production

You need to be one of the material component core members in order to deploy the site for the moment. However, we will incorporate the changes to the site for every weekly cut release as well.

If you are able to deploy the site, run

```
# Run these to install gsutil for the first time
curl https://sdk.cloud.google.com | bash
exec -l $SHELL 
#Set up the gsutil authentication information, it doesn't matter which app engine project you choose.
gcloud init  

# Deploy it!
scripts/build-site.sh --deploy production
```

Open [Material Component site](https://material-ext.appspot.com/mdc-ios-preview) and make sure your modification is there.


## TODO: Modify the site build script

## TODO: Apendix - How is the sources organized? 

All site sources lives in the same repository but in a separate branch called *site-source* apart from the sources of the library(**master** or **develop**) to remain independency. 

