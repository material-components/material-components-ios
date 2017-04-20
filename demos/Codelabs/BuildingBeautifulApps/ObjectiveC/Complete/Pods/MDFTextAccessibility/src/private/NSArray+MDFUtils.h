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

#import <Foundation/Foundation.h>

typedef id (^MDFMappingFunction)(id object);

/** Functional extensions to NSArray. */
@interface NSArray (MDFUtils)

/**
 * Returns an array consisting of applying |function| to each element of self in order.
 *
 * @param function A block mapping an input element to an output element.
 * @return An array of the same size as self containing elements mapped through the function.
 */
- (NSArray *)mdf_arrayByMappingObjects:(MDFMappingFunction)function;

/**
 * Returns a sorted version of |array| by using the passed comparator on self.
 *
 * @note The comparator acts of elements of self, @em not |array|.
 *
 * Example:
 * @code
 * NSArray *weights = @[ 100, 200, 50 ];
 * NSArray *dogs = @[ @"Bruno", @"Tiger", @"Spot" ];
 * NSComparator *ascending = ... NSString comparator ...
 * NSArray *sortedDogs = [weights mdf_sortArray:dogs
 *                              usingComparator:ascending];
 * // sortedDogs is @[ @"Spot", @"Bruno", @"Tiger" ].
 * @endcode
 *
 * @param array The array to sort.
 * @param comparator A comparator acting on elements of self.
 * @return A sorted copy of |array|.
 */
- (NSArray *)mdf_sortArray:(NSArray *)array usingComparator:(NSComparator)comparator;

@end
