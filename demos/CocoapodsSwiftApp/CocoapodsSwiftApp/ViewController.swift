/*
Copyright 2015-present Google Inc. All Rights Reserved.

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

import UIKit

import material_components_ios

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    // Testing build and linking so all we need to do is touch the component objects.

    // MARK: Slider
    let slider = MDCSlider.init(frame: CGRectMake(0, 0, 100, 27));
    self.view.addSubview(slider);
    slider.center = CGPointMake(100, 45);

    // MARK: Typography
    assert(MDCTypography.subheadFont().isKindOfClass(UIFont), "expecting valid object");

    // MARK: Ink
    MDCInkTouchController.init(view: self.view)!;

    // MARK: ScrollViewDelegateMultiplexer

    assert(MDCScrollViewDelegateMultiplexer.init().isKindOfClass(MDCScrollViewDelegateMultiplexer),
      "expecting valid object");

    // MARK: ShadowLayer

    assert(MDCShadowLayer.init().isKindOfClass(MDCShadowLayer), "expecting valid object");

    // MARK: SpritedAnimation

    assert(MDCSpritedAnimationView.init().isKindOfClass(MDCSpritedAnimationView), "expecting valid object");

    // MARK: PageControl

    let pageControl = MDCPageControl.init(frame:CGRectMake(0, 0, 100, 27));
    pageControl.numberOfPages = 3;
    self.view.addSubview(pageControl);
    pageControl.center = CGPointMake(100, 145);

  }
}
