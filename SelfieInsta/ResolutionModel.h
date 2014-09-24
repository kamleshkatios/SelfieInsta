//
//  ResolutionModel.h
//  SelfieInsta
//
//  Created by kamlesh on 9/24/14.
//  Copyright (c) 2014 kamlesh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResolutionModel : NSObject
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic) NSInteger height;
@property (nonatomic) NSInteger width;
- (instancetype) initWithDictionary:(NSDictionary *) dictionary;
@end
