//
//  ViewController.m
//  SLExtensionTypeHeader
//
//  Created by songlin on 06/10/2017.
//  Copyright © 2017 songlin. All rights reserved.
//

#import "ViewController.h"
#import "SLCustomNavBar.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    SLCustomNavBar *navBar;
    UIImageView *bgView;
    CGRect originalFrame;
}
@end

@implementation ViewController

static const CGFloat headHeight = 160.0f;
static const CGFloat ratio = 0.8f;
#define SCREENSIZE [UIScreen mainScreen].bounds.size
#define GREENCOLOR  [UIColor colorWithRed:87/255.0 green:173/255.0 blue:104/255.0 alpha:1]

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    //背景图片
    bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.frame.size.width, ratio*self.view.frame.size.width)];
    bgView.image = [UIImage imageNamed:@"bg-mine"];
    originalFrame = bgView.frame;
    [self.view addSubview:bgView];
    
    //导航栏
    navBar = [[SLCustomNavBar alloc] init];
    navBar.title = @"可拉伸头部";
    navBar.leftImage = @"Mail";
    navBar.rightImage = @"Setting";
    //    navBar.alpha = 0.5f;  //它改变view的alpha，以及子view的alpha
    navBar.titleColor = [UIColor whiteColor];
    [self.view addSubview:navBar];
    
    //实现tableView
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0.f, 64.0f, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-64.f) style:UITableViewStylePlain];
    table.backgroundColor = [UIColor clearColor];
    table.showsVerticalScrollIndicator = NO;
    table.delegate = self;
    table.dataSource = self;
    
    //contentInset的实质就是修改的bounds
    //1、scrollView 实现滑动效果的本质，是改变bounds的。
    //    table.contentInset = UIEdgeInsetsMake(headHeight, 0.f, 0.f, 0.f);
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.frame.size.width, headHeight)];
    headView.backgroundColor = [UIColor clearColor];
    table.tableHeaderView = headView;
    
    [self.view addSubview:table];
    
}

#pragma mark - tableView delegate&&datasource method
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = @"八点钟学院";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat yOffset = scrollView.contentOffset.y;  //往上滑动，offset是增加的，往下滑动，offset是减少的
    if (yOffset < headHeight) {   //当我滑动到导航栏底部之前
        
        CGFloat colorAlpha = yOffset/headHeight;
        navBar.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:colorAlpha];
        navBar.leftImage = @"Mail";
        navBar.rightImage = @"Setting";
        navBar.titleColor = [UIColor whiteColor];
        
    } else {  //超过导航栏底部了
        
        navBar.backgroundColor = [UIColor whiteColor];
        navBar.leftImage = @"Mail-click";
        navBar.rightImage = @"Setting-click";
        navBar.titleColor = GREENCOLOR;
        
    }
    
    //往上移动效果、处理放大效果
    if (yOffset > 0) {    //往上移动
        
        bgView.frame = ({
            
            CGRect frame = originalFrame;
            frame.origin.y = originalFrame.origin.y-yOffset;
            frame;
            
        });
        
    } else {  //往下移动
        
        // 复合语句
        bgView.frame = ({
            
            CGRect frame = originalFrame;
            frame.size.height = originalFrame.size.height - yOffset;
            frame.size.width = frame.size.height/ratio;
            frame.origin.x = originalFrame.origin.x - (frame.size.width-originalFrame.size.width)/2;
            frame;
            
        });
        
    }
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
