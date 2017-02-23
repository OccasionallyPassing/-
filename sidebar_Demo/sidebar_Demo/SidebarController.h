//
//  SidebarController.h
//  sidebar
//
//  Created by inpcool-xiao on 14-9-4.
//  Copyright (c) 2014年 inpcool-xiao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    SIDEBAR_CONTROLLER,
    RIGHT_CONTROLLER
}ContainType;

@protocol SidebarControllerDelegate<NSObject>

@required
-(id)addContainer:(ContainType)type;

@optional
-(CGFloat)MaxStartRangeX;
-(CGFloat)MaxOffset;
-(CGFloat)SwiptSpeedX;

@end


@interface SidebarController : UIViewController
{
    UIViewController *sidebar;
    UIViewController *right;
}

@property (nonatomic,weak) id<SidebarControllerDelegate> delegate;

-(CGFloat)getMaxStartPoint;
-(CGFloat)getMaxOffset;
-(CGFloat)getSwiptSpeedX;

//-(void)setMaxStartRangeX:(CGFloat)point;
//-(void)setMaxOffset:(CGFloat)offsset;
//-(void)setSwiptSpeedX:(CGFloat)speed;

-(void)showSideBar;
-(void)hideSideBar;
-(BOOL)flipStatus; // 反转显示与隐藏，反回当前状态

@end

