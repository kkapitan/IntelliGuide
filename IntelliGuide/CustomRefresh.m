//
//  CustomRefresh.m
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 12.06.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import "CustomRefresh.h"
@interface CustomRefresh ()
@property NSMutableArray *letters;
@property NSInteger currentIndex;
@property NSArray *colors;
@end

@implementation CustomRefresh


-(void)awakeFromNib{
    
    self.letters = [NSMutableArray array];
    for(int i = 1; i <= 12; i++){
        UILabel *letter = (UILabel*)[self viewWithTag:i];
        [self.letters addObject:letter];
    }
    self.colors = @[[UIColor magentaColor],[UIColor cyanColor],[UIColor yellowColor],[UIColor greenColor]];
    NSLog(@"Awake from nib");
}

-(void)animate{
    self.isAnimating = YES;
    self.currentIndex = 0;
    [self animateLetter];
}

-(UIColor*)nextColor{
    return self.colors[self.currentIndex % self.colors.count];
}

-(void)animateLetter{
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        UILabel *currentLetter = (UILabel*)self.letters[self.currentIndex];
        currentLetter.transform = CGAffineTransformRotate(CGAffineTransformIdentity, 45.0);
        currentLetter.textColor = [self nextColor];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            UILabel *currentLetter = (UILabel*)self.letters[self.currentIndex];
            currentLetter.transform = CGAffineTransformIdentity;
            currentLetter.textColor = [UIColor blackColor];
        } completion:^(BOOL finished) {

            UILabel *currentLetter = (UILabel*)self.letters[self.currentIndex];
            currentLetter.transform = CGAffineTransformIdentity;
            currentLetter.textColor = [UIColor blackColor];
            
            self.currentIndex++;
            if(self.currentIndex == self.letters.count){
                [self animateLetters];
            }
            else{
                [self animateLetter];
            }
        }];
    }];
}

-(void)animateLetters{
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        for(UILabel *currentLetter in self.letters){
            currentLetter.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.5, 1.5);
        }
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            for(UILabel *currentLetter in self.letters){
                currentLetter.transform = CGAffineTransformIdentity;
            }
        } completion:^(BOOL finished) {
            self.isAnimating = NO;
            for(UILabel *currentLetter in self.letters){
                currentLetter.transform = CGAffineTransformIdentity;
            }
        }];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
