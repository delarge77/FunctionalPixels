//
//  FRPPhotoImporter.m
//  FunctionalReactivePixels
//
//  Created by Alessandro dos Santos Pinto on 04/03/16.
//  Copyright © 2016 Alessandro dos Santos Pinto. All rights reserved.
//

#import "FRPPhotoImporter.h"
#import "FRPPhotoModel.h"
#import "AppDelegate.h"

@implementation FRPPhotoImporter

+ (RACReplaySubject *)importPhotos {

    RACReplaySubject *subject = [RACReplaySubject subject];
    
    NSURLRequest *request = [self popularURLRequest];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (data) {
            id results = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            [subject sendNext:[[[results[@"photos"] rac_sequence] map:
            ^id(NSDictionary *photoDictionary){
                FRPPhotoModel *model = [FRPPhotoModel new];
                [self configurePhotoModel:model withDictionary:photoDictionary];
                [self downloadThumbnailForPhotoModel:model];
                
                return model;
            }] array]];
            [subject sendCompleted];
        } else {
            [subject sendError:connectionError];
        }
    }];
    
    return subject;
}

+ (NSURLRequest *) popularURLRequest {
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    return [delegate.apiHelper urlRequestForPhotoFeature:PXAPIHelperPhotoFeaturePopular resultsPerPage:100 page:0 photoSizes:PXPhotoModelSizeThumbnail sortOrder:PXAPIHelperSortOrderRating except:PXPhotoModelCategoryNude];
}

+ (void) configurePhotoModel:(FRPPhotoModel *) photoModel withDictionary:(NSDictionary *) dictionary {

    photoModel.photoName = dictionary[@"name"];
    photoModel.identifier = dictionary[@"id"];
    photoModel.photographerName = dictionary[@"user"][@"username"];
    photoModel.rating = dictionary[@"rating"];
    photoModel.thumbnailURL = [self urlForImageSize:3 inDictionary:dictionary[@"images"]];
    
    // Extended attributes fetched with subsequent request
    if (dictionary[@"comments_count"]) {
        photoModel.fullsizedURL = [self urlForImageSize:4 inDictionary:dictionary[@"images"]];
    }
}

+ (NSString *) urlForImageSize:(NSInteger) size inDictionary:(NSArray *) array {

//    (
//     {
//         size = size;
//         url = ...;
//     }
//    );
    
    return [[[[[array rac_sequence] filter:^BOOL(NSDictionary *value) {
        return [value[@"size"] integerValue] == size;
    }] map:^id(id value) {
        return value[@"url"];
    }]array] firstObject];
}

+ (void) downloadThumbnailForPhotoModel:(FRPPhotoModel *) model{

    
}

@end
