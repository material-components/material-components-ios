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

#import "CBCNodeListViewController.h"

#import "CBCCatalogExample.h"
#import "CBCRuntime.h"

@implementation CBCNode {
  NSMutableDictionary *_map;
  NSMutableArray *_children;
  Class _exampleClass;
}

- (instancetype)initWithTitle:(NSString *)title {
  self = [super init];
  if (self) {
    _title = [title copy];
    _map = [NSMutableDictionary dictionary];
    _children = [NSMutableArray array];
    CBCFixViewDebuggingIfNeeded();
  }
  return self;
}

- (NSComparisonResult)compare:(CBCNode *)otherObject {
  return [self.title compare:otherObject.title];
}

- (void)addChild:(CBCNode *)child {
  _map[child.title] = child;
  [_children addObject:child];
}

- (NSDictionary *)map {
  return _map;
}

- (void)setExampleClass:(Class)exampleClass {
  _exampleClass = exampleClass;
}

- (void)finalize {
  _children = [[_children sortedArrayUsingSelector:@selector(compare:)] mutableCopy];
}

#pragma mark Public

- (BOOL)isExample {
  return _exampleClass != nil;
}

- (NSString *)exampleViewControllerName {
  return NSStringFromClass(_exampleClass);
}

- (UIViewController *)createExampleViewController {
  NSAssert(_exampleClass != nil, @"This node has no associated example.");
  return CBCViewControllerFromClass(_exampleClass);
}

- (NSString *)exampleDescription {
  NSAssert(_exampleClass != nil, @"This node has no associated example.");
  return CBCDescriptionFromClass(_exampleClass);
}

- (BOOL)isPrimaryDemo {
  return CBCCatalogIsPrimaryDemoFromClass(_exampleClass);
}

@end

@implementation CBCNodeListViewController

- (instancetype)initWithNode:(CBCNode *)node {
  NSAssert(!_node.isExample, @"%@ cannot represent example nodes.",
           NSStringFromClass([self class]));

  self = [super initWithNibName:nil bundle:nil];
  if (self) {
    _node = node;

    self.title = _node.title;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.tableView =
      [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
  self.tableView.autoresizingMask =
      (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  NSIndexPath *selectedRow = self.tableView.indexPathForSelectedRow;
  if (selectedRow) {
    [[self transitionCoordinator] animateAlongsideTransition:^(id context) {
      [self.tableView deselectRowAtIndexPath:selectedRow animated:YES];
    }
        completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
          if ([context isCancelled]) {
            [self.tableView selectRowAtIndexPath:selectedRow
                                        animated:NO
                                  scrollPosition:UITableViewScrollPositionNone];
          }
        }];
  }
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];

  [self.tableView flashScrollIndicators];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [_node.children count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
  if (!cell) {
    cell =
        [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
  }
  cell.textLabel.text = [_node.children[indexPath.row] title];
  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  CBCNode *node = _node.children[indexPath.row];
  UIViewController *viewController = nil;
  if ([node isExample]) {
    viewController = [node createExampleViewController];
  } else {
    viewController = [[[self class] alloc] initWithNode:node];
  }
  [self.navigationController pushViewController:viewController animated:YES];
}

@end

CBCNode *CBCCreateNavigationTree(void) {
  NSArray *allClasses = CBCGetAllClasses();
  NSArray *classes = CBCClassesRespondingToSelector(allClasses, @selector(catalogBreadcrumbs));

  CBCNode *tree = [[CBCNode alloc] initWithTitle:@"Root"];
  for (Class aClass in classes) {
    // Each example view controller defines its own "breadcrumbs".

    NSArray *breadCrumbs = CBCCatalogBreadcrumbsFromClass(aClass);

    // Walk down the navigation tree one breadcrumb at a time, creating nodes along the way.

    CBCNode *node = tree;
    for (NSUInteger ix = 0; ix < [breadCrumbs count]; ++ix) {
      NSString *title = breadCrumbs[ix];
      BOOL isLastCrumb = ix == [breadCrumbs count] - 1;

      // Don't walk the last crumb

      if (node.map[title] && !isLastCrumb) {
        node = node.map[title];
        continue;
      }

      CBCNode *child = [[CBCNode alloc] initWithTitle:title];
      [node addChild:child];
      node = child;
    }

    node.exampleClass = aClass;
  }

  // Perform final post-processing on the nodes.
  NSMutableArray *queue = [NSMutableArray arrayWithObject:tree];
  while ([queue count] > 0) {
    CBCNode *node = [queue firstObject];
    [queue removeObjectAtIndex:0];
    [queue addObjectsFromArray:node.children];

    [node finalize];
  }

  return tree;
}
