//
//  IGCell.h
//  SelfieInsta
//
//  Created by kamlesh on 9/24/14.
//  Copyright (c) 2014 kamlesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IGImageModel.h"

@interface IGCell : UICollectionViewCell
@property (nonatomic, strong) IGImageModel* igImageModel;
- (void) removePreviousImage;
@end
