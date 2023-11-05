//
//  generatorQRViewController.m
//  Suceava
//
//  Created by Mert Aydoğan on 05.11.2023.
//

#import "QRChecker.h"
#import "generatorQRViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIView.h>

@interface generatorQRViewController ()
@property (weak, nonatomic) IBOutlet UIView *viewQR;
@property (weak, nonatomic) IBOutlet UIView *viewAtention;
@property (weak, nonatomic) IBOutlet UIView *TopNavbar;

@property (weak, nonatomic) IBOutlet UILabel *text1;
@property (weak, nonatomic) IBOutlet UILabel *text2;
@property (weak, nonatomic) IBOutlet UILabel *text3;
@property (weak, nonatomic) IBOutlet UILabel *text4;
@property (weak, nonatomic) IBOutlet UIImageView *qrGeneratorImage;

@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) NSDate *futureDate;
@property (strong, nonatomic) NSTimer *timer;

@property (nonatomic) int remainingDuration;

@end

@implementation generatorQRViewController

- (void)startBackgroundTask {
    self.remainingDuration = 100 * 60; // Total timp
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeElapsed) userInfo:nil repeats:YES];
}

- (void)timeElapsed {
    if (self.remainingDuration <= 0) {
        [self.timer invalidate];
        self.timer = nil;
        return;
    }
    
    self.remainingDuration--;
    
    if (self.remainingDuration <= 20 * 60) {
        [self generateNewRandomNumber];
    }
}

-(void)generateNewRandomNumber {
    NSString *randomNumber = [self generateRandomNumber];
    
}

- (void)stopBackgroundTask {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureText1];
    //[self generateQR];
    QRChecker *backgroundTask = [[QRChecker alloc] init];
    [backgroundTask startBackgroundTask];
    
    // Sol ve sağ sabit boşluk oluşturma
    NSLayoutConstraint *leadingConstraint = [NSLayoutConstraint constraintWithItem:self.viewQR
                                                                     attribute:NSLayoutAttributeLeading
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.viewAtention
                                                                     attribute:NSLayoutAttributeLeading
                                                                    multiplier:1.0
                                                                      constant:50.0]; // 50px'lik boşluk

    NSLayoutConstraint *trailingConstraint = [NSLayoutConstraint constraintWithItem:self.viewQR
                                                                      attribute:NSLayoutAttributeTrailing
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self.viewAtention
                                                                      attribute:NSLayoutAttributeTrailing
                                                                     multiplier:1.0
                                                                       constant:-50.0]; // 50px'lik boşluk

    // Eklediğiniz constraints'leri aktive edin
    [self.view addConstraint:leadingConstraint];
    [self.view addConstraint:trailingConstraint];

    
}

- (void)configureText1 {
    // Create Date
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm"]; // Date Format
    NSString *formattedDate = [dateFormatter stringFromDate:currentDate];
    self.text1.text = formattedDate;
    
    self.startDate = currentDate;
    
    // Calculate date for text2
    NSDate *futureDate = [currentDate dateByAddingTimeInterval:(100 * 60)]; // Adding 100 minute
    NSString *futureDateString = [dateFormatter stringFromDate:futureDate];
    self.text2.text = futureDateString;
    self.futureDate = futureDate;
    
    // Timer for text3
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    // RandomNum generator text4
    NSString *randomNumber = [self generateRandomNumber];
    self.text4.text = randomNumber;
}

- (void)updateTime {
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeLeft = [self.futureDate timeIntervalSinceDate:currentDate];
    
    int hours = timeLeft / 3600;
    int minutes = ((int)timeLeft % 3600) / 60;
    int seconds = ((int)timeLeft % 3600) % 60;
    
    NSString *timeLeftString = [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
    self.text3.text = timeLeftString;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
}

//MARK: Random Number Generator
- (NSString *)generateRandomNumber {
    long lowerBound = 16000000000000;
    long upperBound = 99999999999999;
    long randomNumber = lowerBound + arc4random() % (upperBound - lowerBound);
    
    return [NSString stringWithFormat:@"%ld", randomNumber];
}

/*
 //MARK: QR Generator
 - (UIImage *)generateQRCodeImageFromString:(NSString *)inputString {
     CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
     [filter setDefaults];

     NSData *data = [inputString dataUsingEncoding:NSUTF8StringEncoding];
     [filter setValue:data forKey:@"inputMessage"];

     CIImage *outputImage = [filter outputImage];
     CIContext *context = [CIContext contextWithOptions:nil];
     CGImageRef cgImage = [context createCGImage:outputImage fromRect:outputImage.extent];

     UIImage *qrCodeImage = [UIImage imageWithCGImage:cgImage];

     CGImageRelease(cgImage);

     return qrCodeImage;
 }

 - (void)generateQR {
     NSString *textForQR = @"Bilet 100 minute";

     UIImage *qrCode = [self generateQRCodeImageFromString:textForQR];
     self.qrGeneratorImage.image = qrCode;
 }
 */


@end
