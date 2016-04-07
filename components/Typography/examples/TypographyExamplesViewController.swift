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

import MaterialComponents

class TypographyExampleViewCell: UICollectionViewCell {

  var cellSize = CGSizeZero
  let textView = UITextView()
  let label = UILabel()
  let offset = CGFloat(-5)

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = UIColor.whiteColor()
    textView.text = "Example Text"
    textView.editable = false
    textView.scrollEnabled = false

    textView.contentInset = UIEdgeInsetsMake(offset, offset, offset, offset);
    self.addSubview(textView)

    label.text = "Font Style Name"
    label.alpha =  MDCTypography.captionFontOpacity()
    label.font = MDCTypography.captionFont()
    label.frame = CGRectMake(0,
      frame.size.height - (label.font.pointSize + 2), frame.size.width, label.font.pointSize + 2)
    label.autoresizingMask = [.FlexibleTopMargin, .FlexibleWidth]
    self.addSubview(label)
  }

  required init(coder: NSCoder) {
    super.init(coder: coder)!
  }

  func populateCell(text : String, font : UIFont, opacity: CGFloat, name: String) {
    textView.text = text
    textView.font = font
    textView.alpha = opacity
    label.text = name

    let fixedWidth = self.frame.width
    textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
    let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
    var newFrame = textView.frame
    newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
    textView.frame = newFrame;
    cellSize = newFrame.size
  }

  static func cellSize(width: CGFloat, text : String, font : UIFont) -> CGSize {
    let textView = UITextView()
    textView.text = text
    textView.font = font

    let fixedWidth = width
    textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
    let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
    var newFrame = textView.frame
    let height = newSize.height + MDCTypography.captionFont().pointSize - 8
    newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: height)
    textView.frame = newFrame;
    return newFrame.size
  }

}

class TypographyExamplesViewController: UICollectionViewController {

  let strings = [
    "Material Design Components",
    "A quick brown fox jumped over the lazy dog.",
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
    "abcdefghijklmnopqrstuvwxyz",
    "1234567890",
    "!@#$%^&*()-=_+[]\\;',./<>?:\""
  ]

  let fonts = [

    // Common UI fonts.
    MDCTypography.headlineFont(),
    MDCTypography.titleFont(),
    MDCTypography.subheadFont(),
    MDCTypography.body2Font(),
    MDCTypography.body1Font(),
    MDCTypography.captionFont(),
    MDCTypography.buttonFont(),

    // Display fonts (extra large fonts)
    MDCTypography.display1Font(),
    MDCTypography.display2Font(),
    MDCTypography.display3Font(),
    MDCTypography.display4Font()
  ]

  let fontOpacities = [

    // Common UI fonts.
    MDCTypography.headlineFontOpacity(),
    MDCTypography.titleFontOpacity(),
    MDCTypography.subheadFontOpacity(),
    MDCTypography.body2FontOpacity(),
    MDCTypography.body1FontOpacity(),
    MDCTypography.captionFontOpacity(),
    MDCTypography.buttonFontOpacity(),

    // Display fonts (extra large fonts)
    MDCTypography.display1FontOpacity(),
    MDCTypography.display2FontOpacity(),
    MDCTypography.display3FontOpacity(),
    MDCTypography.display4FontOpacity()
  ]

  let fontStyleNames = [

    // Common UI fonts.
    "Headline Font",
    "Title Font",
    "Subhead Font",
    "Body 2 Font",
    "Body 1 Font",
    "Caption Font",
    "Button Font",

    // Display fonts (extra large fonts)
    "Display 1 Font",
    "Display 2 Font",
    "Display 3 Font",
    "Display 4 Font"
  ]

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 0, 10, 0)
    super.init(collectionViewLayout: flowLayout)
    self.collectionView?.registerClass(TypographyExampleViewCell.self,
      forCellWithReuseIdentifier: "TypographyExampleViewCell")
    self.collectionView?.backgroundColor = UIColor.whiteColor()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return strings.count
  }

  override func collectionView(collectionView: UICollectionView,
    numberOfItemsInSection section: Int) -> Int {
      return fonts.count
  }

  override func collectionView(collectionView: UICollectionView,
    cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCellWithReuseIdentifier("TypographyExampleViewCell",
        forIndexPath: indexPath) as! TypographyExampleViewCell

      let itemNum:NSInteger = indexPath.row;
      let sectionNum:NSInteger = indexPath.section;

      var text = strings[sectionNum]
      let font = fonts[itemNum]
      let opacity = fontOpacities[itemNum]
      let name = fontStyleNames[itemNum]
      if (font.pointSize > 100 && text == strings[0]) {
        text = "MDC"
      }
      cell.populateCell(text, font: font, opacity: opacity, name: name)

      return cell
  }

  func collectionView(collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {

      let itemNum:NSInteger = indexPath.row;
      let sectionNum:NSInteger = indexPath.section;

      var text = strings[sectionNum]
      let font = fonts[itemNum]
      if (font.pointSize > 100 && text == strings[0]) {
        text = "MDC"
      }
      let size =
          TypographyExampleViewCell.cellSize(self.view.frame.width - 20, text: text, font: font)
      return size
  }

  class func catalogBreadcrumbs() -> [String] {
    return ["Typography", "Typography"]
  }

  class func catalogDescription() -> String {
    return "The Typography component provides methods for displaying text using the type sizes and"
           " opacities from the Material Design specifications."
  }

  func catalogIsPrimaryDemo() -> Bool {
    return true
  }

}
