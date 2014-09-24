//
//  MasterViewController.m
//  SelfieInsta
//
//  Created by kamlesh on 9/23/14.
//  Copyright (c) 2014 kamlesh. All rights reserved.
//

#import "SelfieCollectionViewController.h"
#import "DetailViewController.h"
#import "APIManager.h"

@interface SelfieCollectionViewController ()

@property NSMutableArray *objects;
@end

@implementation SelfieCollectionViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void) refresh {
    [[APIManager sharedManager] getSelfiePics:^(NSArray *imageList) {
        NSLog(@"");
    } andAPIManagerFailure:^(NSError *error) {
        
    }];
}
- (void) viewWillAppear:(BOOL)animated {
    [self refresh];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        NSDate *object = self.objects[indexPath.row];
//        [[segue destinationViewController] setDetailItem:object];
    }
}

#pragma mark - Collection

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return mediaArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    IKCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CPCELL" forIndexPath:indexPath];
    
    if (mediaArray.count >= indexPath.row+1) {
        InstagramMedia *media = mediaArray[indexPath.row];
        [cell.imageView setImageWithURL:media.thumbnailURL];
    }
    else
        [cell.imageView setImage:nil];
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    //    InstagramMedia *media = mediaArray[indexPath.row];
    //    [self testLoadMediaForUser:media.user];
    
    if (self.currentPaginationInfo)
    {
        //  Paginate on navigating to detail
        //either
        //        [self loadMedia];
        //or
        //        [self testPaginationRequest:self.currentPaginationInfo];
    }
}

@end
