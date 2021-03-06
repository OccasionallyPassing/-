//
//  UIMarginViewController.h
//  side
//
//  Created by carbonzhao on 16/9/29. 技术合作qq:2178785450
//  Copyright © 2016年 appleDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>

/**左右控制器继承此类*/
@interface UIMarginBarViewController : UIViewController
{
    
}

/**push新的控制器,务必调用此方法*/
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
@end

@interface UIMarginViewController : UIViewController 
/**初始化方法*/
- (instancetype)initWithRootViewController:(UINavigationController *)rootViewController;

/**是否显示边界阴影*/
@property (nonatomic,assign) BOOL shouldShowMarginShadow;
/**边界阴影颜色,默认为[UIColor darkGrayColor]*/
@property (nonatomic,retain) UIColor *shadowColor;

/**是否显示浮层阴影及透明值(0-1)来增强对比*/
@property (nonatomic,assign) BOOL shouldShowViewShadow;
@property (nonatomic,assign) CGFloat viewShadowAlpha;

/**配置左右navitem*/
- (void)setLeftBarButtonImage:(UIImage *)image;
- (void)setRightBarButtonImage:(UIImage *)image;

/**是否在退回到左右根视图的时候仍然显示侧滑视图,默认为YES*/
@property (nonatomic,assign) BOOL shouldAlwaysShowMarginBarView;


/**左视图展示宽度及左视图,视图控制器必须继承于UIMarginBarViewController,如果此控制器是以UINavigationController传入的,请正确设备UINavigationController背景图片,参考UINavigationController类方法[UIBarMetricsDefault竖屏  UIBarMetricsCompact横屏]
 - (UIImage *)backgroundImageForBarMetrics:(UIBarMetrics)barMetrics
 */
@property (nonatomic,assign) CGFloat leftViewWidth;
- (void)setLeftViewController:(UIViewController *)leftController;

/**右视图展示宽度及右视图,视图控制器必须继承于UIMarginBarViewController如果此控制器是以UINavigationController传入的,请正确设备UINavigationController背景图片,参考UINavigationController类方法[UIBarMetricsDefault竖屏  UIBarMetricsCompact横屏]
 - (UIImage *)backgroundImageForBarMetrics:(UIBarMetrics)barMetrics
 */
@property (nonatomic,assign) CGFloat rightViewWidth;
- (void)setRightViewController:(UIViewController *)rightController;
@end
