//
//  ProductPageHeaderViewController.m
//  johnLewis
//
//  Created by Dillon Hoa on 30/07/2016.
//  Copyright © 2016 8bitDog. All rights reserved.
//

#import "ProductPageHeaderViewController.h"

@interface ProductHeaderImageViewController : UIViewController
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSURLSessionDataTask *sessionTask;
@end

@implementation ProductHeaderImageViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    if (!_imageView){
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:_imageView];
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!_image){
        [self getImage:_imageURL];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _imageView.frame = self.view.bounds;
}

- (void)setImageURL:(NSString *)imageURL {
    _imageURL = [imageURL stringByReplacingOccurrencesOfString:@"//" withString:@""];
}

- (void)getImage:(NSString *)imageUrl {
    
    //Adapted from Apple's Lazy image load sample
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://%@",imageUrl]]];
    
    // create an session data task to obtain and download the app icon
    _sessionTask = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                   completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                       
                                                       // in case we want to know the response status code
                                                       //NSInteger HTTPStatusCode = [(NSHTTPURLResponse *)response statusCode];
                                                       
                                                       if (error != nil)
                                                       {
                                                           if ([error code] == NSURLErrorAppTransportSecurityRequiresSecureConnection)
                                                           {
                                                               // if you get error NSURLErrorAppTransportSecurityRequiresSecureConnection (-1022),
                                                               // then your Info.plist has not been properly configured to match the target server.
                                                               //
                                                               abort();
                                                           }
                                                       }
                                                       
                                                       [[NSOperationQueue mainQueue] addOperationWithBlock: ^{
                                                           
                                                           //Set this controller's image
                                                           _image = [[UIImage alloc] initWithData:data];
                                                           _imageView.image = _image;
                                                           
                                                           
                                                       }];
                                                   }];
    
    [self.sessionTask resume];
}

@end

@interface ProductPageHeaderViewController () <UIScrollViewDelegate>
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIPageControl *pageControl;
@property (nonatomic, strong) NSArray *imageViewArray;
@property (nonatomic, strong) IBOutlet UITextView *textView;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *additionalServicesConstraint;
@end

@implementation ProductPageHeaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self switchInterface:[[UIApplication sharedApplication] statusBarOrientation]];
    [_imageViewArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[ProductHeaderImageViewController class]]){
            ProductHeaderImageViewController *imageController = obj;
            imageController.view.frame = CGRectMake(_scrollView.bounds.size.width * idx,
                                                    0,
                                                    _scrollView.bounds.size.width,
                                                    _scrollView.bounds.size.height);
        }
    }];
    _scrollView.contentSize = CGSizeMake(_scrollView.bounds.size.width * _imageViewArray.count, _scrollView.bounds.size.height);
    CGRect frame = _scrollView.frame;
    frame.origin.x = frame.size.width * _pageControl.currentPage;
    frame.origin.y = 0;
    [_scrollView scrollRectToVisible:frame animated:NO];
}

- (void)setImages:(NSArray *)images {
    _pageControl.numberOfPages = images.count;
    NSMutableArray *imageViews = [NSMutableArray arrayWithCapacity:images.count];
    [images enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSString class]]){
            ProductHeaderImageViewController *imageController = [ProductHeaderImageViewController new];
            imageController.imageURL = obj;
            imageController.view.frame = CGRectMake(_scrollView.bounds.size.width * idx,
                                                    0,
                                                    _scrollView.bounds.size.width,
                                                    _scrollView.bounds.size.height);
            [imageViews addObject:imageController];
            [_scrollView addSubview:imageController.view];
        }
    }];
    _scrollView.contentSize = CGSizeMake(_scrollView.bounds.size.width * images.count, _scrollView.bounds.size.height);
    _imageViewArray = imageViews;
}

- (void)setAdditionalServicesText:(NSAttributedString *)attrString {
    _textView.attributedText = attrString;
}

#pragma mark - Orientation methods

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self switchInterface:toInterfaceOrientation];
    
}

- (void)switchInterface:(UIInterfaceOrientation)orientation {
    if( UIInterfaceOrientationIsLandscape(orientation) )
    {
        _additionalServicesConstraint.constant = 0.;
        
    }
    else
    {
        _additionalServicesConstraint.constant = 100.;
    }
}

#pragma mark - page control methods

- (IBAction)pageControlDidChange:(UIPageControl *)sender {
    CGRect frame = _scrollView.frame;
    frame.origin.x = frame.size.width * sender.currentPage;
    frame.origin.y = 0;
    [_scrollView scrollRectToVisible:frame animated:YES];
}

#pragma mark - scroll methods

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
    _pageControl.currentPage = currentPage;
}

@end
