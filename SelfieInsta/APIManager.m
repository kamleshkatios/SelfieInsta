//
//  APIManager.m
//  SelfieInsta
//
//  Created by kamlesh on 9/23/14.
//  Copyright (c) 2014 kamlesh. All rights reserved.
//

#import "APIManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "IGImageModel.h"

#define kKeyClientID @"client_id"
#define kKeyAccessToken @"access_token"
#define kCount @"count"

#define DownladCount 50

NSString *const kInstagramBaseUrl = @"https://api.instagram.com/v1/";
NSString *const kTagPath = @"tags/selfie/media/recent?";

#define CLIENT_ID @"df6485e2c3204e4cadbde4050c29700f"
#define CLIENT_SECRET @"4ec1f39fa7ce4006980f9d5efbaf2c5f"

@implementation APIManager

+ (APIManager *)sharedManager {
    static APIManager *apiManager = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        apiManager = [[APIManager alloc] init];
    });
    return apiManager;
}

- (NSString * ) setParameterFor:(NSString *) urlString andDict:(NSDictionary*) params {
    
    __block NSString* urlString_ = [kInstagramBaseUrl stringByAppendingString:urlString];
    [params enumerateKeysAndObjectsUsingBlock:^(NSString* key, NSString* obj, BOOL *stop) {
        urlString_ = [urlString_ stringByAppendingFormat:@"&%@=%@",key,obj];
    }];
    
    if ([urlString_ rangeOfString:@"?&"].location != NSNotFound) {
        urlString_ = [urlString_ stringByReplacingOccurrencesOfString:@"?&" withString:@"?"];
    }
    return urlString_;
}

- (void) getSelfiePics:(APIManagerCompleted) apiManagerCompleted
    andAPIManagerFailure:(APIManagerFailure) apiManagerFailure
            startIndex:(NSInteger) startIndex {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:CLIENT_ID forKey:kKeyClientID];
    [params setObject:@(DownladCount) forKey:kCount];
    [params setObject:@(startIndex) forKey:@"min_id"];
    [params setObject:@(startIndex+DownladCount) forKey:@"max_id"];

    NSString *urlString = [self setParameterFor:kTagPath andDict:params];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url
                                                                cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                            timeoutInterval:30.0];
        
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];

    __block NSMutableArray *imageList = [NSMutableArray array];
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:operationQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError) {
            apiManagerFailure(connectionError);
        } else if (data) {
            NSError *error= nil;
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data
                                                                         options:NSJSONReadingMutableContainers
                                                                           error:&error];
            NSArray *dataList = responseDict[@"data"];
            [dataList enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
                NSDictionary* imageDict = dict[@"images"];
                IGImageModel *igImageModel = [[IGImageModel alloc] initWithDictionary:imageDict];
                [imageList addObject:igImageModel];
            }];
            apiManagerCompleted(imageList);
        } else {
            apiManagerFailure(connectionError);
        }
    }];
}

- (void) getImage:(NSString *) imageLink withCallback:(ImageDownloadedCallback) imageDownloadedBlock {
    
    if (imageLink == nil || [imageLink isEqualToString:@""]) {
        imageDownloadedBlock(nil, imageLink);
        return;
    }
    @synchronized (self) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(queue, ^(void) {
            
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageLink]];
            UIImage* downloadedImg = [[UIImage alloc] initWithData:imageData];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                imageDownloadedBlock(downloadedImg, imageLink);
            });
            downloadedImg = nil;
        });
    }
}

@end
