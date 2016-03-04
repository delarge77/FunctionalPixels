//
//  FRPPhotoModel.h
//  FunctionalReactivePixels
//
//  Created by Alessandro dos Santos Pinto on 04/03/16.
//  Copyright © 2016 Alessandro dos Santos Pinto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FRPPhotoModel : NSObject

@property(nonatomic,strong)NSString*photoName;
@property(nonatomic,strong)NSNumber*identifier;
@property(nonatomic,strong)NSString*photographerName;
@property(nonatomic,strong)NSNumber*rating;
@property(nonatomic,strong)NSString*thumbnailURL;
@property(nonatomic,strong)NSData*thumbnailData;
@property(nonatomic,strong)NSString*fullsizedURL;
@property(nonatomic,strong)NSData*fullsizedData;

@end
