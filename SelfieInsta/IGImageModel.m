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
