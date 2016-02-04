//
//  ViewController.m
//  Good Morning
//
//  Created by J Lane on 1/26/16.
//  Copyright © 2016 J. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *sun;
@property (weak, nonatomic) IBOutlet UIButton *sunAction;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodMorning;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation ViewController

int hour, minutes, seconds;
int secondsLeft;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self startAnimatingLabel];
}
   
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sunStop:(id)sender {
    [self.sun.layer removeAllAnimations];
    if (self.sunAction.isHidden) {
        [self startAnimatingLabel];
    }
}

- (IBAction)start:(UIButton *)sender {
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    theAnimation.duration=0.9;
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
    
    [self showTimer];
    [self hideGoodMorning];
    
    secondsLeft = 16925;
    [self countdownTimer];
}

- (void)showTimer {
    [UIView transitionWithView:self.timerLabel
                      duration:1.3
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    
    self.timerLabel.hidden = NO;
}

- (void)hideGoodMorning {
    [UIView transitionWithView:self.goodMorning
                      duration:1.3
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    
    self.goodMorning.hidden = YES;
}

- (void)startAnimatingLabel {
    self.sunAction.alpha = 0;
    
    [UIView animateWithDuration:1
                          delay:0
                        options: UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         self.sunAction.alpha = 1;
                     } completion:nil];
}

- (void)updateCounter:(NSTimer *)theTimer {
    if(secondsLeft > 0 ) {
        secondsLeft -- ;
        hour = secondsLeft / 3600;
        minutes = (secondsLeft % 3600) / 60;
        seconds = (secondsLeft %3600) % 60;
        self.timerLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d", hour, minutes, seconds];
    } else {
        secondsLeft = 16925;
    }
}

-(void)countdownTimer {
    secondsLeft = hour = minutes = seconds = 0;
}

//#pragma mark - Navigation
//
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    
//}


@end
