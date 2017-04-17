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
    for (NSUInteger count = 1; count <= 5; count++)
    {
        NSString *photoName = [NSString stringWithFormat:@"image%lu.jpeg", count];
        UIImage *image = [UIImage imageNamed:photoName];
        [photos addObject:image];
    }
    
    PhotoBrowserController *browserController = [PhotoBrowserController browser];
    [browserController setPhotos:[photos copy]];
    [self presentViewController:browserController animated:YES completion:nil];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


@end
