//
//  APIClientManager.h
//  TestProject
//
//  Created by Fantastic on 06/09/16.
//  Copyright © 2016 Fantastic. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "User.h"

@interface APIClientManager : AFHTTPSessionManager

@property (nonatomic, strong) User *currentUser;
+ (instancetype)sharedManager;
@end
