// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "MaterialButtons.h"
#import "MDCFloatingButtonModeAnimator.h"
#import "MDCFloatingButtonModeAnimatorDelegate.h"

#import <XCTest/XCTest.h>

@interface MDCFloatingButtonModeAnimatorTests : XCTestCase <MDCFloatingButtonModeAnimatorDelegate>
@property(nonatomic, strong) MDCFloatingButtonModeAnimator *animator;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIView *containerView;
@property(nonatomic, strong) UIView *buttonView;
@property(nonatomic) BOOL delegateDidAskToCommitLayoutChanges;
@end

static const CGRect kNormalFrame = (CGRect){{0, 0}, {100, 50}};
static const CGRect kExpandedFrame = (CGRect){{0, 0}, {200, 40}};

@implementation MDCFloatingButtonModeAnimatorTests

- (void)setUp {
  [super setUp];

  self.containerView = [[UIView alloc] init];
  self.buttonView = [[UIView alloc] init];
  self.titleLabel = [[UILabel alloc] init];
  self.titleLabel.text = @"Some text";

  self.buttonView.frame = kNormalFrame;

  self.containerView.frame = self.buttonView.bounds;
  self.containerView.autoresizingMask =
      (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
  [self.buttonView addSubview:self.containerView];

  [self.titleLabel sizeToFit];
  self.titleLabel.center = CGPointMake(CGRectGetMidX(self.containerView.bounds),
                                       CGRectGetMidY(self.containerView.bounds));
  self.titleLabel.autoresizingMask =
      (UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin |
       UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin);
  [self.containerView addSubview:self.titleLabel];

  self.animator = [[MDCFloatingButtonModeAnimator alloc] initWithTitleLabel:self.titleLabel
                                                    titleLabelContainerView:self.containerView];
  self.delegateDidAskToCommitLayoutChanges = NO;
}

- (void)tearDown {
  self.titleLabel = nil;
  self.containerView = nil;
  self.buttonView = nil;
  self.animator = nil;
  self.delegateDidAskToCommitLayoutChanges = NO;

  [super tearDown];
}

#pragma mark - MDCFloatingButtonModeAnimatorDelegate

- (void)floatingButtonModeAnimatorCommitLayoutChanges:(MDCFloatingButtonModeAnimator *)modeAnimator
                                                 mode:(MDCFloatingButtonMode)mode {
  self.delegateDidAskToCommitLayoutChanges = YES;
  [self commitMode:mode];
}

#pragma mark - Defaults

- (void)testDefaults {
  XCTAssertNil(self.animator.delegate);
  XCTAssertFalse(self.containerView.clipsToBounds);
  XCTAssertEqual([[self.titleLabel.layer animationKeys] count], 0);
  XCTAssertEqual([self.containerView.subviews count], 1);
}

#pragma mark - Container
// The only effect the animator has on the container is to toggle clipsToBounds while animating.

#pragma mark Non-animated

- (void)testImmediateToNormalContainerDoesNotClip {
  // When
  [self.animator modeDidChange:MDCFloatingButtonModeNormal
                      animated:NO
              animateAlongside:nil
                    completion:nil];

  // Then
  XCTAssertFalse(self.containerView.clipsToBounds);
}

- (void)testImmediateToExpandedContainerDoesNotClip {
  // When
  [self.animator modeDidChange:MDCFloatingButtonModeExpanded
                      animated:NO
              animateAlongside:nil
                    completion:nil];

  // Then
  XCTAssertFalse(self.containerView.clipsToBounds);
}

#pragma mark Animated

- (void)testAnimateToNormalContainerDoesClip {
  // When
  [self.animator modeDidChange:MDCFloatingButtonModeNormal
                      animated:YES
              animateAlongside:nil
                    completion:nil];

  // Then
  XCTAssertTrue(self.containerView.clipsToBounds);
}

- (void)testAnimateToExpandedContainerDoesClip {
  // When
  [self.animator modeDidChange:MDCFloatingButtonModeExpanded
                      animated:YES
              animateAlongside:nil
                    completion:nil];

  // Then
  XCTAssertTrue(self.containerView.clipsToBounds);
}

#pragma mark - Title label

#pragma mark Non-animated

- (void)testImmediateToExpandedDoesNotAskToCommitLayoutChanges {
  // Given
  self.animator.delegate = self;

  // When
  [self.animator modeDidChange:MDCFloatingButtonModeExpanded
                      animated:NO
              animateAlongside:nil
                    completion:nil];

  // Then
  XCTAssertFalse(self.delegateDidAskToCommitLayoutChanges);
}

- (void)testImmediateToNormalDoesNotAskToCommitLayoutChanges {
  // Given
  self.animator.delegate = self;

  // When
  [self.animator modeDidChange:MDCFloatingButtonModeNormal
                      animated:NO
              animateAlongside:nil
                    completion:nil];

  // Then
  XCTAssertFalse(self.delegateDidAskToCommitLayoutChanges);
}

#pragma mark Animated

- (void)testAnimateToExpandedAsksToCommitLayoutChanges {
  // Given
  self.animator.delegate = self;

  // When
  [self.animator modeDidChange:MDCFloatingButtonModeExpanded
                      animated:YES
              animateAlongside:nil
                    completion:nil];

  // Then
  XCTAssertTrue(self.delegateDidAskToCommitLayoutChanges);
}

- (void)testAnimateToNormalAsksToCommitLayoutChanges {
  // Given
  self.animator.delegate = self;

  // When
  [self.animator modeDidChange:MDCFloatingButtonModeExpanded
                      animated:YES
              animateAlongside:nil
                    completion:nil];

  // Then
  XCTAssertTrue(self.delegateDidAskToCommitLayoutChanges);
}

- (void)testAnimateFromNormalToExpandedGeneratesLabelAnimations {
  // Given
  self.animator.delegate = self;

  // When
  [self.animator modeDidChange:MDCFloatingButtonModeExpanded
                      animated:YES
              animateAlongside:nil
                    completion:nil];

  // Then
  NSSet *animatedKeyPaths = [self animatedKeyPathsForLayer:self.titleLabel.layer];
  NSSet *expectedKeyPaths = [NSSet setWithObjects:@"position.y", @"opacity", nil];
  XCTAssertEqualObjects(animatedKeyPaths, expectedKeyPaths);
}

- (void)testAnimateFromNormalToNormalDoesNotGenerateLabelAnimations {
  // Given
  self.animator.delegate = self;

  // When
  [self.animator modeDidChange:MDCFloatingButtonModeNormal
                      animated:YES
              animateAlongside:nil
                    completion:nil];

  // Then
  XCTAssertEqual([[self.titleLabel.layer animationKeys] count], 0);
}

// Does not generate animations because it animates a replica view instead.
- (void)testAnimateFromExpandedToNormalDoesNotGenerateLabelAnimations {
  // Given
  [self commitMode:MDCFloatingButtonModeExpanded];
  self.animator.delegate = self;

  // When
  [self.animator modeDidChange:MDCFloatingButtonModeNormal
                      animated:YES
              animateAlongside:nil
                    completion:nil];

  // Then
  XCTAssertEqual([[self.titleLabel.layer animationKeys] count], 0);
}

#pragma mark - Blocks

#pragma mark Non-animated

- (void)testImmediateToExpandedInvokesAnimateAlongsideAndCompletion {
  // When
  __block BOOL didInvokeAnimateAlongside = NO;
  __block BOOL didInvokeCompletion = NO;
  [self.animator modeDidChange:MDCFloatingButtonModeExpanded
      animated:NO
      animateAlongside:^{
        didInvokeAnimateAlongside = YES;
      }
      completion:^(BOOL finished) {
        didInvokeCompletion = YES;
      }];

  // Then
  XCTAssertTrue(didInvokeAnimateAlongside);
  XCTAssertTrue(didInvokeCompletion);
}

- (void)testImmediateToNormalInvokesAnimateAlongsideAndCompletion {
  // When
  __block BOOL didInvokeAnimateAlongside = NO;
  __block BOOL didInvokeCompletion = NO;
  [self.animator modeDidChange:MDCFloatingButtonModeNormal
      animated:NO
      animateAlongside:^{
        didInvokeAnimateAlongside = YES;
      }
      completion:^(BOOL finished) {
        didInvokeCompletion = YES;
      }];

  // Then
  XCTAssertTrue(didInvokeAnimateAlongside);
  XCTAssertTrue(didInvokeCompletion);
}

#pragma mark Animated

- (void)testAnimateToExpandedInvokesAnimateAlongsideButNotCompletion {
  // When
  __block BOOL didInvokeAnimateAlongside = NO;
  __block BOOL didInvokeCompletion = NO;
  [self.animator modeDidChange:MDCFloatingButtonModeExpanded
      animated:YES
      animateAlongside:^{
        didInvokeAnimateAlongside = YES;
      }
      completion:^(BOOL finished) {
        didInvokeCompletion = YES;
      }];

  // Then
  XCTAssertTrue(didInvokeAnimateAlongside);
  XCTAssertFalse(didInvokeCompletion);
}

- (void)testAnimateToNormalInvokesAnimateAlongsideButNotCompletion {
  // When
  __block BOOL didInvokeAnimateAlongside = NO;
  __block BOOL didInvokeCompletion = NO;
  [self.animator modeDidChange:MDCFloatingButtonModeNormal
      animated:YES
      animateAlongside:^{
        didInvokeAnimateAlongside = YES;
      }
      completion:^(BOOL finished) {
        didInvokeCompletion = YES;
      }];

  // Then
  XCTAssertTrue(didInvokeAnimateAlongside);
  XCTAssertFalse(didInvokeCompletion);
}

#pragma mark - Helper methods

- (NSSet *)animatedKeyPathsForLayer:(CALayer *)layer {
  NSMutableSet *animatedKeyPaths = [NSMutableSet set];
  NSArray *animationKeys = [layer animationKeys];
  for (NSString *key in animationKeys) {
    CAAnimation *animation = [layer animationForKey:key];
    if ([animation isKindOfClass:[CABasicAnimation class]]) {
      CABasicAnimation *basicAnimation = (CABasicAnimation *)animation;
      [animatedKeyPaths addObject:basicAnimation.keyPath];
    }
  }
  return animatedKeyPaths;
}

- (void)commitMode:(MDCFloatingButtonMode)mode {
  if (mode == MDCFloatingButtonModeNormal) {
    self.buttonView.frame = kNormalFrame;
  } else if (mode == MDCFloatingButtonModeExpanded) {
    self.buttonView.frame = kExpandedFrame;
  }
  [self.buttonView layoutIfNeeded];
}

@end
