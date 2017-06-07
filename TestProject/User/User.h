//
//  User.h
//  TestProject
//
//  Created by Fantastic on 06/09/16.
//  Copyright © 2016 Fantastic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (nonatomic, assign) NSString *userID;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *token;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

+ (NSURLSessionDataTask *)createUserAccountWithEmail:(NSString *)email password:(NSString *)password block:(void (^)(NSDictionary *dict, NSError *error))block;
+ (NSURLSessionDataTask *)loginWithEmail:(NSString *)email password:(NSString *)password block:(void (^)(NSDictionary *dict, NSError *error))block;
+ (NSURLSessionDataTask *)signoutWithUserToken:(NSString *)token block:(void (^)(BOOL success, NSError *error))block;
+ (NSURLSessionDataTask *)forgetPassWithEmail:(NSString *)email block:(void (^)(BOOL isSuccess, NSString *data, NSError *error))block;

+(void)saveUser:(User *)user;

@end

@interface User (NSCoding) <NSSecureCoding>
@end
