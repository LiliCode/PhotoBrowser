//
//  PhotoBroeserNavigationView.m
//  PhotoBrowser
//
//  Created by LiliEhuu on 17/4/21.
//  Copyright © 2017年 LiliEhuu. All rights reserved.
//

#import "PhotoBroeserNavigationView.h"

@interface PhotoBroeserNavigationView ()
@property (strong , nonatomic) UIButton *cancelButton;
@property (strong , nonatomic) UILabel *titleLabel;

@end

@implementation PhotoBroeserNavigationView

- (instancetype)init
{
    if (self = [super init])
    {
        [self addSubview:self.cancelButton];
        [self addSubview:self.titleLabel];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addSubview:self.cancelButton];
        [self addSubview:self.titleLabel];
    }
    
    return self;
}

- (void)setNavigationTitle:(NSString *)navigationTitle
{
    _navigationTitle = navigationTitle;
    
    self.titleLabel.text = navigationTitle;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, self.bounds.size.width - 100, self.bounds.size.height)];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:20];
    }
    
    return _titleLabel;
}

- (UIButton *)cancelButton
{
    if (!_cancelButton)
    {
        _cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, self.bounds.size.height)];
        [_cancelButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
        [_cancelButton setImageEdgeInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
        [_cancelButton setImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    
    return _cancelButton;
}

- (void)cancel:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(clickCancel)])
    {
        [self.delegate clickCancel];
    }
}


@end




