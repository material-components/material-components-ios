/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCTextInputTitleView.h"

#import "MDCTextInput+Internal.h"
#import "MaterialPalettes.h"


static inline UIColor *MDCTextInputInlinePlaceholderTextColor() {
  return [UIColor colorWithWhite:0 alpha:MDCTextInputHintTextOpacity];
}


@implementation MDCTextInputTitleView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    CGFloat contentsScale = [[UIScreen mainScreen] scale];
    CALayer *layer = [self layer];
    CGRect bounds = [self bounds];

    _backLayer = [[CATextLayer alloc] init];
    [_backLayer setForegroundColor:MDCTextInputInlinePlaceholderTextColor().CGColor];
    [_backLayer setContentsScale:contentsScale];
    [_backLayer setFrame:bounds];
    [layer addSublayer:_backLayer];

    _frontLayer = [[CATextLayer alloc] init];
    [_frontLayer setForegroundColor:[MDCPalette indigoPalette].tint500.CGColor];
    [_frontLayer setContentsScale:contentsScale];
    [_frontLayer setFrame:bounds];
    [_frontLayer setOpacity:0];
    [layer addSublayer:_frontLayer];
  }

  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  CGRect bounds = [self bounds];
  [_frontLayer setFrame:bounds];
  [_backLayer setFrame:bounds];
}

#pragma mark - Property implementation

- (CGColorRef)frontLayerColor {
  return [_frontLayer foregroundColor];
}

- (void)setFrontLayerColor:(CGColorRef)frontLayerColor {
  [_frontLayer setForegroundColor:frontLayerColor];
}

- (CGColorRef)backLayerColor {
  return [_backLayer foregroundColor];
}

- (void)setBackLayerColor:(CGColorRef)backLayerColor {
  [_backLayer setForegroundColor:backLayerColor];
}

- (id)string {
  return [_frontLayer string];
}

- (void)setString:(id)string {
  [_frontLayer setString:string];
  [_backLayer setString:string];
}

- (void)setFont:(UIFont *)font {
  _font = font;

  CGFontRef cgFont = CGFontCreateWithFontName((__bridge CFStringRef)[_font fontName]);
  if (cgFont) {
    [_frontLayer setFont:cgFont];
    [_backLayer setFont:cgFont];

    CGFloat fontSize = [_font pointSize];
    [_frontLayer setFontSize:fontSize];
    [_backLayer setFontSize:fontSize];

    CFRelease(cgFont);
  }
}

@end
