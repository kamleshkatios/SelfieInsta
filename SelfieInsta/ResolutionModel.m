//
//  ResolutionModel.m
//  SelfieInsta
//
//  Created by kamlesh on 9/24/14.
//  Copyright (c) 2014 kamlesh. All rights reserved.
//

#import "ResolutionModel.h"

@implementation ResolutionModel

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
