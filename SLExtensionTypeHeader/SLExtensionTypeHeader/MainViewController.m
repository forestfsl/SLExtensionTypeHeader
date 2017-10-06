//
//  MainViewController.m
//  SLExtensionTypeHeader
//
//  Created by songlin on 06/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "MainViewController.h"
#import "ViewController.h"

@interface MainViewController ()
@property(nonatomic, strong)UIButton *btn;
@end

@implementation MainViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"个性化可拉伸的头部";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Setting"] style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Mail"] style:UIBarButtonItemStylePlain target:nil action:nil];
    
    [self.view addSubview:self.btn];
}

#pragma mark - event response
- (void)btnAction {
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"主页" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButton];
    
    ViewController *view = [[ViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
    
}

#pragma mark - getter method
- (UIButton *)btn {
    
    if (!_btn) {
        
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.backgroundColor = [UIColor lightGrayColor];
        _btn.frame = CGRectMake(100.f, 100.f, 100.f, 100.f);
        [_btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
        [_btn setTitle:@"点击" forState:UIControlStateNormal];
        
    }
    return _btn;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
