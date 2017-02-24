//
//  ViewController.m
//  LeftView
//
//  Created by kevin on 16/4/18.
//  Copyright © 2016年 kevin. All rights reserved.
//

#import "ViewController.h"
#import "SlideView.h"
#import "SecondViewController.h"
#import "UIView+Ext.h"
@interface ViewController ()<UINavigationControllerDelegate>

@property (strong,nonatomic)SlideView *leftView;

@end

@implementation ViewController
#define leftWidth (280)
- (void)leftViewSet
{
    _leftView = [[SlideView alloc]initWithFrame:CGRectMake(-leftWidth-5, 0, leftWidth, ScreenHeight) superView:self.view];
    _leftView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_leftView];
    [_leftView handle:^(NSInteger indexRow) {
        NSLog(@"%d",(int)indexRow);
//        [_leftView leftViewShow:NO];
        SecondViewController *second = [[SecondViewController alloc]init];
        [self.navigationController pushViewController:second animated:YES];
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
//    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"left" style:UIBarButtonItemStylePlain target:self action:@selector(clickBtn:)];
//    self.navigationItem.leftBarButtonItem = left;
    
    [self leftViewSet];
    self.navigationController.delegate = self;
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, self.view.sizeHeight)];
    view1.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:view1];
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(50, 0, 120 - 50, self.view.sizeHeight)];
    view2.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:view2];

    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(120, 0, 250 - 120, self.view.sizeHeight)];
    view3.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view3];

    UIView *view4 = [[UIView alloc]initWithFrame:CGRectMake(250, 0, 280 - 250, self.view.sizeHeight)];
    view4.backgroundColor = [UIColor grayColor];
    [self.view addSubview:view4];


    // Do any additional setup after loading the view, typically from a nib.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];

}
#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    BOOL isHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isHomePage animated:YES];
}

- (IBAction)clickBtn:(id)sender {
    [_leftView leftViewShow:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
