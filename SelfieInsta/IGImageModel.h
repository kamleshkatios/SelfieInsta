//
//  InstagramImageModel.h
//  SelfieInsta
//
//  Created by kamlesh on 9/24/14.
//  Copyright (c) 2014 kamlesh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResolutionModel.h"

@interface IGImageModel : NSObject
@property (nonatomic, strong) ResolutionModel *lowResolution;
@property (nonatomic, strong) ResolutionModel *standarResolution;
@property (nonatomic, strong) ResolutionModel *thumbnailResolution;

- (instancetype) initWithDictionary:(NSDictionary *) dictionary;
@end
