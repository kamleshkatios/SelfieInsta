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

NSString *const kInstagramBaseUrl = @"https://api.instagram.com/v1/";

NSString *const kTagPath = @"tags/selfie/media/recent";

//http://api.instagram.com/v1/tags/selfie/media/recent?client_id=df6485e2c3204e4cadbde4050c29700f&count=15

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

- (void) getSelfiePics:(APIManagerCompleted) apiManagerCompleted
  andAPIManagerFailure:(APIManagerFailure) apiManagerFailure {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:CLIENT_ID forKey:kKeyClientID];
    [params setObject:@"15" forKey:kCount];
    //    [params setObject:@"0" forKey:@"min_id"];
    //    [params setObject:@"15" forKey:@"max_id"];
    
    __block NSMutableArray *imageList = [NSMutableArray array];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[kInstagramBaseUrl stringByAppendingString:kTagPath] parameters:params
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSArray *dataList = responseObject[@"data"];
             [dataList enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
                 NSDictionary* imageDict = dict[@"images"];
                 IGImageModel *igImageModel = [[IGImageModel alloc] initWithDictionary:imageDict];
                 [imageList addObject:igImageModel];
             }];
             apiManagerCompleted(imageList);
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             apiManagerFailure (error);
         }];
}

//- (void) getSelfiePicsCompletion: {
//    
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:CLIENT_ID forKey:kKeyClientID];
//    [params setObject:@"15" forKey:kCount];
////    [params setObject:@"0" forKey:@"min_id"];
////    [params setObject:@"15" forKey:@"max_id"];
//    
//    __block NSMutableArray *imageList = [NSMutableArray array];
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager GET:[kInstagramBaseUrl stringByAppendingString:kTagPath] parameters:params
//         success:^(AFHTTPRequestOperation *operation, id responseObject) {
//             NSArray *dataList = responseObject[@"data"];
//             [dataList enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
//                 NSDictionary* imageDict = dict[@"images"];
//                 IGImageModel *igImageModel = [[IGImageModel alloc] initWithDictionary:imageDict];
//                 [imageList addObject:igImageModel];
//             }];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];
//}

//- (NSString * ) setParameterFor:(NSString *) urlString andDict:(NSDictionary*) params {
//    
//    __block NSString* urlString_ = [kInstagramBaseUrl stringByAppendingString:urlString];
//    [params enumerateKeysAndObjectsUsingBlock:^(NSString* key, NSString* obj, BOOL *stop) {
//        urlString_ = [urlString_ stringByAppendingFormat:@"&%@=%@",key,obj];
//    }];
//    
//    if ([urlString_ rangeOfString:@"?&"].location != NSNotFound) {
//        urlString_ = [urlString_ stringByReplacingOccurrencesOfString:@"?&" withString:@"?"];
//    }
//    return urlString_;
//}

//- (void) addComment:(NSString *) comment {
//    
//    __block NSString *urlString = [URL_SERVER stringByAppendingString:URL_ADD_COMMENT];
//    
//    
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:GLOBAL.userInfo.userID forKey:@"userId"];
//    [params setObject:GLOBAL.selectedLogModal.logID forKey:@"logId"];
//    [params setObject:comment forKey:@"comment"];
//    
//    if (self.accessToken) {
//        [params setObject:self.accessToken forKey:kKeyAccessToken];
//    }
//    else
//    {
//        [params setObject:self.appClientID forKey:kKeyClientID];
//    }
//    
//    NSURL *url = [NSURL URLWithString:urlString];
//    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url
//                                                                cachePolicy:NSURLRequestReloadIgnoringCacheData
//                                                            timeoutInterval:30.0];
//    
//    NSError *error = nil;
//    NSData *paraData = [NSJSONSerialization dataWithJSONObject:params
//                                                       options:NSJSONWritingPrettyPrinted
//                                                         error:&error];
//    
//    NSString *length = [NSString stringWithFormat:@"%lu", (unsigned long)[paraData length]];
//    
//    [request setHTTPMethod:@"PUT"];
//    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [request setValue:length forHTTPHeaderField:@"Content-Length"];
//    [request setHTTPBody:paraData];
//    [request setValue: GLOBAL.userInfo.authToken forHTTPHeaderField:@"auth-token"];
//    
//    //no cookies.
//    [request setHTTPShouldHandleCookies:NO];
//    
//    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
//    [NSURLConnection sendAsynchronousRequest:request queue:operationQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        
//        if (data) {
//            NSError *error= nil;
//            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data
//                                                                         options:NSJSONReadingMutableContainers
//                                                                           error:&error];
//            
//            BOOL isSuccess = [[responseDict nonNullobjectForKey:@"success"] boolValue];
//            if (isSuccess) {
//                [self startContentForAPI:APITypeLogComments withSearchQuery:nil];
//            } else {
//                //_apiResponse(NO, apiType);
//            }
//        } else {
//        }
//    }];
//}


@end
