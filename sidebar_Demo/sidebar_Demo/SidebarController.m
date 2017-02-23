//
//  ViewController.m
//  sidebar
//
//  Created by inpcool-xiao on 14-9-4.
//  Copyright (c) 2014年 inpcool-xiao. All rights reserved.
//

#import "SidebarController.h"

@interface SidebarController ()

@property CGPoint startPoint;
@property (nonatomic) CGFloat maxOffset;
@property (nonatomic) CGFloat maxStartRangeX; // 开始落点最大范围值
@property (nonatomic) CGFloat currentOffsetX; // 移动时rightview的x坐标
@property (nonatomic) BOOL isRight; // 是否向右边移动
@property (nonatomic) CGFloat swiptSpeedX; // 当达到这个移动速度后就属于快速轻扫
@property (nonatomic) BOOL isShow; // 是否已弹出sidebar

@end

@implementation SidebarController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _currentOffsetX = 0.0;
    _maxOffset = 250;
    _maxStartRangeX = 40;
    _swiptSpeedX = 700;
    
    
    if ([self.delegate respondsToSelector:@selector(addContainer:)]) // 实现了代理
    {
        sidebar = [self.delegate addContainer:SIDEBAR_CONTROLLER];
        if (sidebar)
        {
            [self.view addSubview:sidebar.view];
            sidebar.view.bounds = self.view.bounds;
        }
        
        right = [self.delegate addContainer:RIGHT_CONTROLLER];
        if (right)
        {
            [self.view addSubview:right.view];
            right.view.bounds = self.view.bounds;
        }
        
        // 让right页面靠前
        [self.view bringSubviewToFront:right.view];
    }
    
    if ([self.delegate respondsToSelector:@selector(MaxStartRangeX)])
    {
        [self setMaxStartRangeX:[self.delegate MaxStartRangeX]];
    }
    
    if ([self.delegate respondsToSelector:@selector(MaxOffset)])
    {
        [self setMaxOffset:[self.delegate MaxOffset]];
    }
    
    if ([self.delegate respondsToSelector:@selector(SwiptSpeedX)])
    {
        [self setSwiptSpeedX:[self.delegate SwiptSpeedX]];
    }
    
    
    // 慢速拖动手势
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
    [panGesture setMinimumNumberOfTouches:1]; //最小触控点个数
    [panGesture setMaximumNumberOfTouches:1]; //最大触控点个数
    [self.view addGestureRecognizer:panGesture];
}


