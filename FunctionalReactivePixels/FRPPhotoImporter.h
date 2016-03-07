//
//  FRPPhotoImporter.h
//  FunctionalReactivePixels
//
//  Created by Alessandro dos Santos Pinto on 04/03/16.
//  Copyright © 2016 Alessandro dos Santos Pinto. All rights reserved.
//

@class FRPPhotoModel;
#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface FRPPhotoImporter : NSObject

+ (RACSignal *)importPhotos;
+ (RACSignal *) fetchPhotoDetails:(FRPPhotoModel *)photoModel;

@end
