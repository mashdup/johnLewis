//
//  ProductModel.h
//  johnLewis
//
//  Created by Dillon Hoa on 29/07/2016.
//  Copyright © 2016 8bitDog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JSONModel/JSONModel.h>

@interface ProductPriceModel : JSONModel
@property (nonatomic, strong) NSString *currency;
@property (nonatomic, strong) NSString *now;
@property (nonatomic, strong) NSString *then1;
@property (nonatomic, strong) NSString *uom;
@property (nonatomic, strong) NSString *then2;
@property (nonatomic, strong) NSString *was;
@end

@interface ProductModel : JSONModel
@property (nonatomic, strong) NSArray <NSString *> *additionalServices;
@property (nonatomic, strong) NSString *availabilityMessage;
@property (nonatomic, assign) float averageRating;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, assign) BOOL colorSwatchSelected;
@property (nonatomic, assign) BOOL outOfStock;
@property (nonatomic, strong) NSArray *colorSwatches;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) ProductPriceModel *price;
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *type;
@end
