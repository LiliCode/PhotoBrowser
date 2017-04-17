//
//  PhotoBrowserItem.m
//  PhotoBrowser
//
//  Created by LiliEhuu on 17/4/17.
//  Copyright © 2017年 LiliEhuu. All rights reserved.
//

#import "PhotoBrowserItem.h"

@interface PhotoBrowserItem ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong , nonatomic) UIImageView *imageView;

@end

@implementation PhotoBrowserItem


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    //添加图片视图到滚动视图，以此实现缩放
    [self.scrollView addSubview:self.imageView];
    self.imageView.center = [self screenCenter];
    self.scrollView.delegate = self;
    self.scrollView.contentSize = self.imageView.bounds.size;
    self.scrollView.maximumZoomScale = 2;
    self.scrollView.minimumZoomScale = 1;
}

- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    return _imageView;
}

- (void)setData:(id)data
{
    self.imageView.image = data;
    
    [self.scrollView setZoomScale:1];
    [self setImageViewFrame:data];
}


- (void)setImageViewFrame:(UIImage *)img
{
    //屏幕大小
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    //图片宽高比例
    CGFloat imgScale = img.size.width / img.size.height;
    //需要计算的图片容器大小
    CGSize imageViewSize = CGSizeZero;
    if (imgScale > 1)   //宽 > 高
    {
        imageViewSize = CGSizeMake(screenSize.width, screenSize.width / imgScale);
    }
    else if (imgScale < 1) //宽 < 高
    {
        imageViewSize = CGSizeMake(screenSize.height / imgScale, screenSize.height);
    }
    else
    {
        //宽 == 高
        imageViewSize = CGSizeMake(screenSize.width, screenSize.width);
    }
    
    //设置
    self.imageView.bounds = CGRectMake(0, 0, imageViewSize.width, imageViewSize.height);
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





