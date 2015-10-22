//
// Created by zen on 13/05/15.
// Copyright (c) 2015 Yalantis. All rights reserved.
//

#import "FEMRelationshipAssignmentContext.h"
#import "FEMRelationshipAssignmentContext+Internal.h"

#import "FEMRelationship.h"
#import "FEMObjectStore.h"

@interface FEMRelationshipAssignmentContext ()

@property (nonatomic, strong) id destinationObject;
@property (nonatomic, strong) FEMRelationship *relationship;

@property (nonatomic, strong) id sourceRelationshipValue;
@property (nonatomic, strong) id targetRelationshipValue;

@property (nonatomic, unsafe_unretained) id<FEMRelationshipAssignmentContextDelegate> delegate;

@end

@implementation FEMRelationshipAssignmentContext

- (instancetype)initWithStore:(FEMObjectStore *)store {
    self = [super init];
    if (self) {
        _store = store;
        self.delegate = store;
    }

    return self;
}

- (void)deleteRelationshipObject:(id)object {
    [self.delegate assignmentContext:self deletedObject:object];
}

@end

@implementation FEMRelationshipAssignmentContext (Internal)

@dynamic destinationObject;
@dynamic relationship;
@dynamic sourceRelationshipValue;
@dynamic targetRelationshipValue;

@end