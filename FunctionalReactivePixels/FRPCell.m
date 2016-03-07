//
//  FRPCell.m
//  FunctionalReactivePixels
//
//  Created by Alessandro dos Santos Pinto on 07/03/16.
//  Copyright © 2016 Alessandro dos Santos Pinto. All rights reserved.
//

#import "FRPCell.h"
#import "FRPPhotoModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface FRPCell()

@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, strong) RACDisposable *subscription;

@end

@implementation FRPCell

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor darkGrayColor];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        [self.contentView addSubview:imageView];
        self.imageView = imageView;
    }
    
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self.subscription dispose], self.subscription = nil;
}

- (void)setPhotoModel:(FRPPhotoModel *)photoModel {
    
    self.subscription = [[[RACObserve(photoModel, thumbnailData)
     filter:^BOOL(id value) {
        return value != nil;
     }] map:^id(id value) {
         return [UIImage imageWithData:value];
     }] setKeyPath:@keypath(self.imageView, image)
        onObject:self.imageView];
}

@end
