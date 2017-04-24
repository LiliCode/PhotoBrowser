//
//  ViewController.m
//  PhotoBrowser
//
//  Created by LiliEhuu on 17/4/17.
//  Copyright © 2017年 LiliEhuu. All rights reserved.
//

#import "ViewController.h"
#import "PhotoBrowserController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}


- (IBAction)show:(UIButton *)sender
{
    NSMutableArray *photos = [[NSMutableArray alloc] init];
//    for (NSUInteger count = 1; count <= 6; count++)
//    {
//        NSString *photoName = [NSString stringWithFormat:@"image%lu.jpeg", count];
//        UIImage *image = [UIImage imageNamed:photoName];
//        [photos addObject:image];
//    }
    [photos addObject:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1492775839444&di=bdfbba054dc23fdbec2a81b8313c70af&imgtype=0&src=http%3A%2F%2Fimg01.taopic.com%2F141127%2F240494-14112FQ23021.jpg"];
    
    [photos addObject:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1492776066127&di=7391e372bb7b171cd40e0fcdfddf5b61&imgtype=0&src=http%3A%2F%2Fpic2.ooopic.com%2F11%2F44%2F22%2F15b1OOOPIC2a.jpg"];
    
    [photos addObject:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1492776141111&di=fcf3a0c4f475058a1d85b6c778a2bce3&imgtype=0&src=http%3A%2F%2Fpic29.huitu.com%2Fres%2F20150401%2F604562_20150401230632339347_1.jpg"];
    
    [photos addObject:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1492776297367&di=5cd891804ac0cb3a496f42aa69093edb&imgtype=0&src=http%3A%2F%2Fpic.qiantucdn.com%2F58pic%2F19%2F97%2F73%2F10658PICwik_1024.jpg"];
    
    [photos addObject:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1492776360704&di=ca8a387d2da0a1ae6e221f35aed1049c&imgtype=0&src=http%3A%2F%2Fimage.tianjimedia.com%2FuploadImages%2F2014%2F287%2F22%2F06GVJ65S8H28.jpg"];
    
    [photos addObject:[UIImage imageNamed:@"image7.JPG"]];
    [photos addObject:[UIImage imageNamed:@"image8.JPG"]];
    [photos addObject:[UIImage imageNamed:@"image9.JPG"]];
    [photos addObject:[UIImage imageNamed:@"image10.JPG"]];
    
    PhotoBrowserController *browserController = [PhotoBrowserController browser];
    [browserController setPhotos:[photos copy]];
//    browserController.currentPageIndex = 3;
    [self presentViewController:browserController animated:YES completion:nil];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


@end
