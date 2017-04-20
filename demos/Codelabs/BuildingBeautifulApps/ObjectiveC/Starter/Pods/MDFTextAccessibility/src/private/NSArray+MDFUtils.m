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

#import "NSArray+MDFUtils.h"

@implementation NSArray (MDFUtils)

- (NSArray *)mdf_arrayByMappingObjects:(MDFMappingFunction)function {
  NSAssert(function, @"Mapping block must not be NULL.");
  NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:[self count]];
  [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    [array addObject:function(obj)];
  }];
  return [array copy];
}

- (BOOL)mdf_anyObjectPassesTest:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))predicate {
  NSIndexSet *indices = [self indexesOfObjectsPassingTest:predicate];
  return [indices count] > 0;
}

- (BOOL)mdf_allObjectsPassTest:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))predicate {
  NSIndexSet *indices = [self indexesOfObjectsPassingTest:predicate];
  return [indices count] == [self count];
}

- (NSArray *)mdf_sortArray:(NSArray *)array usingComparator:(NSComparator)comparator {
  NSAssert(comparator, @"Comparator block must not be NULL.");

  NSUInteger numElements = [self count];
  NSAssert([array count] == numElements, @"Array %@ must have length %lu.", array,
           (unsigned long)numElements);

  // Create a permutation array by sorting self with comparator.
  NSMutableArray *permutation = [[NSMutableArray alloc] initWithCapacity:numElements];
  for (NSUInteger i = 0; i < numElements; ++i) {
    [permutation addObject:@(i)];
  }

  NSArray *sortedPermutation = [permutation sortedArrayUsingComparator:^(id a, id b) {
    NSUInteger firstIndex = [a unsignedIntegerValue];
    NSUInteger secondIndex = [b unsignedIntegerValue];
    return comparator(self[firstIndex], self[secondIndex]);
  }];

  // Permute array into order.
  NSMutableArray *sorted = [[NSMutableArray alloc] initWithCapacity:numElements];
  for (NSUInteger i = 0; i < numElements; ++i) {
    NSUInteger index = [sortedPermutation[i] unsignedIntegerValue];
    [sorted addObject:array[index]];
  }
  return [sorted copy];
}

@end
