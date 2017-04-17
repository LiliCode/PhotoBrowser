//
//  PhotoBrowserController.m
//  PhotoBrowser
//
//  Created by LiliEhuu on 17/4/17.
//  Copyright © 2017年 LiliEhuu. All rights reserved.
//

#import "PhotoBrowserController.h"
#import "PhotoBrowserItem.h"

@interface PhotoBrowserController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (strong , nonatomic) UICollectionView *collectionView;
@property (strong , nonatomic) NSArray *list;

@end

@implementation PhotoBrowserController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initInterface];
    
}

- (void)initInterface
{
    //layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal; //水平滚动
    self.collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.pagingEnabled = YES;    //整页滚动
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.collectionView];
    //注册Cell
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([PhotoBrowserItem class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
}

+ (instancetype)browser
{
    return [[self alloc] init];
}

- (void)setPhotos:(NSArray *)photos
{
    self.list = [photos copy];
}





#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoBrowserItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.data = [self.list objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}



#pragma mark - 内存警告

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


@end




