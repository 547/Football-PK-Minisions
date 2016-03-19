//
//  gameViewController.m
//  A11_29_a
//
//  Created by mac on 15-11-29.
//  Copyright (c) 2015年 zhiyou. All rights reserved.
//

#import "gameViewController.h"
#import "W47AppDelegate.h"
#import "starViewController.h"
@interface gameViewController ()

@end

@implementation gameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    score=0;
    
    UIImageView *iv_back=[[UIImageView alloc]initWithFrame:self.view.frame];
    iv_back.image=[UIImage imageNamed:@"bg.png"];
    [self.view addSubview:iv_back];
    
    lb_score=[[UILabel alloc]initWithFrame:CGRectMake(0, 15, 100, 20)];
    lb_score.text=@"得分:";
    // lb_score.backgroundColor=[UIColor redColor];
    lb_score.textColor=[UIColor blueColor];
    lb_score.textAlignment=NSTextAlignmentCenter;
    lb_score.alpha=1;
    lb_score.layer.cornerRadius=15;
    lb_score.layer.borderWidth=0.1;
    [self.view addSubview:lb_score];

    
    [self gameStar:410];
    [self setBall];
    [self setLittleYellow:100];
    [self setLeftSpringBoard];
    [self setRightSpringBoard];
    [self setMainSpringBoard];
    
    
    
    
}
-(void)ballStar{
    ballTimer=[NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(ballMove) userInfo:nil repeats:YES];
}
-(void)setBall{
    ball=[[UIImageView alloc]initWithFrame:CGRectMake(arc4random()%290, self.view.frame.size.height-30, 30, 30)];
    ball.image=[UIImage imageNamed:@"22.png"];
    [self.view addSubview:ball];
    x=8;
    y=10;
}
-(void)setLittleYellow:(int)yellowNumber{
    yellowArray=[[NSMutableArray alloc]initWithCapacity:0];
    for (int i=0; i<yellowNumber; i++) {
        UIImageView *littleYellow=[[UIImageView alloc]initWithFrame:CGRectMake(arc4random()%290, -30, 25, 25)];
        littleYellow.tag=0;
        littleYellow.image=[UIImage imageNamed:@"11.png"];
        [yellowArray addObject:littleYellow];
        [self.view addSubview:littleYellow];
    }
}
-(void)setLeftSpringBoard{
    leftSpringBoard=[[UIImageView alloc]initWithFrame:CGRectMake(30,145, 100, 10)];
    leftSpringBoard.backgroundColor=[UIColor greenColor];
    leftSpringBoard.alpha=0.4;
    [self.view addSubview:leftSpringBoard];
}
-(void)setRightSpringBoard{
    rightSpringBoard=[[UIImageView alloc]initWithFrame:CGRectMake(190,145, 100, 10)];
    rightSpringBoard.backgroundColor=[UIColor greenColor];
    rightSpringBoard.alpha=0.4;
    [self.view addSubview:rightSpringBoard];
}
-(void)setMainSpringBoard{
    mainSpringBoard=[[UIImageView alloc]initWithFrame:CGRectMake(60,280, 200, 10)];
    mainSpringBoard.backgroundColor=[UIColor greenColor];
    mainSpringBoard.alpha=0.4;
    [self.view addSubview:mainSpringBoard];
}



-(void)starGame{
    [self setTimer:0.01 selector:@selector(littleYellowDisappear)];
    [self ballStar];
    //[self setTimer:0.03 selector:@selector(ballMove)];
    [self setTimer:2 selector:@selector(beforeLittleYellowMove)];
    [self setTimer:0.05 selector:@selector(littleYellowMove)];
    
    [starGame removeFromSuperview];
    //[overGame removeFromSuperview];
    //[stopGame removeFromSuperview];
    [self gameStop:410];
    [self gameOver:450];
    
}
-(void)stopGame{
    [ballTimer invalidate];
    [mTimer invalidate];
    //[starGame removeFromSuperview];
    //[overGame removeFromSuperview];
    [stopGame removeFromSuperview];
    //[self gameOver:450];
    [self gameStar:410];
    
}
-(void)overGame{
    starViewController *star=[[starViewController alloc]init];
    W47AppDelegate *appDelegate=[UIApplication sharedApplication].delegate;
    appDelegate.window.rootViewController=star;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:appDelegate.window cache:YES];
    [UIView commitAnimations];
}



