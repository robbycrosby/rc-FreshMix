//
//  SubmissionView.m
//  Young California
//
//  Created by Rob Crosby on 10/8/14.
//  Copyright (c) 2014 8-Bit Pyramid. All rights reserved.
//

#import "SubmissionView.h"

@interface SubmissionView ()

@end

@implementation SubmissionView

- (void)viewDidLoad {
    _scroll.contentSize = CGSizeMake(640,252);
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getenter{
    do {
        _submit.enabled = NO;
    } while ([_name.text length] < 1 && [_artist.text length] < 1 && [_link.text length] < 1 && [_email.text length] < 1 && [_twitter.text length] < 1 && [_facebook.text length] < 1 && [_soundcloud.text length] < 1);
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)error{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Make Sure All Fields Are Filled Out"
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    which = 3;
    [alertView show];
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}


-(void)success{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Are You Sure?"
                                                        message:@"Your mixtape will be entered into the Young California Archive and streamable to all Young California Users. Are You Sure?"
                                                       delegate:self
                                              cancelButtonTitle:@"Nevermind"
                                              otherButtonTitles:@"Submit",nil];

    [alertView show];
}



- (IBAction)submit:(id)sender {
    if ([_name.text length] > 1 && [_artist.text length] > 1 && [_link.text length] > 1 && [_email.text length] > 1 && [_twitter.text length] > 1 && [_facebook.text length] > 1 && [_soundcloud.text length] > 1) {
        [self success];
    } else {
        [self error];
    }
    
    
    
   
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Make Sure All Fields Are Filled Out"
                                                           delegate:self
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        which = 3;
        [alertView show];
    }
    
}
@end
