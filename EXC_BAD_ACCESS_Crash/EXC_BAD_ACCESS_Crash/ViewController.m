//
//  ViewController.m
//  EXC_BAD_ACCESS_Crash
//
//  Created by mac_25648_newMini on 2020/11/26.
//

#import "ViewController.h"
#import "TestOBJ2.h"

@interface ViewController ()<TestOBJ2Delegate>
@property(strong,nonatomic) TestOBJ2* testob2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)create:(id)sender {
    self.testob2 = [[TestOBJ2 alloc] init];
    self.testob2.delegate = self;
    
    [_testob2 start];
}


- (void)finish{
    self.testob2 = nil;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
