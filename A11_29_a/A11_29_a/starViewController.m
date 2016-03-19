//
//  starViewController.m
//  A11_29_a
//
//  Created by mac on 15-11-29.
//  Copyright (c) 2015年 zhiyou. All rights reserved.
//

#import "starViewController.h"
#import "W47AppDelegate.h"
#import "gameViewController.h"
@interface starViewController ()

@end

@implementation starViewController

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
    
    UIImageView *star=[[UIImageView alloc]initWithFrame:self.view.frame];
    star.backgroundColor=[UIColor blueColor];
    star.alpha=0.2;
    [self.view addSubview:star];
    
    UIButton *starGame=[UIButton buttonWithType:UIButtonTypeSystem];
    starGame.frame=CGRectMake(110, 280, 100, 30);
    starGame.backgroundColor=[UIColor whiteColor];
    [starGame setTitle:@"进入游戏" forState:UIControlStateNormal];
    starGame.layer.cornerRadius=10;
    [starGame addTarget:self action:@selector(starGame) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:starGame];
    
    
    
}
-(void)starGame{
    gameViewController *game=[[gameViewController alloc]init];
    W47AppDelegate *appDelegate=[UIApplication sharedApplication].delegate;
    appDelegate.window.rootViewController=game;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationTransition: UIViewAnimationTransitionFlipFromLeft forView:appDelegate.window cache:YES];
    [UIView commitAnimations];
    
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
