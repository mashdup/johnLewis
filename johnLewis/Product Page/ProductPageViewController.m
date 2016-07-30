//
//  ProductPageViewController.m
//  johnLewis
//
//  Created by Dillon Hoa on 29/07/2016.
//  Copyright © 2016 8bitDog. All rights reserved.
//

#import "ProductPageViewController.h"
#import "ProductPageHeaderViewController.h"
@interface ProductTableView : UITableView
@end

@implementation ProductTableView : UITableView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.tableHeaderView) {
        UIView *header = self.tableHeaderView;
        CGRect rect = CGRectMake(0, 0, self.bounds.size.width,
                                 400);
        
        if (!CGRectEqualToRect(self.tableHeaderView.frame, rect)) {
            header.frame = rect;
            self.tableHeaderView = header;
        }
    }
}

@end
@interface ProductPageViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) IBOutlet ProductTableView *tableView;
@property (nonatomic, strong) ProductPageHeaderViewController *productHeader;

@end

@implementation ProductPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _gridProduct.title;
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    self.extendedLayoutIncludesOpaqueBars = YES;
    NSLog(@"Product Selected: %@",_gridProduct.toDictionary);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self switchInterface:[[UIApplication sharedApplication] statusBarOrientation]];
    [self pageSetup];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)pageSetup {
    if (!_productHeader) {
        _productHeader = [ProductPageHeaderViewController new]; 
    }
    _productHeader.view.frame = CGRectMake(0, 0, _tableView.bounds.size.width, 400);
    _tableView.tableHeaderView = _productHeader.view;
}

#pragma mark - Switch interface from orientation

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
    [self pageSetup];
}

#pragma mark - Table Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"Cell"];
    }
    return cell;
}

@end
