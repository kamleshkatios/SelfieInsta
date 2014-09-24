//
//  APIManager.h
//  SelfieInsta
//
//  Created by kamlesh on 9/23/14.
//  Copyright (c) 2014 kamlesh. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <UIKit/UIKit.h>

typedef void (^APIManagerCompleted) (NSMutableArray *imageList);
typedef void (^APIManagerFailure) (NSError *error);
typedef void (^ImageDownloadedCallback) (UIImage* image, NSString *imgLink);

@interface APIManager : NSObject
+ (APIManager *)sharedManager;
- (void) getSelfiePics:(APIManagerCompleted) apiManagerCompleted
  andAPIManagerFailure:(APIManagerFailure) apiManagerFailure
            startIndex:(NSInteger) startIndex;
- (void) getImage:(NSString *) imageLink withCallback:(ImageDownloadedCallback) imageDownloadedBlock;
@end
