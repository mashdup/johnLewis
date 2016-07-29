//
//  GridCellViewController.m
//  johnLewis
//
//  Created by Dillon Hoa on 29/07/2016.
//  Copyright © 2016 8bitDog. All rights reserved.
//

#import "GridCellViewController.h"

@interface GridCellViewController ()
@property (nonatomic, strong) IBOutlet UITextView *shortDescriptionText;
@property (nonatomic, strong) IBOutlet UIImageView *productImageView;
@end

@implementation GridCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_gridViewWillAppear)
        _gridViewWillAppear();
}

- (void)setText:(NSString *)text andPrice:(NSString *)price {
    
}

- (void)setImageURL:(NSString *)urlString {
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
