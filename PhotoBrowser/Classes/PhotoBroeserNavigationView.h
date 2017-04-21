//
//  PhotoBroeserNavigationView.h
//  PhotoBrowser
//
//  Created by LiliEhuu on 17/4/21.
//  Copyright © 2017年 LiliEhuu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PhotoBroeserNavigationViewDelegate <NSObject>

- (void)clickCancel;

@end

@interface PhotoBroeserNavigationView : UIView

@property (copy , nonatomic) NSString *navigationTitle; //标题
@property (weak , nonatomic) id<PhotoBroeserNavigationViewDelegate> delegate;



@end
