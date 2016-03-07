//
//  FRPPhotoViewController.h
//  FunctionalReactivePixels
//
//  Created by Alessandro dos Santos Pinto on 07/03/16.
//  Copyright © 2016 Alessandro dos Santos Pinto. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FRPPhotoModel;

@interface FRPPhotoViewController : UIViewController

@property (nonatomic, readonly) NSInteger photoIndex;
@property (nonatomic, readonly) FRPPhotoModel *photoModel;

- (instancetype)initWithPhotoModel:(FRPPhotoModel *) photoModel index:(NSInteger) photoIndex;

@end
