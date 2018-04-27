### Theming

You can theme a <#component_name#> with your app's typography scheme using the TypographyThemer
extension.

You must first add the Typography Themer extension to your project:

``` bash
pod 'MaterialComponents/<#component#>+Extensions/TypographyThemer'
```

You can then import the theming APIs:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
``` swift
import MaterialComponents.Material<#component#>_TypographyThemer
```

#### Objective-C

``` objc
#import "Material<#component#>+TypographyThemer.h"
```
<!--</div>-->

<#themer_api#> allows you to theme a <#component_name#> with your app's typography
scheme.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
``` swift
let typographyScheme: MDCSemanticTypographyScheme()

let component: <#component_symbol#>
<#ThemerAPI#>.applyTypographyScheme(typographyScheme, to: component)
```

#### Objective-C

``` objc
id<MDCTypographyScheming> typographyScheme = [[MDCTypographyScheme alloc] init];

<#component_symbol#> *component;
[<#ThemerAPI#> applyTypographyScheme:colorScheme
                  to<#component_parameter#>:component];
```
<!--</div>-->
