//
//  SignUpandLogin.m
//  FreshMix 2.0
//
//  Created by Robert Crosby on 9/3/14.
//  Copyright (c) 2014 8-Bit Pyramid. All rights reserved.
//

#import "SignUpandLogin.h"

@interface SignUpandLogin ()

@end

@implementation SignUpandLogin

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    _signup.alpha = .0f;
    _login.alpha = .0f;
    _passwordfield.alpha = .0f;
    _emailfield.alpha = .0f;
    
}

-(void) viewDidAppear:(BOOL)animated{
    
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        [Tools tapecount];
        [Tools index];
        
        [self performSegueWithIdentifier:@"signed" sender:self.view];
    } else {
        [UIView animateWithDuration:0.3
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{ _emailfield.alpha = 1; _passwordfield.alpha = 1; _login.alpha = 1;_signup.alpha = 1;}
                         completion:^(BOOL finished){}
         ];

        NSLog(@"Sign In");
    }

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}



- (IBAction)signup:(id)sender {
    [self signup:_emailfield.text:_passwordfield.text];
}

- (IBAction)login:(id)sender {
    [self loginn:_emailfield.text :_passwordfield.text];
    }

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

-(void)signup :(NSString*)email :(NSString*)password{
    PFUser *user = [PFUser user];
    user.username = email;
    user.password = password;
    user.email = email;
    
    // other fields can be set just like with PFObject
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            [Tools tapecount];
            [Tools index];
            NSLog(@"Success!");
            NSString * storyboardName = @"Main";
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
            UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"home"];
            [self presentViewController:vc animated:YES completion:nil];
            PFObject *gameScore = [PFObject objectWithClassName:@"UserData"];
            gameScore[@"username"] = email;
            [[NSUserDefaults standardUserDefaults] setObject:gameScore.objectId forKey:@"currentid"];
            [[NSUserDefaults standardUserDefaults] setObject:email forKey:@"current"];
            [gameScore saveInBackground];
            
        } else {
            _infotext.text = @"Invalid Email";
        }
    }];

}

-(void)loginn :(NSString*)email :(NSString*)password {
    [PFUser logInWithUsernameInBackground:email password:password
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            [self performSegueWithIdentifier:@"signed" sender:self.view];
                                            [[NSUserDefaults standardUserDefaults] setObject:email forKey:@"current"];
                                            
                                        } else {
                                            _infotext.text = @"No User Found";
                                        }
                                    }];

}


@end
