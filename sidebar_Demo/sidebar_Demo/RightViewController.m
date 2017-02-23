//
//  RightViewController.m
//  sidebar_Demo
//
//  Created by inpcool-xiao on 14-9-5.
//  Copyright (c) 2014年 inpcool-xiao. All rights reserved.
//

#import "RightViewController.h"

@implementation RightViewController

- (IBAction)showSideBar:(id)sender
{
    [self.sidebarController flipStatus];
}

@end
