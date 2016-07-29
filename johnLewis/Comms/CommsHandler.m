//
//  CommsHandler.m
//  johnLewis
//
//  Created by Dillon Hoa on 29/07/2016.
//  Copyright © 2016 8bitDog. All rights reserved.
//

//https://api.johnlewis.com/v1/products/search?q=dishwasher&key=Wu1Xqn3vNrd1p7hqkvB6hEu0G9OrsYGb&pageSize=20

#import "CommsHandler.h"
#import <AFNetworking/AFNetworking.h>

@implementation CommsHandler
/* 
 * For now, we are using the comms to access products directly, normally we would use a service class
 */
+ (void)getProductsWithCompletion:(void(^)(NSArray *products))completion {
    [CommsHandler requestFromResource:@"products" action:@"search" queries:@[@"q=dishwasher",@"key=Wu1Xqn3vNrd1p7hqkvB6hEu0G9OrsYGb",@"pageSize=20"] completion:^(id response) {
        if ([response isKindOfClass:[NSDictionary class]]){
            //Would normally use an entity, but doing it quick for now.
            completion(response[@"products"]);
        }
    }];
}


+ (void)requestFromResource:(NSString *)resource action:(NSString *)action queries:(NSArray *)queries completion:(void(^)(id response))completion{
    NSURLComponents *componentURL = [NSURLComponents componentsWithString:@"https://api.johnlewis.com"];
    componentURL.path = [NSString stringWithFormat:@"/v1/%@/%@",resource,action];
    componentURL.query = [queries componentsJoinedByString:@"&"];
    
    NSLog(@"URL: %@", componentURL.URL.absoluteString);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:componentURL.URL.absoluteString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completion(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
        completion(nil);
    }];
}


@end
