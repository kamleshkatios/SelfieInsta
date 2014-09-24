//
//  APIManager.h
//  SelfieInsta
//
//  Created by kamlesh on 9/23/14.
//  Copyright (c) 2014 kamlesh. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^APIManagerCompleted) (NSArray *imageList);
typedef void (^APIManagerFailure) (NSError *error);

@interface APIManager : NSObject
+ (APIManager *)sharedManager;
- (void) getSelfiePics:(APIManagerCompleted) apiManagerCompleted
            andAPIManagerFailure:(APIManagerFailure) apiManagerFailure;
@end
