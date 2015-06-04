//
//  PopUpViewController.h
//  NMPopUpView
//
//  Created by Nikos Maounis on 9/12/13.
//  Copyright (c) 2013 Nikos Maounis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "MixtapeCell.h"

@interface PopUpViewController : UIViewController <UITableViewDataSource,UITableViewDelegate> {
    UIColor *back,*primary,*secondary;
    NSString *title,*artist,*artwork;
}

-(IBAction)close:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *table;
@property(nonatomic) BOOL load;
// Title Stuff
@property (strong, nonatomic) IBOutlet UILabel *artist;
@property (strong, nonatomic) IBOutlet UIImageView *artwork;
@property (strong, nonatomic) IBOutlet UILabel *mixtapelabel;
@property(nonatomic) NSString *mixtape;
@property(nonatomic) NSMutableArray *songs;
@property(nonatomic) NSString *mixtapename;


@property (weak, nonatomic) IBOutlet UIView *popUpView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImg;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

- (void)showInView:(UIView *)aView withImage:(UIImage *)image withMessage:(NSString *)message animated:(BOOL)animated;

@end
