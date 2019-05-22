// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

#import <Foundation/Foundation.h>

#pragma mark - Latin text

static NSString *const MDCTextFieldSnapshotTestsPlaceholderShortTextLatin = @"P text";
static NSString *const MDCTextFieldSnapshotTestsPlaceholderLongTextLatin =
    @"Placeholder text placeholder text placeholder text placeholder text placeholder text.";
static NSString *const MDCTextFieldSnapshotTestsHelperShortTextLatin = @"H text";
static NSString *const MDCTextFieldSnapshotTestsHelperLongTextLatin =
    @"Helper text helper text helper text helper text helper text helper text helper text.";
static NSString *const MDCTextFieldSnapshotTestsErrorShortTextLatin = @"E text";
static NSString *const MDCTextFieldSnapshotTestsErrorLongTextLatin =
    @"Error text error text error text error text error text error text error text error text.";
static NSString *const MDCTextFieldSnapshotTestsInputShortTextLatin = @"I text";
static NSString *const MDCTextFieldSnapshotTestsInputLongTextLatin =
    @"Input text input text input text input text input text input text input text input text.";

#pragma mark - Arabic text

static NSString *const MDCTextFieldSnapshotTestsPlaceholderShortTextArabic = @"تلك أي.";
static NSString *const MDCTextFieldSnapshotTestsPlaceholderLongTextArabic =
    @"بـ أخر جسيمة نتيجة بالرّغم, إذ لهيمنة بالولايات غير, أي ذلك بخطوط ليبين العظمى. في لان.";
static NSString *const MDCTextFieldSnapshotTestsHelperShortTextArabic = @"العظمى الخطّة.";
static NSString *const MDCTextFieldSnapshotTestsHelperLongTextArabic =
    @"أن حلّت أعمال وقد, انه ان قادة سبتمبر حاملات, عدد قد وعلى الأثناء،. ما حتى مكّن.";
static NSString *const MDCTextFieldSnapshotTestsErrorShortTextArabic = @"على الطرفين.";
static NSString *const MDCTextFieldSnapshotTestsErrorLongTextArabic =
    @"أسر وتنامت الإتفاقية بـ, قد منتصف التنازلي عدد. الى و أطراف الصين. علاقة مساعدة تلك ما.";
static NSString *const MDCTextFieldSnapshotTestsInputShortTextArabic = @"ذلك في.";
static NSString *const MDCTextFieldSnapshotTestsInputLongTextArabic =
    @"دول السيطرة استطاعوا ٣٠. مليون وفرنسا أوراقهم انه تم, نفس قد والديون العالمية. دون ما تنفّس.";

#pragma mark - Hindi text

static NSString *const MDCTextFieldSnapshotTestsPlaceholderShortTextHindi = @"जाता करेसाथ";
static NSString *const MDCTextFieldSnapshotTestsPlaceholderLongTextHindi =
    @"उदेश विभाग शारिरिक पुर्णता पुष्टिकर्ता सुना सुविधा प्राप्त बनाकर अतित संसाध बिन्दुओ स्वतंत्र जोवे जिम्मे तकरीबन "
     "स्वतंत्रता कराना चिदंश";
static NSString *const MDCTextFieldSnapshotTestsHelperShortTextHindi = @"जिवन ध्येय";
static NSString *const MDCTextFieldSnapshotTestsHelperLongTextHindi =
    @"कारन असरकारक मुश्किले बाटते भेदनक्षमता सुचनाचलचित्र करती सीमित उनको ध्वनि परिवहन कार्यसिधान्तो वर्णन "
     "लचकनहि दिनांक सकती";
static NSString *const MDCTextFieldSnapshotTestsErrorShortTextHindi = @"बाटते पहोच";
static NSString *const MDCTextFieldSnapshotTestsErrorLongTextHindi =
    @"बाजार विभाजन मार्गदर्शन विश्वव्यापि बदले पहेला उनको नयेलिए वर्तमान समजते प्राधिकरन व्याख्यान विकेन्द्रियकरण "
     "थातक माध्यम व्यवहार";
static NSString *const MDCTextFieldSnapshotTestsInputShortTextHindi = @"हमारी अतित";
static NSString *const MDCTextFieldSnapshotTestsInputLongTextHindi =
    @"हमारि कलइस सारांश परस्पर वास्तविक होसके अधिकांश अर्थपुर्ण विकेन्द्रियकरण पडता करने एसलिये तकनिकल व्याख्या "
     "सुचना शीघ्र";

#pragma mark - Korean text

static NSString *const MDCTextFieldSnapshotTestsPlaceholderShortTextKorean = @"것은 같은.";
static NSString *const MDCTextFieldSnapshotTestsPlaceholderLongTextKorean =
    @"미인을 그들의 창공에 어디 교향악이다. 속잎나고. 끝까지 수 못할 이 철환하였는가 구하지 내려온 "
     "것이다. 인도하겠다는 인간에.";
static NSString *const MDCTextFieldSnapshotTestsHelperShortTextKorean = @"때문이다. 보이는.";
static NSString *const MDCTextFieldSnapshotTestsHelperLongTextKorean =
    @"꾸며 어디 미인을 같은 새가 봄바람을 힘있다. 이상은 아름다우냐? 이상의 무엇을 내려온 "
     "봄바람이다. 얼음 보이는 있으며,";
static NSString *const MDCTextFieldSnapshotTestsErrorShortTextKorean = @"힘차게 얼음.";
static NSString *const MDCTextFieldSnapshotTestsErrorLongTextKorean =
    @"아름다우냐?않는 인류의 돋고. 쓸쓸한 천고에 가치를 황금시대다. 하는 수 장식하는 위하여. "
     "없으면 살았으며. 기관과 꽃이.";
static NSString *const MDCTextFieldSnapshotTestsInputShortTextKorean = @"수 끓는.";
static NSString *const MDCTextFieldSnapshotTestsInputLongTextKorean =
    @"천자만홍이 품었기 청춘이 끓는 않는 끓는다. 때문이다. 이상은 심장의 품으며. 천고에 무한한 "
     "하여도 이것을 것이 같이,";

#pragma mark - Cyrillic text

static NSString *const MDCTextFieldSnapshotTestsPlaceholderShortTextCyrillic = @"долор сит.";
static NSString *const MDCTextFieldSnapshotTestsPlaceholderLongTextCyrillic =
    @"Лорем ипсум долор сит амет, орнатус улламцорпер репрехендунт иус еи, цаусае трацтатос меа.";
static NSString *const MDCTextFieldSnapshotTestsHelperShortTextCyrillic = @"Сед ет.";
static NSString *const MDCTextFieldSnapshotTestsHelperLongTextCyrillic =
    @"Лорем ипсум долор сит амет, агам малорум яуи ут, елитр иудицо апериам еос ут ессе.";
static NSString *const MDCTextFieldSnapshotTestsErrorShortTextCyrillic = @"Лорем ипсум.";
static NSString *const MDCTextFieldSnapshotTestsErrorLongTextCyrillic =
    @"Лорем ипсум долор сит амет, иус но хинц вертерем. Ин вис импетус еяуидем инермис сед.";
static NSString *const MDCTextFieldSnapshotTestsInputShortTextCyrillic = @"Цум еирмод.";
static NSString *const MDCTextFieldSnapshotTestsInputLongTextCyrillic =
    @"Лорем ипсум долор сит амет, ат сит оратио ассентиор цотидиеяуе, нец но аццусам делицата.";
