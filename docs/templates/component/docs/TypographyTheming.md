<!--docs:
title: "Typography Theming"
layout: detail
section: components
excerpt: "How to theme <#component_name#> using the Material Design typography system."
path: <#root_path#>/TypographyTheming/
-->

# <#component_name#> Typography Theming

You can theme <#a_component_name#> with your app's typography scheme using the TypographyThemer
extension.

You must first add the Typography Themer extension to your project:

``` bash
pod 'MaterialComponents/<#component#>+Extensions/TypographyThemer'
```

## Example code

<!--<div class="material-code-render" markdown="1">-->
#### Swift
``` swift
import MaterialComponents.Material<#component#>_TypographyThemer

let typographyScheme = MDCTypographyScheme()

let component: <#component_symbol#>
<#themer_api#>.applyTypographyScheme(typographyScheme, to: component)
```

#### Objective-C

``` objc
#import "Material<#component#>+TypographyThemer.h"

id<MDCTypographyScheming> typographyScheme = [[MDCTypographyScheme alloc] init];

<#component_symbol#> *component;
[<#themer_api#> applyTypographyScheme:colorScheme
                  to<#component_parameter#>:component];
```
<!--</div>-->
