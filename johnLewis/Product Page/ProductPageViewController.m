//
//  ProductPageViewController.m
//  johnLewis
//
//  Created by Dillon Hoa on 29/07/2016.
//  Copyright © 2016 8bitDog. All rights reserved.
//

#import "ProductPageViewController.h"
#import "ProductPageHeaderViewController.h"
#import "CommsHandler.h"
#import "ProductPageInformationTableViewCell.h"

#import "ProductPageModel.h"

@interface ProductTableView : UITableView
@end
/* 
 Subclassing the table view allows us to set the table headerview frame properly
 */
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
@property (nonatomic, strong) ProductPageModel *productModel;
@property (nonatomic, strong) IBOutlet UITextView *productServicesTextView;
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
    [CommsHandler getProductWithId:_gridProduct.productId completion:^(NSDictionary *productDictionary) {
        ProductPageModel *model = [[ProductPageModel alloc] initWithDictionary:productDictionary error:nil];
        if (model) {
            _productModel = model;
            [_tableView reloadData];
            
            //set the images for the header
            if (_productHeader)
                [_productHeader setImages:_productModel.media.images.urls];
            
            //Set guarantee  and price text
            _productServicesTextView.attributedText = [self priceAndGuaranteeString];
            [_productHeader setAdditionalServicesText:[self priceAndGuaranteeString]];
        }
    }];
}

- (void)pageSetup {
    if (!_productHeader) {
        _productHeader = [ProductPageHeaderViewController new]; 
    }
    _productHeader.view.frame = CGRectMake(0, 0, _tableView.bounds.size.width, 400);
    _tableView.tableHeaderView = _productHeader.view;
    
    [_tableView reloadData];
    
    if (!_productModel)return;
    _productServicesTextView.attributedText = [self priceAndGuaranteeString];
    [_productHeader setAdditionalServicesText:[self priceAndGuaranteeString]];
}

- (NSAttributedString *)priceAndGuaranteeString {
    NSMutableAttributedString *descString = [[NSMutableAttributedString alloc] initWithString:@""];
    [descString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"£%@\n",_productModel.price.now] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:24. weight:UIFontWeightBold]}]];
    if (_productModel.displaySpecialOffer.length > 0)
        [descString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n",_productModel.displaySpecialOffer] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14. weight:UIFontWeightRegular],NSForegroundColorAttributeName:[UIColor colorWithRed:170./255. green:43./255. blue:43./255. alpha:1.]}]];
    
    [_productModel.additionalServices.includedServices enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSString class]]){
            
            [descString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n",obj] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16. weight:UIFontWeightRegular],NSForegroundColorAttributeName:[UIColor darkGrayColor]}]];
        }
    }];
    return descString;
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
    if (section == 0)
        return 2;
    if (section == 1) {
        ProductFeaturesModel *feature = _productModel.details.features.firstObject;
        return feature.attributes.count;
    }
    
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0){
        if (indexPath.row == 0)
            return 200;
    }
    
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *labelView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 44)];
    labelView.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, labelView.bounds.size.width-30, 44)];
    label.textColor = [UIColor darkGrayColor];
    label.font = [UIFont systemFontOfSize:20. weight:UIFontWeightLight];
    
    [labelView addSubview:label];
    
    if (section == 0)
        label.text = @"Product information";
    if (section == 1)
        label.text = @"Prodcut specification";
    return labelView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section ==0) {
        
        if (indexPath.row == 0) {
            ProductPageInformationTableViewCell *cell = (ProductPageInformationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ProdInfoCell"];
            if (!cell) {
                NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ProductPageInformationTableViewCell" owner:nil options:nil];
                
                for(id currentObject in topLevelObjects)
                {
                    if([currentObject isKindOfClass:[ProductPageInformationTableViewCell class]])
                    {
                        cell = (ProductPageInformationTableViewCell *)currentObject;
                        break;
                    }
                }
            }
            [cell setProductCode:_productModel.code andDescription:_productModel.details.productInformation];
            return cell;
        }
        
        if (indexPath.row == 1) {
        
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InfoCell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"InfoCell"];
            }
            
            cell.textLabel.text = @"Read more";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
        
    }
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SpecificiationCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"SpecificiationCell"];
        cell.textLabel.font = [UIFont systemFontOfSize:15. weight:UIFontWeightRegular];
        cell.textLabel.textColor = [UIColor darkGrayColor];
    }
    if (_productModel){
        ProductFeaturesModel *feature = _productModel.details.features.firstObject;
        ProductFeatureAttributeModel *attribute = feature.attributes[indexPath.row];
        cell.textLabel.text = attribute.name;
        cell.detailTextLabel.text = attribute.value;
    }
    return cell;
}

@end
