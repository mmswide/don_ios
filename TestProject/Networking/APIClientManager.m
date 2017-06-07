//
//  APIClientManager.m
//  TestProject
//
//  Created by Fantastic on 06/09/16.
//  Copyright © 2016 Fantastic. All rights reserved.
//

#import "APIClientManager.h"

static NSString * const AFAppDotNetAPIBaseURLString = @"https://tiwa.herokuapp.com/";

@implementation APIClientManager
+ (instancetype)sharedManager {
    static APIClientManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[APIClientManager alloc] initWithBaseURL:[NSURL URLWithString:AFAppDotNetAPIBaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return _sharedClient;
}
@end
