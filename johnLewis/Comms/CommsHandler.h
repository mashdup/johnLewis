//
//  CommsHandler.h
//  johnLewis
//
//  Created by Dillon Hoa on 29/07/2016.
//  Copyright © 2016 8bitDog. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommsHandler : NSObject
+ (void)getProductsWithCompletion:(void(^)(NSArray *products))completion;
+ (void)getProductWithId:(NSString *)idString completion:(void(^)(NSDictionary *productDictionary))completion;
@end
