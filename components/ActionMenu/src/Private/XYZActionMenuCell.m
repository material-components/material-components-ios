/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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

@implementation XYZActionMenuCell

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    _optionView = [[XYZActionMenuOptionView alloc] initWithFrame:frame];
    [self.contentView addSubview:_optionView];
  }
  return self;
}

/**
 * The cell may be larger than the option. Determine if the option was hit.
 *
 * @param point A point specified in the receiver’s local coordinate system (bounds).
 * @param event The event that warranted a call to this method. If you are calling this method from
 *     outside your event-handling code, you may specify nil.
 *
 * @return The option view if the interaction happened inside of it, otherwise nil.
 */
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
  CGPoint contentViewPoint = [self convertPoint:point toView:self.contentView];
  return CGRectContainsPoint(self.optionView.frame, contentViewPoint) ? self.optionView : nil;
}

- (void)prepareForReuse {
  [super prepareForReuse];
  self.optionView.option = nil;
}

- (void)positionRelativeToFrame:(CGRect)frame {
  CGFloat primaryFABCenter = frame.origin.x + (frame.size.width / 2);
  CGRect optionFABFrame = self.optionView.floatingActionButton.frame;
  CGFloat optionX = primaryFABCenter - (optionFABFrame.size.width / 2) - optionFABFrame.origin.x;
  CGSize optionSize = self.optionView.bounds.size;
  self.optionView.frame = CGRectMake(optionX, 0, optionSize.width, optionSize.height);
}

@end
