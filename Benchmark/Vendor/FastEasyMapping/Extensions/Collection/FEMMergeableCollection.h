//
// Created by zen on 12/08/14.
// Copyright (c) 2014 Yalantis. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FEMMergeableCollection <NSObject>
@required
- (id)collectionByMergingObjects:(id)object;

@end

@interface NSArray (FEMMergeableCollection) <FEMMergeableCollection>

- (NSArray *)collectionByMergingObjects:(NSArray *)object;

@end

@interface NSSet (FEMMergeableCollection) <FEMMergeableCollection>

- (NSSet *)collectionByMergingObjects:(NSSet *)object;

@end

@interface NSOrderedSet (FEMMergeableCollection) <FEMMergeableCollection>

- (NSOrderedSet *)collectionByMergingObjects:(NSOrderedSet *)object;

@end