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
@property (weak, nonatomic) IBOutlet UIButton *repeat;
@property (weak, nonatomic) IBOutlet UILabel *message;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation ViewController

int minutes, seconds;
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

- (IBAction)sunStop:(UITapGestureRecognizer *)sender {
        if ([self.timerLabel isHidden]) {
            return;
        }
        else if ([self.timer isValid]) {
            [self.timer invalidate];
            [self.sun.layer removeAllAnimations];
        }
        else {
            [self countdownTimer];
            [self animateSun];
        }
}

- (void)updateCounter:(NSTimer *)theTimer {
        if(secondsLeft > 0 ) {
            secondsLeft -- ;
            minutes = (secondsLeft % 3600) / 60;
            seconds = (secondsLeft % 3600) % 60;
            self.timerLabel.text = [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
        } else {
            secondsLeft = 600;
        }
//    float timeRemaining = self.timer.fireDate.timeIntervalSinceNow;
//    NSUInteger totalSeconds = timeRemaining / 1000;
//    NSUInteger minutes = totalSeconds / 60;
//    NSUInteger seconds = totalSeconds % 60;
//    self.timerLabel.text = [NSString stringWithFormat:@"%02lu:%02lu", (unsigned long)minutes, (unsigned long)seconds];
}

-(void)countdownTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateCounter:) userInfo:nil repeats:YES];
   
//    if (self.timer) {
//        self.timer = nil;
//        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateCounter:) userInfo:nil repeats:YES];
//    }
}

- (IBAction)start:(UIButton *)sender {
    [self animateSun];
    [UIView transitionWithView:sender
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        sender.hidden = YES;
                    }
                    completion:NULL];
    
    [self showTimer];
    [self hideGoodMorning];
//    [self showRepeat];
    [self showMessage];
    
    secondsLeft = 600;
    [self countdownTimer];
//    NSInvocation *invocation = [[NSInvocation alloc] init];
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:600 target:self selector:@selector(countdownTimer) userInfo:nil repeats:NO];
//    [self.timer fire];
//    NSLog(@"%f", self.timer.fireDate.timeIntervalSinceNow);
}

//- (IBAction)repeatAction:(id)sender {
//    if (!self.sun.isAnimating) {
//        [self animateSun];
//    }
//    secondsLeft = 600;
//    [self countdownTimer];
//}

- (void)animateSun {
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    theAnimation.duration=0.9;
    theAnimation.repeatCount=100;
    theAnimation.autoreverses=YES;
    theAnimation.fromValue=[NSNumber numberWithFloat:0];
    theAnimation.toValue=[NSNumber numberWithFloat:M_PI/3];
    [[self.sun layer] addAnimation:theAnimation forKey:@"rotateLayer"];
}

- (void)showTimer {
    [UIView transitionWithView:self.timerLabel
                      duration:1.3
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        self.timerLabel.hidden = NO;
                    }
                    completion:NULL];
}

- (void)hideGoodMorning {
    [UIView transitionWithView:self.goodMorning
                      duration:1.3
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        self.goodMorning.hidden = YES;
                    }
                    completion:NULL];
}

//- (void)showRepeat {
//    [UIView transitionWithView:self.repeat
//                      duration:1.3
//                       options:UIViewAnimationOptionTransitionCrossDissolve
//                    animations:^{
//                        self.repeat.hidden = NO;
//                    }
//                    completion:NULL];
//}

- (void)startAnimatingLabel {
    self.sunAction.alpha = 0;
    
    [UIView animateWithDuration:1
                          delay:0
                        options: UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         self.sunAction.alpha = 1;
                     } completion:nil];
}

- (void)showMessage {
//    [UIView animateWithDuration:1.3
//                          delay:1
//                        options: UIViewAnimationOptionTransitionCrossDissolve
//                     animations:^{
//                         self.message.hidden = NO;
//                     } completion:NULL];
    
    [UIView transitionWithView:self.message
                      duration:1.3
                       options:UIViewAnimationOptionTransitionCrossDissolve | UIViewAnimationOptionAutoreverse
                    animations:^{
                        self.message.hidden = NO;
                    }
                    completion:^(BOOL animated){
                        self.message.hidden = YES;
                    }];
    
    
    
//     ^(BOOL animated){
//         [UIView transitionWithView:self.message
//                           duration:1.3
//                            options:UIViewAnimationOptionTransitionCrossDissolve
//                         animations:^{
//                             self.message.hidden = YES;
//                         } completion:NULL];
//     }];
    
    
//    [UIView animateWithDuration:1.3
//                          delay:0
//                        options:UIViewAnimationOptionTransitionCrossDissolve
//                     animations:^{self.message.hidden = NO;} completion:nil];
}

//#pragma mark - Navigation
//
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    
//}


@end
