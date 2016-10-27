//
//  UMRequestsManager.m
//  ArcTouch
//
//  Created by Herzon Rodriguez on 10/27/16.
//  Copyright © 2016 Symmetry Apps. All rights reserved.
//

#import "UMRequestsManager.h"

#define UMShouldUseLocalDataIfServiceIsDown 1

#define UMUserCurrentLocale [[[NSLocale currentLocale] localeIdentifier] stringByReplacingOccurrencesOfString:@"_" withString:@"-"]

static NSString * const kUMTMDbErrorDomain = @"com.symmetryapps.arctouch";

static NSString * const kUMTMDbBaseAPIPath = @"https://api.themoviedb.org";

static NSString * const kUMMoviesListRequestPath = @"/movie/upcoming";
static NSString * const kUMGenresListRequestPath = @"/genre/movie/list";

@implementation UMRequestsManager

#pragma mark - Class Methods

+ (void)getUpcomingMoviesListWithCompletionHandler:(void (^)(id responseObject, NSError *error))completionHandler {
    [UMRequestsManager sendGETRequestWithPath:kUMMoviesListRequestPath
                                   parameters:@{@"language": UMUserCurrentLocale}
                            completionHandler:^(id responseObject, NSError *error) {
                                if (UMShouldUseLocalDataIfServiceIsDown) {
                                    responseObject = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"TMDb" ofType:@"json"]] options:NSJSONReadingMutableLeaves error:nil];
                                    error = responseObject ? nil : error;
                                }
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    completionHandler(responseObject, error);
                                });    
                            }];
}

+ (void)getMoviesGenresListWithCompletionHandler:(void (^)(id responseObject, NSError *error))completionHandler {
    [UMRequestsManager sendGETRequestWithPath:kUMGenresListRequestPath
                                   parameters:@{@"language": UMUserCurrentLocale}
                            completionHandler:^(id responseObject, NSError *error) {
                                if (UMShouldUseLocalDataIfServiceIsDown) {
                                    responseObject = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Genres" ofType:@"json"]] options:NSJSONReadingMutableLeaves error:nil];
                                    error = responseObject ? nil : error;
                                }
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    completionHandler(responseObject, error);
                                });
                            }];
}

#pragma mark - General Methods

+ (void)sendGETRequestWithPath:(NSString *)path
                    parameters:(NSDictionary *)parameters
                   completionHandler:(void (^)(id responseObject, NSError *error))completionHandler {
    NSString *stringParams = parameters ? [UMRequestsManager parseParamsToString:parameters] : @"";
    NSURL *endPointURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@?api_key=%@%@", kUMTMDbBaseAPIPath, path, kUMTMDbAPIKey, stringParams]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:endPointURL
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error || !data) {
                                                        completionHandler(nil, error);
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSError *jsonError = nil;
                                                        id responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&jsonError];
                                                        if (httpResponse.statusCode == 200 && !jsonError) {
                                                            completionHandler(responseObject, nil);
                                                        } else {
                                                            NSString *localizedDescriptionMessage = jsonError ? @"There was an unkown error. Please try again later" : responseObject[@"status_message"];
                                                            NSError *error = [NSError errorWithDomain:kUMTMDbErrorDomain code:httpResponse.statusCode userInfo:@{NSLocalizedDescriptionKey: localizedDescriptionMessage}];
                                                            completionHandler(nil, error);
                                                        }
                                                    }
                                                }];
    [dataTask resume];
}

#pragma mark - Helpers

+ (NSString *)parseParamsToString:(NSDictionary *)params {
    NSMutableString *stringParams = [[NSMutableString alloc] initWithString:@"&"];
    for (int i = 0; i < [params allKeys].count; i++) {
        NSString *mainKey = [params allKeys][i];
        NSMutableString *value = [NSMutableString new];
        
        if ([params[mainKey] isKindOfClass:[NSArray class]]) {
            [value appendString:[params[mainKey] componentsJoinedByString:@","]];
        } else {
            value = params[mainKey];
        }
        
        [stringParams appendFormat:@"%@=%@", mainKey, value];
        if (i < [params allKeys].count-1) {
            [stringParams appendString:@"&"];
        }
    }
    
    return stringParams;
}

@end
