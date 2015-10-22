//
// Created by zen on 12/05/15.
// Copyright (c) 2015 Yalantis. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FEMMapping, FEMAttribute;

FOUNDATION_EXTERN id FEMRepresentationRootForKeyPath(id representation, NSString *keyPath);

FOUNDATION_EXTERN NSDictionary *FEMRepresentationCollectPresentedPrimaryKeys(id representation, FEMMapping *mapping);

FOUNDATION_EXTERN id FEMRepresentationValueForAttribute(id representation, FEMAttribute *attribute);