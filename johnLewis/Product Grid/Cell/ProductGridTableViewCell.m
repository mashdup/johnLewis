//
//  ProductGridTableViewCell.m
//  johnLewis
//
//  Created by Dillon Hoa on 29/07/2016.
//  Copyright © 2016 8bitDog. All rights reserved.
//

#import "ProductGridTableViewCell.h"

@interface ProductGridTableViewCell()
@property (nonatomic, strong) NSArray *gridViewArray;
@end

@implementation ProductGridTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat gridWidth = self.bounds.size.width/_gridViewArray.count;
    [_gridViewArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[GridCellViewController class]]){
            GridCellViewController *grid = obj;
            grid.view.frame = CGRectMake(gridWidth*idx, 0, gridWidth, self.bounds.size.height);
        }
    }];
}

- (void)setNumberOfColumns:(NSInteger)numberOfColumns {
    //Clear all subviews
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    //Create new ones with desired number
    _numberOfColumns = numberOfColumns;
    NSMutableArray *gridViews = [NSMutableArray arrayWithCapacity:numberOfColumns];
    for (int i = 0; i < numberOfColumns; i++){
        GridCellViewController *grid = [GridCellViewController new];
        [gridViews addObject:grid];
        [self addSubview:grid.view];
        
        [grid setGridViewWillAppear:^{
            if (_willDislpayGrid)
                _willDislpayGrid(i,self,_gridViewArray[i]);
        }];
    }
    _gridViewArray = gridViews;
}

@end
