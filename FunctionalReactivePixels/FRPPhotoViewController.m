//
//  FRPPhotoViewController.m
//  FunctionalReactivePixels
//
//  Created by Alessandro dos Santos Pinto on 07/03/16.
//  Copyright © 2016 Alessandro dos Santos Pinto. All rights reserved.
//

#import "FRPPhotoViewController.h"
#import "FRPPhotoModel.h"
#import "FRPPhotoImporter.h"
#import <SVProgressHUD.h>
#import <ReactiveCocoa/ReactiveCocoa.h>


@interface FRPPhotoViewController()

@property (nonatomic, assign) NSInteger photoIndex;
@property (nonatomic, strong) FRPPhotoModel *photoModel;
@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation FRPPhotoViewController

- (instancetype)initWithPhotoModel:(FRPPhotoModel *) photoModel index:(NSInteger) photoIndex {

    self = [super init];
    
    if (self) {
        self.photoModel = photoModel;
        self.photoIndex = photoIndex;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    RAC(imageView, image) = [RACObserve(self.photoModel, fullsizedData)
    map:^id(id value) {
        return [UIImage imageWithData:value];
    }];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
    self.imageView = imageView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [SVProgressHUD show];
    
    [[FRPPhotoImporter fetchPhotoDetails:self.photoModel]
    subscribeError:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"Error"];
    }completed:^{
        [SVProgressHUD dismiss];
    }];
}

@end
