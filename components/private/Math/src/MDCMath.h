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

static inline CGFloat MDCCeil(CGFloat value) {
#if CGFLOAT_IS_DOUBLE
  return ceil(value);
#else
  return ceilf(value);
#endif
}

static inline CGFloat MDCFabs(CGFloat value) {
#if CGFLOAT_IS_DOUBLE
  return fabs(value);
#else
  return fabsf(value);
#endif
}

static inline bool MDCCGFloatEqual(CGFloat a, CGFloat b) {
  const CGFloat constantK = 3;
#if CGFLOAT_IS_DOUBLE
  const CGFloat epsilon = DBL_EPSILON;
  const CGFloat min = DBL_MIN;
#else
  const CGFloat epsilon = FLT_EPSILON;
  const CGFloat min = FLT_MIN;
#endif
  return (MDCFabs(a - b) < constantK * epsilon * MDCFabs(a + b) || MDCFabs(a - b) < min);
}

static inline CGFloat MDCFloor(CGFloat value) {
#if CGFLOAT_IS_DOUBLE
  return floor(value);
#else
  return floorf(value);
#endif
}

static inline CGFloat MDCHypot(CGFloat x, CGFloat y) {
#if CGFLOAT_IS_DOUBLE
  return hypot(x, y);
#else
  return hypotf(x, y);
#endif
}

// Checks whether the provided floating point number is exactly zero.
static inline BOOL MDCCGFloatIsExactlyZero(CGFloat value) {
  return (value == 0.f);
}

static inline CGFloat MDCPow(CGFloat value, CGFloat power) {
#if CGFLOAT_IS_DOUBLE
  return pow(value, power);
#else
  return powf(value, power);
#endif
}

static inline CGFloat MDCRint(CGFloat value) {
#if CGFLOAT_IS_DOUBLE
  return rint(value);
#else
  return rintf(value);
#endif
}

static inline CGFloat MDCRound(CGFloat value) {
#if CGFLOAT_IS_DOUBLE
  return round(value);
#else
  return roundf(value);
#endif
}

static inline CGFloat MDCSqrt(CGFloat value) {
#if CGFLOAT_IS_DOUBLE
  return sqrt(value);
#else
  return sqrtf(value);
#endif
}
