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
#import "IGCell.h"
#import "IGImageModel.h"
#import "DetailViewController.h"

@interface SelfieCollectionViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
- (IBAction)clearAction:(id)sender;

@property NSMutableArray *imageList;
@end

@implementation SelfieCollectionViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (IBAction)clearAction:(id)sender {
    [self.imageList removeAllObjects];
    [self refreshWithIndex:0];
    [self.collectionView reloadData];
}
- (void) refreshWithIndex:(NSInteger) startIndex {
    __weak __typeof(self) weakSelf = self;    
    [[APIManager sharedManager] getSelfiePics:^(NSMutableArray *imageList) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.imageList addObjectsFromArray:imageList];
            [weakSelf.collectionView reloadData];
        });
    } andAPIManagerFailure:^(NSError *error) {
        
    } startIndex:startIndex];
}
- (void) viewWillAppear:(BOOL)animated {
    self.collectionView.bounds = self.view.bounds;
    [self refreshWithIndex:0];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageList = [NSMutableArray array];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"DetailView"]) {
        DetailViewController *detailView = [segue destinationViewController];
        NSIndexPath *selectedIndexPath = [self.collectionView indexPathsForSelectedItems][0];
        detailView.igImageModel = self.imageList[selectedIndexPath.item];
    }
}

#pragma mark - Collection

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.view.frame.size.width > 320) {
        return CGSizeMake(120, 120);
    }
    return CGSizeMake(106, 106);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    IGCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IGCELL" forIndexPath:indexPath];
    [cell removePreviousImage];
    if (self.imageList.count >= indexPath.row+1) {
        IGImageModel *media = self.imageList[indexPath.row];
        [cell setIgImageModel:media];
    }
    if (indexPath.item == [self.imageList count] - 1) {
        [self refreshWithIndex:indexPath.item];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

@end
