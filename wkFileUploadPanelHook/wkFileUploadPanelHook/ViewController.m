//
//  ViewController.m
//  wkFileUploadPanelHook
//
//  Created by dql on 2020/10/24.
//  Copyright © 2020 code-dogs. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import <WebKit/WebKit.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self swizzling_wKFileUploadPanel];
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = [[WKUserContentController alloc] init];
    WKPreferences *preferences = [[WKPreferences alloc] init];
    preferences.javaScriptEnabled = YES;
    configuration.preferences = preferences;
    configuration.allowsInlineMediaPlayback = YES;
    configuration.allowsAirPlayForMediaPlayback = YES;
    configuration.allowsPictureInPictureMediaPlayback = YES;
    configuration.mediaTypesRequiringUserActionForPlayback = WKAudiovisualMediaTypeAll;

    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];
//        webView.navigationDelegate = self;
    webView.scrollView.bounces = NO;
    [self.view addSubview:webView];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"dist"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
    [webView loadRequest:request];
    

    // Do any additional setup after loading the view.
}



void webFileUploadHooker(id self, SEL _cmd, UIImagePickerController *imagePicker, NSDictionary *info) {
    NSLog(@"v_imagePickerController hook:%@",info);
    CIImage *ciImage = [[CIImage alloc] initWithImage:info[UIImagePickerControllerOriginalImage]];
    CIFilter *filter = [CIFilter filterWithName:@"CIPhotoEffectTonal" keysAndValues:kCIInputImageKey, ciImage, nil];
    [filter setDefaults];
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *outputImage = [filter outputImage];
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    NSMutableDictionary *newDic = [NSMutableDictionary dictionaryWithDictionary:info];
    newDic[UIImagePickerControllerOriginalImage] = image;
    
    NSData *imgData = UIImageJPEGRepresentation(image, 1);
    NSString *path = NSTemporaryDirectory();
    path = [path stringByAppendingFormat:@"%@.jpeg", [NSUUID UUID].UUIDString];
    NSURL *urlpath = [NSURL fileURLWithPath:path];
    [imgData writeToURL:urlpath atomically:YES];
    newDic[UIImagePickerControllerImageURL] = urlpath;
    
    NSLog(@"v_imagePickerController newInfo:%@",newDic);
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wundeclared-selector"
    [self performSelector:@selector(v_imagePickerController:didFinishPickingMediaWithInfo:) withObject:imagePicker withObject:newDic];
    #pragma clang diagnostic pop
}


- (void)swizzling_wKFileUploadPanel { //如果怕被检查出使用内部类，可以稍微混淆下
    Class panelcls = NSClassFromString(@"WKFileUploadPanel");
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    class_addMethod(panelcls, @selector(v_imagePickerController:didFinishPickingMediaWithInfo:), (IMP)webFileUploadHooker, "v@:");
    Method ori_Method =  class_getInstanceMethod(panelcls, @selector(imagePickerController:didFinishPickingMediaWithInfo:));
    Method my_Method = class_getInstanceMethod(panelcls, @selector(v_imagePickerController:didFinishPickingMediaWithInfo:));
    method_exchangeImplementations(ori_Method, my_Method);
#pragma clang diagnostic pop
}



@end
