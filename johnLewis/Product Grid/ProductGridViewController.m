//
//  ProductGridViewController.m
//  johnLewis
//
//  Created by Dillon Hoa on 29/07/2016.
//  Copyright © 2016 8bitDog. All rights reserved.
//

#import "ProductGridViewController.h"

@interface ProductGridViewController ()

@end

@implementation ProductGridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Dishwashers";
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    self.extendedLayoutIncludesOpaqueBars = YES;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
