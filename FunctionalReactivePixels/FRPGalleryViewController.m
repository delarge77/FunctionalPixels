//
//  ViewController.m
//  FunctionalReactivePixels
//
//  Created by Alessandro dos Santos Pinto on 04/03/16.
//  Copyright © 2016 Alessandro dos Santos Pinto. All rights reserved.
//

#import "FRPGalleryViewController.h"
#import "FRPGalleryFlowLayout.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "ReactiveCocoa/RACEXTScope.h"
#import "FRPPhotoImporter.h"
#import "FRPCell.h"
#import "FRPFullSizePhotoViewController.H"
#import <ReactiveCocoa/RACDelegateProxy.h>

static NSString *cellIdentifier = @"cell";

@interface FRPGalleryViewController ()//<FRPFullSizePhotoViewControllerDelegate>

@property (strong, nonatomic) NSArray *photosArray;
@property (strong, nonatomic) id collectionViewDelegate;

@end

@implementation FRPGalleryViewController

- (instancetype)init {

    FRPGalleryFlowLayout *flowLayout = [[FRPGalleryFlowLayout alloc] init];
    self = [self initWithCollectionViewLayout:flowLayout];
    if (!self) {
        return nil;
    }
    
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    RACDelegateProxy *viewControllerDelegate = [[RACDelegateProxy alloc] initWithProtocol:@protocol(FRPFullSizePhotoViewControllerDelegate)];
    [[viewControllerDelegate rac_signalForSelector:@selector(userDidScroll:toPhotoAtIndex:)
                                     fromProtocol:@protocol(FRPFullSizePhotoViewControllerDelegate)]
    subscribeNext:^(RACTuple *value) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem
                                                    :[value.second integerValue] inSection:0] atScrollPosition
                                                    :UICollectionViewScrollPositionCenteredVertically animated:NO];
    }];
    
//    self.collectionViewDelegate = [[RACDelegateProxy alloc] initWithProtocol:@protocol(UICollectionViewDelegate)];
//    [[self.collectionViewDelegate rac_signalForSelector:@selector(collectionView:didSelectItemAtIndexPath:)]
//    subscribeNext:^(RACTuple *arguments) {
//        FRPFullSizePhotoViewController *viewController = [[FRPFullSizePhotoViewController alloc] initWithPhotoModels
//                                                          :self.photosArray currentPhotoIndex
//                                                          :[(NSIndexPath *) arguments.second item]];
//        viewController.delegate = (id<FRPFullSizePhotoViewControllerDelegate>)viewControllerDelegate;
//        [self.navigationController pushViewController:viewController animated:YES];
//    }];
    
    
    self.title = @"Popular on 500px";
    [self.collectionView registerClass:[FRPCell class] forCellWithReuseIdentifier:cellIdentifier];
    @weakify(self);
    [RACObserve(self, photosArray) subscribeNext:^(id x) {
        @strongify(self);
        [self.collectionView reloadData];
    }];
    
    
    RAC(self, photosArray) = [[[[FRPPhotoImporter importPhotos]
    doCompleted:^{
        @strongify(self);
        [self.collectionView reloadData];
    }] logError] catchTo:[RACSignal empty]];
    
}

#pragma mark - UICollectionView Datasource Methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photosArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FRPCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell setPhotoModel:self.photosArray[indexPath.row]];
    return cell;
}

#pragma mark - UICollectionView Delegate Methods

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    FRPFullSizePhotoViewController *viewController = [[FRPFullSizePhotoViewController alloc]
                                                      initWithPhotoModels:self.photosArray
                                                      currentPhotoIndex:indexPath.item];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
