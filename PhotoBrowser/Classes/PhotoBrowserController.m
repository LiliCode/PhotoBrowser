//
//  PhotoBrowserController.m
//  PhotoBrowser
//
//  Created by LiliEhuu on 17/4/17.
//  Copyright © 2017年 LiliEhuu. All rights reserved.
//

#import "PhotoBrowserController.h"
#import "PhotoBrowserItem.h"
#import "PhotoBroeserNavigationView.h"

@interface PhotoBrowserController ()<UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PhotoBroeserNavigationViewDelegate>
@property (strong , nonatomic) UICollectionView *collectionView;
@property (strong , nonatomic) PhotoBroeserNavigationView *navigationView;
@property (strong , nonatomic) UIPageControl *pageControl;
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
    //UIPageControl
    self.pageControl = [[UIPageControl alloc] init];
    CGSize size = [UIScreen mainScreen].bounds.size;
    self.pageControl.bounds = CGRectMake(0, 0, size.width - 20, 100);
    self.pageControl.center = CGPointMake(size.width * .5, size.height - 40);
    self.pageControl.numberOfPages = [self.list count];
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    self.pageControl.currentPage = 0;
    [self.view addSubview:self.pageControl];
    //顶部视图
    [self initNavigationView];
}

+ (instancetype)browser
{
    return [[self alloc] init];
}

- (void)setPhotos:(NSArray *)photos
{
    self.list = [photos copy];
}

- (void)initNavigationView
{
    self.navigationView = [[PhotoBroeserNavigationView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60)];
    self.navigationView.delegate = self;
    self.navigationView.navigationTitle = [NSString stringWithFormat:@"1/%lu", self.list.count];
    self.navigationView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.3];
    [self.view addSubview:self.navigationView];
}



#pragma mark - PhotoBroeserNavigationViewDelegate

- (void)clickCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
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

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //停止滑动
    //计算第几页
    self.pageControl.currentPage = scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
    self.navigationView.navigationTitle = [NSString stringWithFormat:@"%ld/%lu", self.pageControl.currentPage + 1, self.list.count];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //停止滑动动画
    //计算第几页
    self.pageControl.currentPage = scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
    self.navigationView.navigationTitle = [NSString stringWithFormat:@"%ld/%lu", self.pageControl.currentPage + 1, self.list.count];
}


#pragma mark - 内存警告

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


@end






