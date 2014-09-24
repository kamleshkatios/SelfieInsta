//
//  IGCell.m
//  SelfieInsta
//
//  Created by kamlesh on 9/24/14.
//  Copyright (c) 2014 kamlesh. All rights reserved.
//

#import "IGCell.h"
#import "APIManager.h"

@interface IGCell()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation IGCell

- (void) removePreviousImage {
    self.imageView.image = nil;
}
- (void) setIgImageModel:(IGImageModel *)igImageModel {
    __weak __typeof(self) weakSelf = self;
    [[APIManager sharedManager] getImage:igImageModel.thumbnailResolution.imageUrl
                            withCallback:^(UIImage *image, NSString *imgLink) {
                                weakSelf.imageView.image = image;
                            }];
}
@end