-(void)gameStop:(CGFloat)gameStopY{
    stopGame=[UIButton buttonWithType:UIButtonTypeSystem];
    stopGame.frame=CGRectMake(0, gameStopY, 30, 30);
    stopGame.backgroundColor=[UIColor blueColor];
    stopGame.layer.cornerRadius=15;
    stopGame.alpha=0.2;
    [stopGame setTitle:@"暂停" forState:UIControlStateNormal];
    [stopGame setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [stopGame addTarget:self action:@selector(stopGame) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopGame];
}
-(void)gameStar:(CGFloat)gameStarY{
    
    starGame=[UIButton buttonWithType:UIButtonTypeSystem];
    starGame.frame=CGRectMake(0, gameStarY, 30, 30);
    starGame.layer.cornerRadius=15;
    starGame.backgroundColor=[UIColor blueColor];
    starGame.alpha=0.2;
    [starGame setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [starGame addTarget:self action:@selector(starGame) forControlEvents:UIControlEventTouchUpInside];
    [starGame setTitle:@"开始" forState:UIControlStateNormal];
    [self.view addSubview:starGame];


}
-(void)gameOver:(CGFloat)gameOverY{
    overGame=[UIButton buttonWithType:UIButtonTypeSystem];
    overGame.frame=CGRectMake(0,gameOverY, 30, 30);
    overGame.layer.cornerRadius=15;
    overGame.backgroundColor=[UIColor blueColor];
    overGame.alpha=0.2;
    [overGame setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [overGame addTarget:self action:@selector(overGame) forControlEvents:UIControlEventTouchUpInside];
    [overGame setTitle:@"结束" forState:UIControlStateNormal];
    [self.view addSubview:overGame];
}

-(void)ballMove{
    CGRect ballFrame=ball.frame;
    
    if (ballFrame.origin.x>self.view.frame.size.width-ball.frame.size.width) {
        x=-5;
    }
    if (ballFrame.origin.x<0) {
        x=8;
    }
    if (ballFrame.origin.y>self.view.frame.size.height-ball.frame.size.height) {
        y=-8;
    }
    if (ballFrame.origin.y<0) {
        y=8;
    }
    if (CGRectIntersectsRect(ballFrame, leftSpringBoard.frame)) {
        if (ballFrame.origin.y<leftSpringBoard.frame.origin.y) {
            y=-8;
        }else{
            y=8;
        }
    }
    if (CGRectIntersectsRect(ballFrame, rightSpringBoard.frame)) {
        if (ballFrame.origin.y<rightSpringBoard.frame.origin.y) {
            y=-8;
        }else{
            y=8;
        }
    }
    if (CGRectIntersectsRect(ballFrame, mainSpringBoard.frame)) {
        if (ballFrame.origin.y<mainSpringBoard.frame.origin.y) {
            y=-8;
        }else{
            y=8;
        }
    }
    ballFrame.origin.x+=x;
    ballFrame.origin.y+=y;
    ball.frame=ballFrame;
}

-(void)beforeLittleYellowMove{
    for (int i=0; i<yellowArray.count; i++) {
        UIImageView *littleYellow=[yellowArray objectAtIndex:i];
        if (littleYellow.tag==0) {
            littleYellow.tag=1;
            break;
        }
    }
}

-(void)littleYellowMove{
    for (int i=0; i<yellowArray.count; i++) {
        UIImageView *littleYellow=[yellowArray objectAtIndex:i];
        if (littleYellow.tag==1) {
            
            if (CGRectIntersectsRect(littleYellow.frame, mainSpringBoard.frame)||CGRectIntersectsRect(littleYellow.frame, leftSpringBoard.frame)||CGRectIntersectsRect(littleYellow.frame, rightSpringBoard.frame)) {
                
                if (littleYellow.center.x<rightSpringBoard.center.x||littleYellow.center.x<leftSpringBoard.center.x||littleYellow.center.x<mainSpringBoard.center.x) {
//                    NSLog(@"%f",littleYellow.center.x);
//                    NSLog(@"right%f",rightSpringBoard.center.x);
//                    NSLog(@"main%f",mainSpringBoard.center.x);
//                    NSLog(@"left%f",leftSpringBoard.center.x);
                    
                    littleYellow.frame=CGRectMake(littleYellow.frame.origin.x-1, littleYellow.frame.origin.y, littleYellow.frame.size.width, littleYellow.frame.size.height);
                    
                }
                if (littleYellow.center.x>=rightSpringBoard.center.x||littleYellow.center.x>=leftSpringBoard.center.x||littleYellow.center.x>=mainSpringBoard.center.x){
//                    NSLog(@"%f",littleYellow.center.x);
//                    NSLog(@"right%f",rightSpringBoard.center.x);
//                    NSLog(@"main%f",mainSpringBoard.center.x);
//                    NSLog(@"left%f",leftSpringBoard.center.x);

                    littleYellow.frame=CGRectMake(littleYellow.frame.origin.x+2, littleYellow.frame.origin.y, littleYellow.frame.size.width, littleYellow.frame.size.height);
                    
                }
                

            }else{
                littleYellow.frame=CGRectMake(littleYellow.frame.origin.x, littleYellow.frame.origin.y+2, littleYellow.frame.size.width, littleYellow.frame.size.height);
                
            }
            
            if (littleYellow.frame.origin.y>self.view.frame.size.height) {
                littleYellow.tag=0;
                littleYellow.frame=CGRectMake(arc4random()%290, -30, littleYellow.frame.size.width, littleYellow.frame.size.height);
            }
        }
    }
    
}



-(void)littleYellowDisappear{
    for (UIImageView *littleYellow in yellowArray) {
        if (CGRectIntersectsRect(littleYellow.frame, ball.frame)) {
            littleYellow.tag=0;
            littleYellow.frame=CGRectMake(arc4random()%295, -30, littleYellow.frame.size.width, littleYellow.frame.size.height);
            score++;
            lb_score.text=[NSString stringWithFormat:@"得分:%i",score];
        }
    }
}
//获取触摸点，使某个控件随手指移动
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    //创建touch对象====[touches anyObject]获取touch的所有属性
    UITouch *mTouch=[touches anyObject];
    //获取触摸点==locationInView在父视图上的坐标
    CGPoint mTouchPoint=[mTouch locationInView:self.view];
    //判断触摸点是否在某个矩形内===CGRectContainsPoint(矩形, 触摸点)（矩形包含点）==
    if (CGRectContainsPoint(mainSpringBoard.frame, mTouchPoint)) {
        //将触摸点赋给矩形的中心使矩形可以随触摸点移动
        mainSpringBoard.center=mTouchPoint;
    }
    if (CGRectContainsPoint(leftSpringBoard.frame, mTouchPoint)) {
        leftSpringBoard.center=mTouchPoint;
    }
    if (CGRectContainsPoint(rightSpringBoard.frame, mTouchPoint)) {
        rightSpringBoard.center=mTouchPoint;
    }
}

-(void)setTimer:(NSTimeInterval)time selector:(SEL)selector{
    mTimer=[NSTimer scheduledTimerWithTimeInterval:time target:self selector:selector userInfo:nil repeats:YES];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
