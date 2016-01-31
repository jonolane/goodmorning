//
//  ViewController.m
//  Good Morning
//
//  Created by J Lane on 1/26/16.
//  Copyright © 2016 J. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *goodMorning;
@property (weak, nonatomic) IBOutlet UIImageView *sun;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
   
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)start:(UIButton *)sender {
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    theAnimation.duration=0.5;
    theAnimation.repeatCount=100;
    theAnimation.autoreverses=YES;
    theAnimation.fromValue=[NSNumber numberWithFloat:0];
    theAnimation.toValue=[NSNumber numberWithFloat:M_PI/3];
    [[self.sun layer] addAnimation:theAnimation forKey:@"rotateLayer"];
    
    [UIView transitionWithView:sender
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    
    sender.hidden = YES;
}

@end
