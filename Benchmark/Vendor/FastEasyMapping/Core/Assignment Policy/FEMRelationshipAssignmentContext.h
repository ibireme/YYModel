//
// Created by zen on 13/05/15.
// Copyright (c) 2015 Yalantis. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FEMRelationship, FEMObjectStore, FEMRelationshipAssignmentContext;

@protocol FEMRelationshipAssignmentContextDelegate <NSObject>
@required

- (void)assignmentContext:(nonnull FEMRelationshipAssignmentContext *)context deletedObject:(nonnull id)object;

@end


@interface FEMRelationshipAssignmentContext: NSObject

@property (nonatomic, unsafe_unretained, readonly, nonnull) FEMObjectStore *store;
- (nonnull instancetype)initWithStore:(nonnull FEMObjectStore *)store;

@property (nonatomic, strong, readonly, nonnull) id destinationObject;
@property (nonatomic, strong, readonly, nonnull) FEMRelationship *relationship;

@property (nonatomic, strong, readonly, nullable) id sourceRelationshipValue;
@property (nonatomic, strong, readonly, nullable) id targetRelationshipValue;

- (void)deleteRelationshipObject:(nonnull id)object;

@end