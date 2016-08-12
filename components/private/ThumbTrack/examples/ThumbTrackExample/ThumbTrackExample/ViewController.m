/*
 Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.

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

#import "ViewController.h"

#import "MaterialColor.h"
#import "MaterialThumbTrack.h"

@implementation ViewController {
  MDCThumbTrack *_thumbTrack;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.

  self.view.backgroundColor = [UIColor grayColor];

  CGRect trackFrame = self.view.frame;

  // TODO(iangordon): Determine why setting a non-zero dy inset below breaks the ThumbView location.
  trackFrame = CGRectInset(trackFrame, 8.f, 0.f);
  UIColor *color = [UIColor blueColor];
  _thumbTrack = [[MDCThumbTrack alloc] initWithFrame:trackFrame onTintColor:color];
  _thumbTrack.continuousUpdateEvents = NO;
  _thumbTrack.trackHeight = 14.0;
  _thumbTrack.thumbRadius = 10.0;
  _thumbTrack.trackEndsAreRounded = YES;
  _thumbTrack.interpolateOnOffColors = YES;
  _thumbTrack.numDiscreteValues = 2;
  _thumbTrack.thumbView.borderWidth = 1;
  _thumbTrack.thumbView.hasShadow = YES;
  _thumbTrack.panningAllowedOnEntireControl = YES;
  _thumbTrack.tapsAllowedOnThumb = YES;
  _thumbTrack.shouldDisplayInk = NO;
  _thumbTrack.value = _thumbTrack.maximumValue;

  [self.view addSubview:_thumbTrack];
}

@end
