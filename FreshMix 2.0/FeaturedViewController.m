//
//  FeaturedViewController.m
//  FreshMix 2.0
//
//  Created by Robert Crosby on 9/18/14.
//  Copyright (c) 2014 8-Bit Pyramid. All rights reserved.
//

#import "FeaturedViewController.h"

@interface FeaturedViewController ()

@end

@implementation FeaturedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    bool screen = [[NSUserDefaults standardUserDefaults] boolForKey:@"is3.5"];
    if (screen == YES) {
        [_oneart setFrame:CGRectMake(25, 19, 110, 110)];
        [_twoart setFrame:CGRectMake(173, 19, 110, 110)];
        [_threeart setFrame:CGRectMake(25, 169, 122, 122)];
        [_fourart setFrame:CGRectMake(173, 169, 122, 122)];
        [_oneartist setFrame:CGRectMake(25, 127, 110, 34)];
        [_twoartist setFrame:CGRectMake(173, 127, 110, 34)];
        [_threeartist setFrame:CGRectMake(25, 287, 110, 34)];
        [_fourartist setFrame:CGRectMake(173, 287, 110, 34)];
    }

    
    [Tools getfeatured:_oneart :_oneartist :0];
    [Tools getfeatured:_twoart :_twoartist :1];
    [Tools getfeatured:_threeart :_threeartist :2];
    [Tools getfeatured:_fourart :_fourartist :3];
    
    [_oneart addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
    [_twoart addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
    [_threeart addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
    [_fourart addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
    [self shader:_oneart];
    [self shader:_twoart];
    [self shader:_threeart];
    [self shader:_fourart];
    
    [super viewDidLoad];
    
    

    // Do any additional setup after loading the view.
}

- (void)verticalFlip:(UIButton*)button{
    button.layer.shadowColor = [UIColor blackColor].CGColor;
    button.layer.shadowOpacity = 0.75;
    button.layer.shadowRadius = 15.0;
    button.layer.shadowOffset = (CGSize){0.0,20.0};
    
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^(void) {
                         button.transform = CGAffineTransformMakeScale(1, -1);
                     }
                     completion:^(BOOL b) {
                         button.layer.shadowColor = [UIColor clearColor].CGColor;
                         button.layer.shadowOpacity = 0.0;
                         button.layer.shadowRadius = 0.0;
                         button.layer.shadowOffset = (CGSize){0.0, 0.0};
                     }];
}

-(void)shader:(UIButton*)button{
    button.maskView.layer.cornerRadius = 7.0f;
    button.layer.shadowRadius = 3.0f;
    button.layer.shadowColor = [UIColor blackColor].CGColor;
    button.layer.shadowOffset = CGSizeMake(0.0f, 3.0f);
    button.layer.shadowOpacity = 0.3f;
    button.layer.masksToBounds = NO;
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)go:(id)sender {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"Loading...";
    hud.margin = 20.f;
    hud.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.50];
    hud.yOffset = 150.f;
    hud.removeFromSuperViewOnHide = YES;
    UIButton *button = (UIButton *)sender;
    NSString *buttonTitle = button.currentTitle;
    name = buttonTitle;
    [self performSegueWithIdentifier:@"player" sender:self.view];
   [hud hide:YES afterDelay:2];
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"player"]){
        MixtapeViewController *controller = (MixtapeViewController *)segue.destinationViewController;
        controller.mixtapename = name;
        controller.playlist = -1;
    }
    
    
    
}

@end
