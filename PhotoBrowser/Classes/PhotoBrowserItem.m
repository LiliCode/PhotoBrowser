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
    self.imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
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
}


#pragma mark - UISrcollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}


@end





