//
//  gameViewController.h
//  A11_29_a
//
//  Created by mac on 15-11-29.
//  Copyright (c) 2015年 zhiyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface gameViewController : UIViewController
{
    int x;
    int y;
    //int score;
    NSInteger score;
    UILabel *lb_score;
    UIImageView *ball;
    NSMutableArray *yellowArray;
    UIImageView *leftSpringBoard;
    UIImageView *rightSpringBoard;
    UIImageView *mainSpringBoard;
    UIButton *starGame;
    UIButton *overGame;
    NSTimer *mTimer;
    UIButton *stopGame;
    NSTimer *ballTimer;
}
@end
