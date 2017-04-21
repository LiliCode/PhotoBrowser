//
//  PhotoBrowserController.h
//  PhotoBrowser
//
//  Created by LiliEhuu on 17/4/17.
//  Copyright © 2017年 LiliEhuu. All rights reserved.
//
//  图片浏览器
//  依赖 SDWebImage第三方框架
//

#import <UIKit/UIKit.h>

@interface PhotoBrowserController : UIViewController

@property (assign , nonatomic) NSUInteger currentPageIndex; //当前页的索引 0...x 从0开始计数


/**
 创建一个图片浏览器

 @return 返回instance
 */
+ (instancetype)browser;

/**
 设置图片列表

 @param photos 图片列表：url，UIImage *
 */
- (void)setPhotos:(NSArray *)photos;



@end
