//
//  SignUpandLogin.h
//  FreshMix 2.0
//
//  Created by Robert Crosby on 9/3/14.
//  Copyright (c) 2014 8-Bit Pyramid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+StackBlur.h"
#import "Tools.h"
#import "ViewController.h"

@interface SignUpandLogin : UIViewController <UITextFieldDelegate> {

}
@property (strong, nonatomic) IBOutlet UIImageView *bg;
@property (strong, nonatomic) IBOutlet UITextField *emailfield;
@property (strong, nonatomic) IBOutlet UITextField *passwordfield;
- (IBAction)signup:(id)sender;
- (IBAction)login:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *signup;
@property (strong, nonatomic) IBOutlet UIButton *login;
@property (strong, nonatomic) IBOutlet UILabel *welcome;
@property (strong, nonatomic) IBOutlet UILabel *infotext;


@end
