//
// Created by zen on 13/05/15.
// Copyright (c) 2015 Yalantis. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FEMRelationshipAssignmentContext.h"

@interface FEMRelationshipAssignmentContext (Internal)

@property (nonatomic, strong) id destinationObject;
@property (nonatomic, strong) FEMRelationship *relationship;

@property (nonatomic, strong) id sourceRelationshipValue;
@property (nonatomic, strong) id targetRelationshipValue;

@end