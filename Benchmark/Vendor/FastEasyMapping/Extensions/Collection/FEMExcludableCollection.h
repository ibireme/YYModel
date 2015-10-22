//
// Created by zen on 19/06/14.
// Copyright (c) 2014 Yalantis. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FEMExcludableCollection <NSObject>
@required
- (id)collectionByExcludingObjects:(id)objects;

@end

@interface NSArray (FEMExcludableCollection) <FEMExcludableCollection>

- (NSArray *)collectionByExcludingObjects:(NSArray *)objects;

@end

@interface NSSet (FEMExcludableCollection) <FEMExcludableCollection>

- (NSSet *)collectionByExcludingObjects:(NSSet *)objects;

@end

@interface NSOrderedSet (FEMExcludableCollection) <FEMExcludableCollection>

- (NSOrderedSet *)collectionByExcludingObjects:(NSOrderedSet *)objects;

@end