//
//  QRChecker.m
//  Suceava
//
//  Created by Mert Aydoğan on 06.11.2023.
//

#import "QRChecker.h"

@implementation QRChecker

- (void)startBackgroundTask {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:60.0  // 60 saniyede bir
                                                      target:self
                                                    selector:@selector(updateText3:)
                                                    userInfo:nil
                                                     repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)updateText3:(NSTimer *)timer {
    // Current Time
    NSDate *currentDate = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    NSString *formattedDate = [formatter stringFromDate:currentDate];
    NSLog(@"Güncellenen Text3: %@", formattedDate);
}

@end
