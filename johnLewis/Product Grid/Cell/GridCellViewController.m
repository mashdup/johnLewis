//
//  GridCellViewController.m
//  johnLewis
//
//  Created by Dillon Hoa on 29/07/2016.
//  Copyright © 2016 8bitDog. All rights reserved.
//

#import "GridCellViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface GridCellViewController ()
@property (nonatomic, strong) IBOutlet UITextView *shortDescriptionText;
@property (nonatomic, strong) IBOutlet UIImageView *productImageView;
@property (nonatomic, strong) NSURLSessionDataTask *sessionTask;
@end

static NSMutableDictionary *imageCache;

@implementation GridCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.layer.borderWidth = .5;
    self.view.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    //Register a tap
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gridDidTap:)];
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (_gridViewWillAppear)
        _gridViewWillAppear();
}

#pragma mark - Gestures

- (void)gridDidTap:(UITapGestureRecognizer *)tap {
    if (tap.state == UIGestureRecognizerStateEnded){
        if (_gridDidTap)
            _gridDidTap();
    }
}

#pragma mark - element setters

- (void)setText:(NSString *)text andPrice:(NSString *)price {
    NSMutableAttributedString *descString = [[NSMutableAttributedString alloc] initWithString:text];
    NSAttributedString * priceString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n£%@",price] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15. weight:UIFontWeightBold]}];
    [descString appendAttributedString:priceString];
    _shortDescriptionText.attributedText = descString;
}

- (void)setImageURL:(NSString *)urlString {
    NSString *imageUrlString = [urlString stringByReplacingOccurrencesOfString:@"//" withString:@""];
    if (imageCache[imageUrlString]){
        [[NSOperationQueue mainQueue] addOperationWithBlock: ^{
            _productImageView.image = imageCache[imageUrlString];
        }];
    } else
        [self getImage:imageUrlString];
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
                                                           
                                                           // Set appIcon and clear temporary data/image
                                                           UIImage *image = [[UIImage alloc] initWithData:data];
                                                           if (!imageCache){
                                                               imageCache = [[NSMutableDictionary alloc] init];
                                                           }
                                                           _productImageView.image = image;
                                                           [imageCache setValue:image forKey:imageUrl];
                                                           
                                                           
                                                       }];
                                                   }];
    
    [self.sessionTask resume];
}

@end
