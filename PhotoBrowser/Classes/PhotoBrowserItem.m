//
//  PhotoBrowserItem.m
//  PhotoBrowser
//
//  Created by LiliEhuu on 17/4/17.
//  Copyright © 2017年 LiliEhuu. All rights reserved.
//

#import "PhotoBrowserItem.h"
#import <UIView+WebCache.h>
#import <UIImageView+WebCache.h>

#define MAX_SCALE (3)
#define MIN_SCALE (1)

@interface PhotoBrowserItem ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong , nonatomic) UIImageView *imageView;

@end

@implementation PhotoBrowserItem

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    //每次重用Cell时充值UIScrollView的contentSize
    self.scrollView.contentSize = CGSizeZero;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    //添加图片视图到滚动视图，以此实现缩放
    [self.scrollView addSubview:self.imageView];
    self.imageView.center = [self screenCenter];
    self.scrollView.delegate = self;
    self.scrollView.contentSize = self.imageView.bounds.size;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.maximumZoomScale = MAX_SCALE;
    self.scrollView.minimumZoomScale = MIN_SCALE;
    
    //添加双击手势
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapAction:)];
    [doubleTap setNumberOfTapsRequired:2];
    [self.scrollView addGestureRecognizer:doubleTap];
}



- (void)doubleTapAction:(UITapGestureRecognizer *)sender
{
    if (self.scrollView.zoomScale == MAX_SCALE)
    {
        [self.scrollView setZoomScale:MIN_SCALE animated:YES];
    }
    else if (self.scrollView.zoomScale == MIN_SCALE)
    {
        [self.scrollView setZoomScale:MAX_SCALE animated:YES];
    }
    else
    {
        [self.scrollView setZoomScale:MIN_SCALE animated:YES];
    }
}

- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.userInteractionEnabled = YES;
        
#if 0
        _imageView.layer.borderColor = [[UIColor redColor] CGColor];
        _imageView.layer.borderWidth = 1;
#endif
    }
    
    return _imageView;
}

- (void)setData:(id)data
{
    if ([data isKindOfClass:[NSString class]])    //链接字符串或者其他名称
    {
        [self.imageView sd_setShowActivityIndicatorView:YES];
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:data] placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (!error)
            {
                [self.scrollView setZoomScale:1];
                [self setImageViewFrame:image];
            }
        }];
    }
    else if ([data isMemberOfClass:[UIImage class]])
    {
        //直接关联
        self.imageView.image = data;
        [self.scrollView setZoomScale:1];
        [self setImageViewFrame:data];
    }
}


- (void)setImageViewFrame:(UIImage *)img
{
    //屏幕大小
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    //屏幕宽高比例
    CGFloat scScale = screenSize.width / screenSize.height;
    //图片宽高比例
    CGFloat imgScale = img.size.width / img.size.height;
    //需要计算的图片容器大小
    CGSize imageViewSize = CGSizeZero;
    if (imgScale > scScale)   //图片宽高比例 > 屏幕宽高比例
    {
        imageViewSize = CGSizeMake(screenSize.width, screenSize.width / imgScale);
    }
    else if (imgScale < scScale) //图片宽高比例 < 屏幕宽高比例
    {
        imageViewSize = CGSizeMake(screenSize.height * imgScale, screenSize.height);
    }
    else
    {
        //图片宽高比例 = 屏幕宽高比例
        imageViewSize = CGSizeMake(screenSize.width, screenSize.height);
    }
    
    //设置
    self.imageView.bounds = CGRectMake(0, 0, imageViewSize.width, imageViewSize.height);
    [self.scrollView setContentSize:self.imageView.bounds.size];
}

- (CGPoint)screenCenter
{
    //屏幕大小
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    return CGPointMake(screenSize.width / 2.0f, screenSize.height / 2.0f);
}

#pragma mark - UISrcollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat xcenter = scrollView.center.x , ycenter = scrollView.center.y;
    //目前contentsize的width是否大于原scrollview的contentsize，如果大于，设置imageview中心x点为contentsize的一半，以固定imageview在该contentsize中心。如果不大于说明图像的宽还没有超出屏幕范围，可继续让中心x点为屏幕中点，此种情况确保图像在屏幕中心。
    xcenter = scrollView.contentSize.width > scrollView.frame.size.width ? scrollView.contentSize.width/2 : xcenter;
    ycenter = scrollView.contentSize.height > scrollView.frame.size.height ? scrollView.contentSize.height/2 : ycenter;
    
    self.imageView.center = CGPointMake(xcenter, ycenter);
}


@end





