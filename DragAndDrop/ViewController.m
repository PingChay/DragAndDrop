//
//  ViewController.m
//  DragAndDrop
//
//  Created by PingChay 's MacMiNi on 9/4/14.
//  Copyright (c) 2014 Saran Nonkamjan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIView *select1;
@property (strong, nonatomic) IBOutlet UIView *select2;
@property (strong, nonatomic) IBOutlet UIView *select3;

@property (strong, nonatomic) IBOutlet UIButton *choose1;
@property (strong, nonatomic) IBOutlet UIButton *choose2;
@property (strong, nonatomic) IBOutlet UIButton *choose3;

- (IBAction)drag:(id)sender forEvent:(UIEvent *)event;
- (IBAction)touchUp:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.choose1 setTag:1];
    [self.choose2 setTag:2];
    [self.choose3 setTag:3];
}

- (IBAction)drag:(id)sender forEvent:(UIEvent *)event
{
    NSSet *all = [event allTouches];
    NSArray *allTouch = [all allObjects];
    
    UITouch *touch;
    for (UITouch *check in allTouch)
    {
        if (check.view == sender)
            touch = check;
    }
    
    CGPoint point = [touch locationInView:self.view];
    [sender setCenter:point];
}

- (IBAction)touchUp:(id)sender
{
    UIView *selectView;
    CGRect oldPosition;
    
    if (sender == self.choose1)
    {
        selectView = self.select1;
        oldPosition = CGRectMake(41, 249, 40, 40);
    }
    else if (sender == self.choose2)
    {
        selectView = self.select2;
        oldPosition = CGRectMake(41, 327, 40, 40);
    }
    else if (sender == self.choose3)
    {
        selectView = self.select3;
        oldPosition = CGRectMake(41, 410, 40, 40);
    }
    
    CGPoint point = [sender center];
    CGRect rectSelectView = [self.view convertRect:selectView.frame fromView:selectView.superview];
    
    BOOL isInView = CGRectContainsPoint(rectSelectView, point);

    if (isInView)
    {
        [sender setHidden:YES];
        [selectView setHidden:YES];
    }
    else
    {
        [UIView transitionWithView:self.view
                          duration:0.2f
                           options:UIViewAnimationOptionCurveEaseInOut
                        animations:^{
                            [sender setFrame:oldPosition];
                        }
                        completion:^(BOOL finished) {
                            
                        }];
    }
}

@end
