//
//  ProductPageModel.h
//  johnLewis
//
//  Created by Dillon Hoa on 31/07/2016.
//  Copyright © 2016 8bitDog. All rights reserved.
//
/*
 This is an incomplete model for the product, the bare minimum is used for the coding test.
 */
#import <JSONModel/JSONModel.h>

@interface ProductAdditionalServicesModel : JSONModel
@property (nonatomic, strong) NSArray *includedServices;
@property (nonatomic, strong) NSArray *optionalServices;
@end

@interface ProductImagesModel : JSONModel
@property (nonatomic, strong) NSString *altText;
@property (nonatomic, strong) NSArray *urls;
@end

@interface ProductMediaModel : JSONModel
@property (nonatomic, strong) ProductImagesModel *images;
@end

@protocol ProductFeatureAttributeModel
@end
@interface ProductFeatureAttributeModel : JSONModel
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, strong) NSString *toolTip;
@end

@protocol ProductFeaturesModel
@end
@interface ProductFeaturesModel : JSONModel
@property (nonatomic, strong) NSString *groupName;
@property (nonatomic, strong) NSArray<ProductFeatureAttributeModel> *attributes;
@end

@interface ProductDetailsModel : JSONModel
@property (nonatomic, strong) NSString *productInformation;
@property (nonatomic, strong) NSArray<ProductFeaturesModel> *features;
@end

@interface ProductPriceModel : JSONModel
@property (nonatomic, strong) NSString *currency;
@property (nonatomic, strong) NSString *now;
@property (nonatomic, strong) NSString *then1;
@property (nonatomic, strong) NSString *uom;
@property (nonatomic, strong) NSString *then2;
@property (nonatomic, strong) NSString *was;
@end

@interface ProductPageModel : JSONModel
@property (nonatomic, strong) ProductAdditionalServicesModel *additionalServices;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) ProductDetailsModel *details;
@property (nonatomic, strong) ProductMediaModel *media;
@property (nonatomic, strong) ProductPriceModel *price;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *displaySpecialOffer;

@end
