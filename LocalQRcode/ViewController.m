//
//  ViewController.m
//  LocalQRcode
//
//  Created by Cindy on 2017/11/8.
//  Copyright © 2017年 单丶依. All rights reserved.
//

#import "ViewController.h"
#import "BSQRUtil.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *defaultQRImage;
@property (weak, nonatomic) IBOutlet UIImageView *logoCenterImg;
@property (weak, nonatomic) IBOutlet UIImageView *colorfulImge;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _defaultQRImage.image = [BSQRUtil createDefaultQRCodeWithString:@"http://www.lsfbweb.com" imageWidth:_defaultQRImage.frame.size.width];
    
    _logoCenterImg.image = [BSQRUtil createLogoQRCodeWithString:@"http://www.lsfbweb.com" logoImageName:@"testImg.jpg" logoScale:0.3];


}




@end
