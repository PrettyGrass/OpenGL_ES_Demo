//
//  HomeViewController.m
//  OpenGLES_Ch2_1_Demo
//
//  Created by liaoshuhua on 2019/5/30.
//  Copyright © 2019 BHB. All rights reserved.
//

#import "HomeViewController.h"
#import "GLViewController.h"
@interface HomeViewController ()



@end

@implementation HomeViewController

- (IBAction)buttonAct:(id)sender {
    
    GLViewController *glVC = [[GLViewController alloc] init];
    [self.navigationController pushViewController:glVC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
