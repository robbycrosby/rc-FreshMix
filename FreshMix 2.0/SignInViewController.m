//
//  SignInViewController.m
//  Young California
//
//  Created by Robert Crosby on 9/23/14.
//  Copyright (c) 2014 8-Bit Pyramid. All rights reserved.
//

#import "SignInViewController.h"

@interface SignInViewController ()

@end

@implementation SignInViewController



- (void)viewDidLoad {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"launched"];
     [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"loadingcomplete"];
    internetReachableFoo = [Reachability reachabilityWithHostName:@"www.google.com"];
    
    // Internet is reachable
    internetReachableFoo.reachableBlock = ^(Reachability*reach)
    {
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hasinternet];
        });
    };
    
    // Internet is not reachable
    internetReachableFoo.unreachableBlock = ^(Reachability*reach)
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        // Configure for text only and offset down
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"Error: No Internet Connection";
        hud.margin = 10.f;
        hud.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.50];
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:1];
        
    };
    
    [internetReachableFoo startNotifier];
    
    
    [super viewDidLoad];
}

    // Do any additional setup after loading the view.


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


-(void)hasinternet{
    NSString *currentuser = [[NSUserDefaults standardUserDefaults] stringForKey:@"current"];
    
    if ([currentuser length] > 1) {
        
        [UIView animateWithDuration:1.0
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{_preparing.alpha = 1;_prepgif.alpha = 1;}
                         completion:^(BOOL finished){}
         ];
        
        [self tapecount];
        
    } else {
        [UIView animateWithDuration:1.0
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{ _password.alpha = 1; _username.alpha = 1; _brand.alpha = 1; _info.alpha = 1; _signup.alpha = 1; _login.alpha =1;}
                         completion:^(BOOL finished){}
         ];
        [_username becomeFirstResponder];
    }
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    

        [_password resignFirstResponder];
    
    
    
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)doneloading{
    [self performSegueWithIdentifier:@"signedin" sender:self.view];
}

- (IBAction)signup:(id)sender {
    [_password resignFirstResponder];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"User Agreement"
                                                    message:@"By signing up to use FreshMix, you agree to allow your playback history be tracked and used to improve the Young California service. All mixtapes found within the FreshMix Application have been submitted by the artist or requested by an individual. If you would like to see removal of any one mixtape, please contact us."
                                                   delegate:self
                                          cancelButtonTitle:@"I Don't Agree"
                                          otherButtonTitles:@"I Agree",nil];
    
    [alert show];
    
    }

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"We'll Miss You!"
                                                        message:@"Sorry you don't agree. Hopefully you'll let us know why!"
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        
        [alert show];
    }
    else
    {
        NSLog(@"User Agreed");
        current = _username.text;
        passcode = _password.text;
        NSLog(@"%@,%@",current,passcode);
        PFUser *user = [PFUser user];
        user.username = current;
        user.email = current;
        user.password = passcode;
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                [[NSUserDefaults standardUserDefaults] setObject:current forKey:@"current"];
                PFObject *gameScore = [PFObject objectWithClassName:@"UserData"];
                gameScore[@"username"] = current;
                NSLog(@"Success!");
                [gameScore save];
                [UIView animateWithDuration:1.0
                                      delay:0.0
                                    options:UIViewAnimationOptionCurveEaseIn
                                 animations:^{ _password.alpha = 0; _username.alpha = 0; _brand.alpha = 0; _info.alpha = 0; _signup.alpha = 0; _login.alpha =0; _preparing.alpha = 1;_prepgif.alpha = 1;}
                                 completion:^(BOOL finished){}
                 ];
                [self tapecount];
                
                // Hooray! Let them use the app now.
            } else {
                NSString *errorString = [error userInfo][@"error"];
                _info.text = errorString;
                // Show the errorString somewhere and let the user try again.
            }
        }];

    }
}
- (IBAction)login:(id)sender {
    [_password resignFirstResponder];
    current = _username.text;
    passcode = _password.text;
    NSLog(@"%@,%@",current,passcode);
    [PFUser logInWithUsernameInBackground:current password:passcode
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            [[NSUserDefaults standardUserDefaults]  setObject:current forKey:@"current"];
                                            
                                            [UIView animateWithDuration:1.0
                                                                  delay:0.0
                                                                options:UIViewAnimationOptionCurveEaseIn
                                                             animations:^{ _password.alpha = 0; _username.alpha = 0; _brand.alpha = 0; _info.alpha = 0; _signup.alpha = 0; _login.alpha =0; _preparing.alpha = 1;_prepgif.alpha = 1;}
                                                             completion:^(BOOL finished){}
                                             ];
                                            [self tapecount];


                                            // Do stuff after successful login.
                                        } else {
                                            NSString *errorString = [error userInfo][@"error"];
                                            _info.text = errorString;
                                            // The login failed. Check error to see why.
                                        }
                                    }];
    
   }


