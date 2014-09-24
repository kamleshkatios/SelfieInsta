//
//  ResolutionModel.m
//  SelfieInsta
//
//  Created by kamlesh on 9/24/14.
//  Copyright (c) 2014 kamlesh. All rights reserved.
//

#import "ResolutionModel.h"

@implementation ResolutionModel

/*
 "url": "http://distillery.s3.amazonaws.com/media/2011/02/02/f9443f3443484c40b4792fa7c76214d5_6.jpg",
 "width": 306,
 "height": 306
 */
- (instancetype) initWithDictionary:(NSDictionary *) dictionary {
    self = [super init];
    if (self) {
        self.imageUrl = dictionary[@"url"];
        self.height = [dictionary[@"height"] integerValue];
        self.width = [dictionary[@"width"] integerValue];
    }
    return self;
}
@end