-(void)panGesture:(UIPanGestureRecognizer*)panGestureRecognizder
{
    //NSLog(@"panGesture!");
    // 记录起始位置
    if (panGestureRecognizder.state == UIGestureRecognizerStateBegan)
    {
        //获取平移手势对象在self.view的位置点
        CGPoint RecognizderPoint = [panGestureRecognizder locationInView:self.view];
        _startPoint = RecognizderPoint;
        
        // 加阴影
        CALayer *layer = [right.view layer];
        layer.shadowColor = [UIColor blackColor].CGColor;
        layer.shadowOffset = CGSizeMake(1, 1);
        layer.shadowOpacity = 1;
        layer.shadowRadius = 2.5;
        
        NSLog(@"start_Point = {%f,%f}",_startPoint.x,_startPoint.y);
    }

    

    if (panGestureRecognizder.state == UIGestureRecognizerStateChanged) // 正在拖动
    {
        CGPoint point = [panGestureRecognizder translationInView:self.view]; // 取得移动距离
        if (_startPoint.x > 0 && _startPoint.x < _maxStartRangeX) // 开始落下手指的范围合理 , 这是向右移动的范围内
        {
            if (point.x >= 0/* && point.x <= _maxOffset*/) // 在能移动的范围内而且是向右移动
            {
                NSLog(@"------------>");
                NSLog(@"right:point.x = %f",point.x);
                [right.view setFrame:CGRectMake(point.x, right.view.frame.origin.y, right.view.frame.size.width, right.view.frame.size.height)];
                _currentOffsetX = point.x; // 用于最后取消拖动时确认位置
                _isRight = YES;
            }
        }
        
        if (_startPoint.x >= _maxOffset - 10 && _startPoint.x < self.view.frame.size.width && right.view.frame.origin.x > 0) // 开始落下手指的范围合理,这是向左移动的范围内
        {
            if (point.x < 0 && ABS(point.x) <= _maxOffset) // 向左移动
            {
                NSLog(@"<------------");
                NSLog(@"right:point.x = %f",point.x);
                [right.view setFrame:CGRectMake(_maxOffset + point.x , right.view.frame.origin.y, right.view.frame.size.width, right.view.frame.size.height)];
                _currentOffsetX = _maxOffset + point.x;
                _isRight = NO;
            }
            
            if (point.x > 0) // 弹出时还可以向右移动，这是一个小效果
            {
                NSLog(@"------<------>");
                NSLog(@"right:point.x = %f",point.x);
                [right.view setFrame:CGRectMake(_maxOffset + point.x , right.view.frame.origin.y, right.view.frame.size.width, right.view.frame.size.height)];
                _currentOffsetX = _maxOffset + point.x;
                _isRight = YES;
            }
        }
    }

    
    if ((panGestureRecognizder.state == UIGestureRecognizerStateEnded) || (panGestureRecognizder.state == UIGestureRecognizerStateCancelled))
    {
        NSLog(@"velocity = %f",[panGestureRecognizder velocityInView:self.view].x);
        CGFloat speed = ABS([panGestureRecognizder velocityInView:self.view].x);
        
        if (_isRight) // 加多个判断主要是为了微调
        {
            if (_currentOffsetX >= self.view.frame.size.width / 2 - 60 || speed >= _swiptSpeedX) // 微调
            {
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
                [UIView setAnimationDuration:ABS(speed * 0.000004 + 0.2)]; // 时间与速度成反比,最小时也能保持0.2
                [right.view setFrame:CGRectMake(_maxOffset, right.view.frame.origin.y, right.view.frame.size.width, right.view.frame.size.height)];
                [UIView commitAnimations];
                _currentOffsetX = _maxOffset;
                _isShow = YES;
                NSLog(@"right->right! && speed = %f",ABS(speed * 0.000004 + 0.2));
            }
            else
            {
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
                [UIView setAnimationDuration:ABS(speed * 0.000004 + 0.2)]; // 时间与速度成反比,最小时也能保持0.2
                [right.view setFrame:CGRectMake(0, right.view.frame.origin.y, right.view.frame.size.width, right.view.frame.size.height)];
                [UIView commitAnimations];
                _currentOffsetX = 0;
                _isShow = NO;
                NSLog(@"right->left! && speed = %f",ABS(speed * 0.000004 + 0.2));
            }
        }
        else
        {
            if (_currentOffsetX <= self.view.frame.size.width / 2 - 15 || ABS(speed) >= _swiptSpeedX) // 向左时只有更大位置才会向右
            {
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
                [UIView setAnimationDuration:ABS(speed * 0.000004 + 0.2)]; // 时间与速度成反比,最小时也能保持0.2
                [right.view setFrame:CGRectMake(0, right.view.frame.origin.y, right.view.frame.size.width, right.view.frame.size.height)];
                [UIView commitAnimations];
                _currentOffsetX = 0;
                _isShow = NO;
                NSLog(@"left->left! && speed = %f",ABS(speed * 0.000004 + 0.2));
            }
            else
            {
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
                [UIView setAnimationDuration:ABS(speed * 0.000004 + 0.2)]; // 时间与速度成反比,最小时也能保持0.2
                [right.view setFrame:CGRectMake(_maxOffset, right.view.frame.origin.y, right.view.frame.size.width, right.view.frame.size.height)];
                [UIView commitAnimations];
                _currentOffsetX = _maxOffset;
                _isShow = YES;
                NSLog(@"left->right! && speed = %f",ABS(speed * 0.000004 + 0.2));
            }
        }
    }
}

-(CGFloat)getMaxStartPoint
{
    return _maxStartRangeX;
}

-(CGFloat)getMaxOffset
{
    return _maxOffset;
}

-(CGFloat)getSwiptSpeedX
{
    return _swiptSpeedX;
}

-(void)setMaxStartRangeX:(CGFloat)point
{
    _maxStartRangeX = point;
}

-(void)setMaxOffset:(CGFloat)offsset
{
    _maxOffset = offsset;
}

-(void)setSwiptSpeedX:(CGFloat)speed
{
    _swiptSpeedX = speed;
}

-(void)showSideBar
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:0.28]; 
    [right.view setFrame:CGRectMake(_maxOffset, right.view.frame.origin.y, right.view.frame.size.width, right.view.frame.size.height)];
    [UIView commitAnimations];
    _currentOffsetX = _maxOffset;
    _isShow = YES;
    
    // 加阴影
    CALayer *layer = [right.view layer];
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOffset = CGSizeMake(1, 1);
    layer.shadowOpacity = 1;
    layer.shadowRadius = 2.5;
    
    NSLog(@"showSideBar!");
}

-(void)hideSideBar
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:0.28];
    [right.view setFrame:CGRectMake(0, right.view.frame.origin.y, right.view.frame.size.width, right.view.frame.size.height)];
    [UIView commitAnimations];
    _currentOffsetX = _maxOffset;
    _isShow = NO;
    NSLog(@"hideSideBar!");
}

-(BOOL)flipStatus
{
    if (_isShow)
    {
        [self hideSideBar];
    }
    else
    {
        [self showSideBar];
    }
    return _isShow;
}

@end