-(void)tapecount{
   

        mixtapes = [[NSMutableArray alloc] init];
        artists = [[NSMutableArray alloc] init];
        artworks = [[NSMutableArray alloc] init];
    amixtapes = [[NSMutableArray alloc] init];
    aartists = [[NSMutableArray alloc] init];
    aartworks = [[NSMutableArray alloc] init];
        songs = [[NSMutableArray alloc] init];

        PFQuery *query1 = [PFQuery queryWithClassName:@"Select"];
        [query1 getObjectInBackgroundWithId:@"wPEVnvwHw2" block:^(PFObject *gameScore, NSError *error) {
            // Do something with the returned PFObject in the gameScore variable.
            NSArray *x = gameScore[@"IDs"];
            [[NSUserDefaults standardUserDefaults] setObject:x forKey:@"featured"];
        }];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            PFQuery *query3 = [PFQuery queryWithClassName:@"Mixtapes"];
            [query3 orderByDescending:@"createdAt"];
            [query3 findObjectsInBackgroundWithBlock:^(NSArray *allobjects, NSError *error) {
                // iterate through the objects array, which contains PFObjects for each Student
                NSInteger count = [allobjects count];
                NSInteger x = count;
                [[NSUserDefaults standardUserDefaults] setInteger:x forKey:@"tapes"];
                
                int one,two,three,four,five;
                one = arc4random() % count -1;
                do {
                    two = arc4random() % count-1;
                } while (two == one && two == three && two == four && two == five && two == 0);
                do {
                    three = arc4random() % count-1;
                } while (three == one && three == two && three == four && three == five && three == 0);
                do {
                    four = arc4random() % count-1;
                } while (four == one && four == three && four == two && four == five && four == 0);
                do {
                    five = arc4random() % count-1;
                } while (five == one && five == two && five == three && five == four && five == 0);
                [[NSUserDefaults standardUserDefaults] setInteger:count forKey:@"total"];
                [[NSUserDefaults standardUserDefaults] setInteger:one forKey:@"1"];
                [[NSUserDefaults standardUserDefaults] setInteger:two forKey:@"2"];
                [[NSUserDefaults standardUserDefaults] setInteger:three forKey:@"3"];
                [[NSUserDefaults standardUserDefaults] setInteger:four forKey:@"4"];
                [[NSUserDefaults standardUserDefaults] setInteger:five forKey:@"5"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                PFQuery *query4 = [PFQuery queryWithClassName:@"Mixtapes"];
                [query4 orderByAscending:@"Artist"];
                [query4 findObjectsInBackgroundWithBlock:^(NSArray *allobjectsa, NSError *error) {
                    
                    for (int i = 0; i < allobjectsa.count; i++) {
                        [[NSUserDefaults standardUserDefaults] setInteger:allobjectsa.count forKey:@"mixtapecount"];
                        PFObject *object = [allobjectsa objectAtIndex:i];
                        NSString *mixtapename = [object objectForKey:@"Mixtape"];
                        NSString *mixtapecreator = [object objectForKey:@"Artist"];
                        NSString *mixtapeart = [object objectForKey:@"Art"];
                        [amixtapes addObject:mixtapename];
                        [aartists addObject:mixtapecreator];
                        [aartworks addObject:mixtapeart];
                        if (i == allobjects.count - 1) {
                            [[NSUserDefaults standardUserDefaults] setObject:amixtapes forKey:@"amixtapes"];
                            //[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"loadingcomplete"];
                            [[NSUserDefaults standardUserDefaults] setObject:aartists forKey:@"aartists"];
                            [[NSUserDefaults standardUserDefaults] setObject:aartworks forKey:@"aartworks"];
                            
                            
                            
                            
                            
                            
                        }
                    }}];
                for (int i = 0; i < allobjects.count; i++) {
                    [[NSUserDefaults standardUserDefaults] setInteger:allobjects.count forKey:@"mixtapecount"];
                    PFObject *object = [allobjects objectAtIndex:i];
                    NSString *mixtapename = [object objectForKey:@"Mixtape"];
                    NSString *mixtapecreator = [object objectForKey:@"Artist"];
                    NSString *mixtapeart = [object objectForKey:@"Art"];
                    songs = [object objectForKey:@"Songs"];
                    [[NSUserDefaults standardUserDefaults] setObject:songs forKey:mixtapename];
                    [mixtapes addObject:mixtapename];
                    [artists addObject:mixtapecreator];
                    [artworks addObject:mixtapeart];
                    if (i == allobjects.count - 1) {
                        [[NSUserDefaults standardUserDefaults] setObject:mixtapes forKey:@"mixtapes"];
                        //[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"loadingcomplete"];
                        [[NSUserDefaults standardUserDefaults] setObject:artists forKey:@"artists"];
                        [[NSUserDefaults standardUserDefaults] setObject:artworks forKey:@"artworks"];

                        
                        
                        NSLog(@"fuck");
                        done = YES;
                        [NSTimer scheduledTimerWithTimeInterval:5.0
                                                         target:self
                                                       selector:@selector(tooktoolong)
                                                       userInfo:nil
                                                        repeats:NO];
                        NSString * storyboardName = @"Main";
                        
                        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
                        
                        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"homescreen"];
                        
                        [self presentViewController:vc animated:YES completion:nil];
                        
                        
                        
                        
                        
                    }
                }}];
            
        });
  }
    
   
    
    


-(void)tooktoolong{
    done = [[NSUserDefaults standardUserDefaults] boolForKey:@"done"];
    if (done == YES) {
        nil;
    } else {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        // Configure for text only and offset down
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"It's taking a while...";
        hud.margin = 20.f;
        hud.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.50];
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:2];
        [self tapecount];
        

    }
    
}





@end
