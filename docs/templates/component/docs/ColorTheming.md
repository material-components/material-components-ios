<!--docs:
title: "Color Theming"
layout: detail
section: components
excerpt: "How to theme <#component_name#> using the Material Design color system."
iconId: <#icon_id#>
path: <#root_path#>/ColorTheming/
-->

# <#component_name#> Color Theming

You can theme <#a_component_name#> with your app's color scheme using the ColorThemer extension.

You must first add the Color Themer extension to your project:

``` bash
pod 'MaterialComponents/<#component#>+Extensions/ColorThemer'
```

<#themer_api#> allows you to theme <#a_component_name#> with your app's color
scheme.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
``` swift
import MaterialComponents.Material<#component#>_ColorThemer

let colorScheme = MDCSemanticColorScheme()

let component: <#component_symbol#>
<#themer_api#>.applySemanticColorScheme(colorScheme, to: component)
```

#### Objective-C

``` objc
#import "Material<#component#>+ColorThemer.h"

id<MDCColorScheming> colorScheme = [[MDCSemanticColorScheme alloc] init];

<#component_symbol#> *component;
[<#themer_api#> applySemanticColorScheme:colorScheme
                              to<#component_parameter#>:component];
```
<!--</div>-->
