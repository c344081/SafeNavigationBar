//
//  HomeViewController.m
//  SafeNavigationBarDemo
//
//  Created by Envy15 on 16/5/29.
//  Copyright © 2016年 c344081. All rights reserved.
//

#import "HomeViewController.h"
#import "OneViewControllerWithoutNaviBar.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNavi];
}

- (void)setupNavi {
    UIButton *mainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [mainBtn setTitle:@"Click Here" forState:UIControlStateNormal];
    [mainBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [mainBtn sizeToFit];
    [mainBtn addTarget:self action:@selector(leftButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:mainBtn];
}

- (void)leftButtonClicked {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    OneViewControllerWithoutNaviBar *vc = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([OneViewControllerWithoutNaviBar class])];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
