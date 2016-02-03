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

class MDCBuildTestViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    // Testing build and linking so all we need to do is touch the component objects.

    // MARK: Slider
    let slider = MDCSlider.init(frame: CGRectMake(0, 0, 100, 27));
    self.view.addSubview(slider);
    slider.center = CGPointMake(100, 45);
    assert(slider.isKindOfClass(MDCSlider), "Expecting to find a valid object for MDCSlider");

    // MARK: Typography
    assert(MDCTypography.subheadFont().isKindOfClass(UIFont), "Expecting to find a valid object for MDCTypography");

    // MARK: Ink
    MDCInkTouchController.init(view: self.view)!;

    // MARK: ScrollViewDelegateMultiplexer
    assert(MDCScrollViewDelegateMultiplexer.init().isKindOfClass(MDCScrollViewDelegateMultiplexer),
      "Expecting to find a valid object for MDCScrollViewDelegateMultiplexer");

    // MARK: ShadowLayer
    assert(MDCShadowLayer.init().isKindOfClass(MDCShadowLayer), "Expecting to find a valid object for MDCShadowLayer");

    // MARK: SpritedAnimation
    assert(MDCSpritedAnimationView.init().isKindOfClass(MDCSpritedAnimationView), "Expecting to find a valid object for MDCSpritedAnimationView");

    // MARK: PageControl
    let pageControl = MDCPageControl.init(frame:CGRectMake(0, 0, 100, 27));
    pageControl.numberOfPages = 3;
    self.view.addSubview(pageControl);
    pageControl.center = CGPointMake(100, 145);
    assert(pageControl.isKindOfClass(MDCPageControl), "Expecting to find a valid object for MDCSpritedAnimationView");

    // MARK: Buttons
    assert(MDCButton.init().isKindOfClass(MDCButton), "Expecting to find a valid object for MDCButton");

  }
}
