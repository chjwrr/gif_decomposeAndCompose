//
//  ViewController.m
//  iOS-gif
//
//  Created by chj on 2017/3/21.
//  Copyright © 2017年 chj. All rights reserved.
//

#import "ViewController.h"

#import "ComposeViewController.h"
#import "DecomposeViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    self.title = @"GIF分解与合成";
    
    
    
    UIButton *button1=[[UIButton alloc]initWithFrame:CGRectMake(20, 100, 100, 100)];
    [self.view addSubview:button1];
    [button1 setBackgroundColor:[UIColor redColor]];
    [button1 setTitle:@"gif分解" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(decomposeAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *button2=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-120, 100, 100, 100)];
    [self.view addSubview:button2];
    [button2 setBackgroundColor:[UIColor redColor]];
    [button2 setTitle:@"gif合成" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(composeAction) forControlEvents:UIControlEventTouchUpInside];
}


/**
 gif分解
 */
- (void)decomposeAction {
    DecomposeViewController *vc = [[DecomposeViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


/**
 gif合成
 */
- (void)composeAction {
    ComposeViewController *vc = [[ComposeViewController alloc]init];

    [self.navigationController pushViewController:vc animated:YES];

}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
