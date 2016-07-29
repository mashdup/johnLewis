//
//  ProductPageViewController.m
//  johnLewis
//
//  Created by Dillon Hoa on 29/07/2016.
//  Copyright © 2016 8bitDog. All rights reserved.
//

#import "ProductPageViewController.h"

@interface ProductPageViewController ()

@end

@implementation ProductPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _product.title;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self switchInterface:[[UIApplication sharedApplication] statusBarOrientation]];
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self switchInterface:toInterfaceOrientation];
}

- (void)switchInterface:(UIInterfaceOrientation)orientation {
    if( UIInterfaceOrientationIsLandscape(orientation) )
    {
        [[NSBundle mainBundle] loadNibNamed: [NSString stringWithFormat:@"%@-Landscape", NSStringFromClass([self class])]
                                      owner: self
                                    options: nil];
        [self viewDidLoad];
    }
    else
    {
        [[NSBundle mainBundle] loadNibNamed: [NSString stringWithFormat:@"%@", NSStringFromClass([self class])]
                                      owner: self
                                    options: nil];
        [self viewDidLoad];
    }
}

@end
