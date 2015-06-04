//
//  SignInViewController.h
//  Young California
//
//  Created by Robert Crosby on 9/23/14.
//  Copyright (c) 2014 8-Bit Pyramid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "Tools.h"
#import "UIImage+animatedGIF.h"
#import "MBProgressHUD.h"
#import "Reachability.h"

@interface SignInViewController : UIViewController <UIAlertViewDelegate>{
    NSString *current,*passcode;
    NSMutableArray *mixtapes,*artworks,*artists,*songs;
    NSMutableArray *amixtapes,*aartworks,*aartists;
    Reachability *internetReachableFoo;
    bool done;
    bool final;
}
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;
- (IBAction)signup:(id)sender;
- (IBAction)login:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *brand;
@property (strong, nonatomic) IBOutlet UILabel *info;
@property (strong, nonatomic) IBOutlet UIButton *signup;
@property (strong, nonatomic) IBOutlet UIButton *login;
@property (strong, nonatomic) IBOutlet UILabel *preparing;
@property (weak, nonatomic) IBOutlet UIImageView *prepgif;

@end
