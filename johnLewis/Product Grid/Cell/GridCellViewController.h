//
//  GridCellViewController.h
//  johnLewis
//
//  Created by Dillon Hoa on 29/07/2016.
//  Copyright © 2016 8bitDog. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GridCellViewController : UIViewController
@property (nonatomic, strong) void(^gridViewWillAppear)();
@property (nonatomic, strong) void(^gridDidTap)();
- (void)setText:(NSString *)text andPrice:(NSString *)price;
- (void)setImageURL:(NSString *)urlString;
@end
