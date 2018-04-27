### Theming

You can theme a <#component_name#> with your app's color scheme using the ColorThemer extension.

You must first add the Color Themer extension to your project:

``` bash
pod 'MaterialComponents/<#component#>+Extensions/ColorThemer'
```

You can then import the theming APIs:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
``` swift
import MaterialComponents.Material<#component#>_ColorThemer
```

#### Objective-C

``` objc
#import "Material<#component#>+ColorThemer.h"
```
<!--</div>-->

<#themer_api#> allows you to theme a <#component_name#> with your app's color
scheme.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
``` swift
let colorScheme: MDCSemanticColorScheme()

let component: <#component_symbol#>
<#ThemerAPI#>.applySemanticColorScheme(colorScheme, to: component)
```

#### Objective-C

``` objc
id<MDCColorScheming> colorScheme = [[MDCSemanticColorScheme alloc] init];

<#component_symbol#> *component;
[<#ThemerAPI#> applySemanticColorScheme:colorScheme
                              to<#component_parameter#>:component];
```
<!--</div>-->
