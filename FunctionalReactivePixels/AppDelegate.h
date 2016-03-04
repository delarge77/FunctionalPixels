//
//  AppDelegate.h
//  FunctionalReactivePixels
//
//  Created by Alessandro dos Santos Pinto on 04/03/16.
//  Copyright © 2016 Alessandro dos Santos Pinto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <500px-iOS-api/PXAPI.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) PXAPIHelper *apiHelper;


@end

