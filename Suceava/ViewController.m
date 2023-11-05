//
//  ViewController.m
//  Suceava
//
//  Created by Mert Aydoğan on 05.11.2023.
//

#import "ViewController.h"
#import "generatorQRViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)nextClicked:(id)sender {
    UIStoryboard *generatorQR = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *generatorQRViewController = [generatorQR instantiateViewControllerWithIdentifier:@"generatorQRViewController"];
    
    [self presentViewController:generatorQRViewController animated:YES completion:nil];
}

@end
