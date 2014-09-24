//
//  DetailViewController.h
//  SelfieInsta
//
//  Created by kamlesh on 9/23/14.
//  Copyright (c) 2014 kamlesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

