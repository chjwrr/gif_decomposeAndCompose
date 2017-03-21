//
//  ComposeViewController.m
//  iOS-gif
//
//  Created by chj on 2017/3/21.
//  Copyright © 2017年 chj. All rights reserved.
//

#import "ComposeViewController.h"

//第一步：导入MobileCoreServices库
#import <ImageIO/ImageIO.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface ComposeViewController ()

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"gif合成";
    
    
    NSMutableArray *imagePath=[NSMutableArray array];
    
    for (int i = 0; i<51; i++) {
        NSString *imagepath=[[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%d",i] ofType:@"png"];
        [imagePath addObject:imagepath];
    }

    [self composeGIF:imagePath];
}


/**
 合成gif

 @param imagePathArray 图片路径数组
 */
- (void)composeGIF:(NSMutableArray *)imagePathArray {
    
    //创建gif路径
    NSString *imagepPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString * gifPath = [imagepPath stringByAppendingString:@"/my.gif"];

    NSLog(@"gifPath   %@",gifPath);
    
    //图像目标
    CGImageDestinationRef destination;

    CFURLRef url=CFURLCreateWithFileSystemPath(kCFAllocatorDefault, (CFStringRef)gifPath, kCFURLPOSIXPathStyle, false);
    
    //通过一个url返回图像目标
    destination = CGImageDestinationCreateWithURL(url, kUTTypeGIF, imagePathArray.count, NULL);
    
    //设置gif的信息,播放间隔时间,基本数据,和delay时间,可以自己设置
    NSDictionary *frameProperties = [NSDictionary
                                     dictionaryWithObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:0.1], (NSString *)kCGImagePropertyGIFDelayTime, nil]
                                     forKey:(NSString *)kCGImagePropertyGIFDictionary];
    
    //设置gif信息
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:2];
    
    //颜色
    [dict setObject:[NSNumber numberWithBool:YES] forKey:(NSString*)kCGImagePropertyGIFHasGlobalColorMap];
    
    //颜色类型
    [dict setObject:(NSString *)kCGImagePropertyColorModelRGB forKey:(NSString *)kCGImagePropertyColorModel];
    
    //颜色深度
    [dict setObject:[NSNumber numberWithInt:8] forKey:(NSString*)kCGImagePropertyDepth];
    
    //是否重复
    [dict setObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCGImagePropertyGIFLoopCount];
    
    NSDictionary * gifproperty = [NSDictionary dictionaryWithObject:dict forKey:(NSString *)kCGImagePropertyGIFDictionary];
    
    //合成gif
    for (NSString * imagepath in imagePathArray)
    {
        UIImage *image=[UIImage imageWithContentsOfFile:imagepath];
        
        CGImageDestinationAddImage(destination, image.CGImage, (__bridge CFDictionaryRef)frameProperties);
    }

    CGImageDestinationSetProperties(destination, (__bridge CFDictionaryRef)gifproperty);
    CGImageDestinationFinalize(destination);
    
    CFRelease(destination);
}















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
