//
//  ProductGridTableViewCell.h
//  johnLewis
//
//  Created by Dillon Hoa on 29/07/2016.
//  Copyright © 2016 8bitDog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GridCellViewController.h"

@interface ProductGridTableViewCell : UITableViewCell
@property (nonatomic, assign) NSInteger numberOfColumns;
@property (nonatomic, strong) void(^willDislpayGrid)(NSInteger gridPosition, UITableViewCell *gridCell, GridCellViewController *gridView);
@property (nonatomic, strong) void(^gridDidTap)(NSInteger gridPosition, UITableViewCell *gridCell, GridCellViewController *gridView);
@end
