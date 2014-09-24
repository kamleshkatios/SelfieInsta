//
//  InstagramImageModel.m
//  SelfieInsta
//
//  Created by kamlesh on 9/24/14.
//  Copyright (c) 2014 kamlesh. All rights reserved.
//

#import "IGImageModel.h"
#import "ResolutionModel.h"

@implementation IGImageModel

/*
 "images": {
 "low_resolution": {
 "url": "http://distillery.s3.amazonaws.com/media/2011/02/02/f9443f3443484c40b4792fa7c76214d5_6.jpg",
 "width": 306,
 "height": 306
 },
 "thumbnail": {
 "url": "http://distillery.s3.amazonaws.com/media/2011/02/02/f9443f3443484c40b4792fa7c76214d5_5.jpg",
 "width": 150,
 "height": 150
 },
 "c": {
 "url": "http://distillery.s3.amazonaws.com/media/2011/02/02/f9443f3443484c40b4792fa7c76214d5_7.jpg",
 "width": 612,
 "height": 612
 }
 }
 */
- (instancetype) initWithDictionary:(NSDictionary *) dictionary {
    self = [super init];
    if (self) {
        self.lowResolution = [[ResolutionModel alloc] initWithDictionary:dictionary[@"low_resolution"]];
        self.standarResolution = [[ResolutionModel alloc] initWithDictionary:dictionary[@"standard_resolution"]];
        self.thumbnailResolution = [[ResolutionModel alloc] initWithDictionary:dictionary[@"thumbnail"]];
    }
    return self;
}
@end
