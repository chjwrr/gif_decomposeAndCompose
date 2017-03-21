//
//  DecomposeViewController.m
//  iOS-gif
//
//  Created by chj on 2017/3/21.
//  Copyright © 2017年 chj. All rights reserved.
//

#import "DecomposeViewController.h"



/**
 第一步，导入ImageIO
 */
#import <ImageIO/ImageIO.h>


@interface DecomposeViewController ()

@property (nonatomic,strong)NSMutableArray *paths;

@end

@implementation DecomposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"gif分解";
    self.view.backgroundColor=[UIColor yellowColor];
    
    NSString *gifpath=[[NSBundle mainBundle]pathForResource:@"gif4" ofType:@"gif"];
    
    self.paths = [self decomposeGIF:gifpath];
    
    NSLog(@"gif Paths %@",_paths);
    
}


/**
 分解gif

 @param gifPath gif路径
 @return 返回gif所有的图片地址数组
 */
- (NSMutableArray *)decomposeGIF:(NSString *)gifPath {
    
    //图片保存路径
    NSString *imagepPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    //用于保存所有图片的路径
    NSMutableArray *imgPaths=[NSMutableArray array];
    
    //1.gif转换成data
    NSData *gifData=[NSData dataWithContentsOfFile:gifPath];
    
    //2.通过data获取image的数据源
    CGImageSourceRef source =CGImageSourceCreateWithData((CFDataRef)gifData, NULL);
    
    //3.获取gif帧数
    size_t count=CGImageSourceGetCount(source);
    
    for (int i=0; i<count; i++) {
        
        //4.获取单帧图片
        CGImageRef imageRef=CGImageSourceCreateImageAtIndex(source, i, NULL);
        
        //5.根据CGImageRef获取图片
        //[UIScreen mainScreen].scale    是计算屏幕分辨率的
        //UIImageOrientationUp           指定新的图像的绘制方向
        UIImage *image=[UIImage imageWithCGImage:imageRef scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
        
        //6.释放CGImageRef对象
        CGImageRelease(imageRef);
        
        
        /************************** 保存图片 *************************/
        
        //图片转data
        NSData *imagedata = UIImagePNGRepresentation(image);
        
        //图片保存路径
        NSString *imgpath=[imagepPath stringByAppendingString:[NSString stringWithFormat:@"/%d.png",i]];
        
        //将图片写入
        [imagedata writeToFile:imgpath atomically:YES];
        
        //保存图片路径
        [imgPaths addObject:imgpath];
    }
 
    //释放source
    CFRelease(source);
    
    return imgPaths;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
