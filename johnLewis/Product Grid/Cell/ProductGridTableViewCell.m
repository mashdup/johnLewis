//
//  ProductGridTableViewCell.m
//  johnLewis
//
//  Created by Dillon Hoa on 29/07/2016.
//  Copyright © 2016 8bitDog. All rights reserved.
//

#import "ProductGridTableViewCell.h"

@interface ProductGridTableViewCell()

@end

@implementation ProductGridTableViewCell

- (id)initWithNumberOfColumns:(NSInteger)numberOfColumns reuseIdentifier:(NSString *)identifier{
    if ((self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier])){
        
    }
    return self;
}

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
}

@end
