//
//  ProductPageInformationTableViewCell.m
//  johnLewis
//
//  Created by Dillon Hoa on 31/07/2016.
//  Copyright © 2016 8bitDog. All rights reserved.
//

#import "ProductPageInformationTableViewCell.h"

@interface ProductPageInformationTableViewCell()
@property (nonatomic, strong) IBOutlet UITextView *textView;
@end

@implementation ProductPageInformationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
