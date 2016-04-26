/*
 Copyright 2016-present Google Inc. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

/**
 The CBCCatalogExample protocol defines methods that examples are expected to implement in order to
 customize their location and behavior in the Catalog by Convention.

 Examples should not formally conform to this protocol. Examples should simply implement these
 methods by convention.
 */
@protocol CBCCatalogExample <NSObject>

/** Return a list of breadcrumbs defining the navigation path taken to reach this example. */
+ (nonnull NSArray<NSString *> *)catalogBreadcrumbs;

/**
 Return a BOOL stating whether this example should be treated as the main "Demo" in the Catalog
 for this component
 */
+ (BOOL)catalogIsPrimaryDemo;

@optional

/**
 Return the name of a UIStoryboard from which the example's view controller should be instantiated.
 */
- (nonnull NSString *)catalogStoryboardName;

/** Return a description of the example. */
- (nonnull NSString *)catalogDescription;

@end
