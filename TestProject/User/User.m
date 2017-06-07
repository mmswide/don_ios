//
//  User.m
//  TestProject
//
//  Created by Fantastic on 06/09/16.
//  Copyright © 2016 Fantastic. All rights reserved.
//

#import "User.h"

#import "APIClientManager.h"

@implementation User
- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.userID = [attributes valueForKeyPath:@"id"];
    self.email = [attributes valueForKeyPath:@"email"];
    self.name = [attributes valueForKeyPath:@"name"];
    self.token = [attributes valueForKeyPath:@"token"];
    
    
    return self;
}

#pragma mark -

+ (NSURLSessionDataTask *)createUserAccountWithEmail:(NSString *)email password:(NSString *)password block:(void (^)(NSDictionary *dict, NSError *error))block {
    NSDictionary *parameters = @{@"email": email, @"password": password};
    return [[APIClientManager sharedManager] POST:@"api/v1/accounts/create" parameters:parameters progress:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSDictionary *dict = (NSDictionary *) JSON;
        if (block) {
            block(dict, nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
}
+ (NSURLSessionDataTask *)loginWithEmail:(NSString *)email password:(NSString *)password block:(void (^)(NSDictionary *dict, NSError *error))block {
    NSDictionary *parameters = @{@"email": email, @"password": password};
    return [[APIClientManager sharedManager] POST:@"api/v1/accounts/sign_in" parameters:parameters progress:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSDictionary *dict = (NSDictionary *) JSON;        
        
        if (block) {
            block(dict, nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
}
+ (NSURLSessionDataTask *)signoutWithUserToken:(NSString *)token block:(void (^)(BOOL success, NSError *error))block {
    NSDictionary *parameters = @{@"token": token};
    return [[APIClientManager sharedManager] POST:@"api/v1/accounts/sign_out" parameters:parameters progress:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSInteger status = [[JSON valueForKeyPath:@"status"] integerValue];
        BOOL isSuccess = NO;
        if (status == 1) {
            isSuccess = YES;
        }
        if (block) {
            block(isSuccess, nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
}
+ (NSURLSessionDataTask *)forgetPassWithEmail:(NSString *)email block:(void (^)(BOOL isSuccess, NSString *data, NSError *error))block {
    NSDictionary *parameters = @{@"email": email};
    return [[APIClientManager sharedManager] GET:@"api/v1/accounts/forgot_password" parameters:parameters progress:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSInteger status = [[JSON valueForKeyPath:@"status"] integerValue];
        NSString *data = [JSON valueForKeyPath:@"data"];
        BOOL isSuccess = NO;
        
        if (status == 1) {
            isSuccess = YES;
        }
        if (block) {
            block(isSuccess, data, nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block(nil, nil, error);
        }
    }];
}
+(void)saveUser:(User *)user {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:YES forKey:@"isLoggedin"];
    [userDefaults setObject:user.userID forKey:@"userId"];
    [userDefaults setObject:user.email forKey:@"email"];
    [userDefaults setObject:user.token forKey:@"token"];
    [userDefaults setObject:user.name forKey:@"name"];
    
    [userDefaults synchronize];
    
}
+(void)logout {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:NO forKey:@"Application Unlocked"];
    [userDefaults removeObjectForKey:@"userId"];
    [userDefaults removeObjectForKey:@"email"];
    [userDefaults removeObjectForKey:@"token"];
    [userDefaults removeObjectForKey:@"name"];
    
    [userDefaults synchronize];
}
@end


@implementation User (NSCoding)

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.userID forKey:@"AF.userID"];
    [aCoder encodeObject:self.email forKey:@"AF.email"];
    [aCoder encodeObject:self.name forKey:@"AF.name"];
    [aCoder encodeObject:self.token forKey:@"AF.token"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.userID = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"AF.userID"];
    self.email = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"AF.email"];
    self.name = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"AF.name"];
    self.token = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"AF.token"];
    
    return self;
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

@end