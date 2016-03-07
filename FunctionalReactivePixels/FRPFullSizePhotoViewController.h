//
//  FRPFullSizePhotoViewController.h
//  FunctionalReactivePixels
//
//  Created by Alessandro dos Santos Pinto on 07/03/16.
//  Copyright © 2016 Alessandro dos Santos Pinto. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FRPFullSizePhotoViewController;
@protocol FRPFullSizePhotoViewControllerDelegate <NSObject>

- (void) userDidScroll:(FRPFullSizePhotoViewController *)viewController toPhotoAtIndex:(NSInteger) index;

@end

@interface FRPFullSizePhotoViewController : UIViewController

@property (nonatomic, readonly) NSArray *photoModelArray;
@property (nonatomic, weak) id<FRPFullSizePhotoViewControllerDelegate> delegate;

- (instancetype)initWithPhotoModels:(NSArray *) photoModelArray
                  currentPhotoIndex:(NSInteger) photoIndex;



@end
