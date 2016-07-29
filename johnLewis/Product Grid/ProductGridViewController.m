//
//  ProductGridViewController.m
//  johnLewis
//
//  Created by Dillon Hoa on 29/07/2016.
//  Copyright © 2016 8bitDog. All rights reserved.
//

#import "ProductGridViewController.h"
#import "ProductGridTableViewCell.h"
#import "CommsHandler.h"

@interface ProductGridViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *loadingHeightContraint;
@end

@implementation ProductGridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Dishwashers";
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    _loadingHeightContraint.constant = 0;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self showLoadingLabel:YES];
    [CommsHandler getProductsWithCompletion:^(NSArray *products) {
        //Convert products into Models
        
        [self showLoadingLabel:NO];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)showLoadingLabel:(BOOL)show {
    //Make sure animations are done on the Main Thread
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateKeyframesWithDuration:.6 delay:show?0.:.5 options:UIViewKeyframeAnimationOptionBeginFromCurrentState animations:^{
            _loadingHeightContraint.constant = show ? 32 : 0;
        } completion:^(BOOL finished) {
            
        }];
    });
}

#pragma mark - TableView Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 320;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductGridTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[ProductGridTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    [cell setNumberOfColumns:4];
    [cell setWillDislpayGrid:^(NSInteger indexOfGrid, UITableViewCell *gridCell, GridCellViewController *gridView) {
        //Set the data for the grid view
        
    }];
    
    return cell;
}

@end
