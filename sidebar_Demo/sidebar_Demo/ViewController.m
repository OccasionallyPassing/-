//
//  ViewController.m
//  sidebar_Demo
//
//  Created by inpcool-xiao on 14-9-5.
//  Copyright (c) 2014年 inpcool-xiao. All rights reserved.
//

#import "ViewController.h"
#import "RightViewController.h"

@interface ViewController ()<SidebarControllerDelegate>

@end

@implementation ViewController
            
- (void)viewDidLoad {
    self.delegate = self;
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(id)addContainer:(ContainType)type
{
    switch (type)
    {
        case SIDEBAR_CONTROLLER:
            return [self.storyboard instantiateViewControllerWithIdentifier:@"sidebar"];
            
        case RIGHT_CONTROLLER:
        {
            RightViewController *sright = [self.storyboard instantiateViewControllerWithIdentifier:@"right"];
            sright.sidebarController = self;
            return sright;
        }

        default:
            break;
    }
    return nil;
}

@end
