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
#import "ProductModel.h"

@interface ProductGridViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *loadingHeightContraint;
@property (nonatomic, strong) NSArray *productsArray;
@property (nonatomic, assign) NSInteger numberOfColumns;
@end

@implementation ProductGridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Dishwashers";
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    self.extendedLayoutIncludesOpaqueBars = YES;
    _loadingHeightContraint.constant = 0;
    
    _numberOfColumns = 4;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self showLoadingLabel:YES];
    [CommsHandler getProductsWithCompletion:^(NSArray *products) {
        //Convert products into Models
        NSMutableArray *prods = [NSMutableArray array];
        [products enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[NSDictionary class]]){
                ProductModel *model = [[ProductModel alloc] initWithDictionary:obj error:nil];
                if (model)
                    [prods addObject:model];
            }
        }];
        _productsArray = prods;
        [self showLoadingLabel:NO];
        [_tableView reloadData];
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
    return (int)ceil((float)_productsArray.count/(float)_numberOfColumns);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 320;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductGridTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[ProductGridTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell setNumberOfColumns:_numberOfColumns];
    [cell setWillDislpayGrid:^(NSInteger indexOfGrid, UITableViewCell *gridCell, GridCellViewController *gridView) {
        //Set the data for the grid view
        NSInteger index = (indexPath.row * _numberOfColumns) + indexOfGrid;
        if (index < _productsArray.count){
            ProductModel *product = _productsArray[index];
            [gridView setText:product.title andPrice:product.price.now];
            [gridView setImageURL:product.image];
        }
        
    }];
    [cell setGridDidTap:^(NSInteger indexOfGrid, UITableViewCell *gridCell, GridCellViewController *gridView) {
         NSInteger index = (indexPath.row * _numberOfColumns) + indexOfGrid;
        if (index < _productsArray.count){
            ProductModel *product = _productsArray[index];
        }
    }];
    
    return cell;
}



@end
