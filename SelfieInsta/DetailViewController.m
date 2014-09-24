//
//  DetailViewController.m
//  SelfieInsta
//
//  Created by kamlesh on 9/23/14.
//  Copyright (c) 2014 kamlesh. All rights reserved.
//

#import "DetailViewController.h"
#import "APIManager.h"

@interface DetailViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak __typeof(self) weakSelf = self;
    [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
    float width = self.view.frame.size.width;
    [self.imageView setFrame:CGRectMake((self.view.frame.size.width-width)/2, (self.view.frame.size.height-width)/2, width, width)];
    [[APIManager sharedManager] getImage:self.igImageModel.standarResolution.imageUrl
                            withCallback:^(UIImage *image, NSString *imgLink) {
                                weakSelf.imageView.image = image;
                            }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
