//
//  ViewController.h
//  FreshMix 2.0
//
//  Created by Robert Crosby on 8/30/14.
//  Copyright (c) 2014 8-Bit Pyramid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+StackBlur.h"
#import "Tools.h"
#import <Parse/Parse.h>
#import "MixtapeViewController.h"
#import "CollectionCell.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "UIImage+animatedGIF.h"
#import "QRCodeReaderDelegate.h"

@interface ViewController : UIViewController <QRCodeReaderDelegate,UIAlertViewDelegate,MFMailComposeViewControllerDelegate,UIActionSheetDelegate> {
    int tapes;
    IBOutlet UIScrollView *newest;
    IBOutlet UIScrollView *trending;
    UIColor *back,*primary,*secondary;
    NSString *name;
    IBOutlet UIScrollView *panels;
    NSMutableArray *playlists;
    NSInteger zero,one,two,three,four,five,six,seven,eight,nine;
    NSInteger playlistselection;
    IBOutlet UIScrollView *scroll35;
    __weak IBOutlet UIView *player;
    __weak IBOutlet UILabel *latest;
    __weak IBOutlet UILabel *rando;
    __weak IBOutlet UIScrollView *ipad_random;
    __weak IBOutlet UIScrollView *ipad_newest;
}
- (IBAction)scanAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *pregif;
@property (weak, nonatomic) IBOutlet UIImageView *preback;
@property (strong, nonatomic) IBOutlet UILabel *selection;
@property (strong, nonatomic) IBOutlet UITableView *table;

- (IBAction)collection:(id)sender;
- (IBAction)home:(id)sender;
- (IBAction)details:(id)sender;

// Artwork Buttons
@property (strong, nonatomic) IBOutlet UIButton *art1;
@property (strong, nonatomic) IBOutlet UIButton *art2;
@property (strong, nonatomic) IBOutlet UIButton *art3;
@property (strong, nonatomic) IBOutlet UIButton *art4;
@property (strong, nonatomic) IBOutlet UIButton *art5;

// Trending Artists
@property (strong, nonatomic) IBOutlet UILabel *name1;
@property (strong, nonatomic) IBOutlet UILabel *name2;
@property (strong, nonatomic) IBOutlet UILabel *name3;
@property (strong, nonatomic) IBOutlet UILabel *name4;
@property (strong, nonatomic) IBOutlet UILabel *name5;

// Latest Artists
@property (strong, nonatomic) IBOutlet UILabel *nname1;
@property (strong, nonatomic) IBOutlet UILabel *nname2;
@property (strong, nonatomic) IBOutlet UILabel *nname3;
@property (strong, nonatomic) IBOutlet UILabel *nname4;
@property (strong, nonatomic) IBOutlet UILabel *nname5;

// Newest Buttons
@property (strong, nonatomic) IBOutlet UIButton *nart1;
@property (strong, nonatomic) IBOutlet UIButton *nart2;
@property (strong, nonatomic) IBOutlet UIButton *nart4;
@property (strong, nonatomic) IBOutlet UIButton *nart5;
@property (strong, nonatomic) IBOutlet UIButton *nart6;

// Titles
@property (strong, nonatomic) IBOutlet UILabel *title1;
@property (strong, nonatomic) IBOutlet UILabel *title2;
@property (strong, nonatomic) IBOutlet UILabel *title3;
@property (strong, nonatomic) IBOutlet UILabel *title4;
@property (strong, nonatomic) IBOutlet UILabel *title5;

// Newest Titles
@property (strong, nonatomic) IBOutlet UILabel *ntitle1;
@property (strong, nonatomic) IBOutlet UILabel *ntitle2;
@property (strong, nonatomic) IBOutlet UILabel *ntitle3;
@property (strong, nonatomic) IBOutlet UILabel *ntitle4;
@property (strong, nonatomic) IBOutlet UILabel *ntitle5;

// Other

@property (strong, nonatomic) IBOutlet UIImageView *uhoh;

@property (strong, nonatomic) IBOutlet UIImageView *bg;
@property (strong, nonatomic) IBOutlet UIButton *search;
- (IBAction)featured:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *featured;
@property (weak, nonatomic) IBOutlet UIButton *home;
- (IBAction)controlbar:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *collection;
@property (weak, nonatomic) IBOutlet UIButton *infobutton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *menucontrols;
@property (weak, nonatomic) IBOutlet UILabel *header;
@property (weak, nonatomic) IBOutlet UILabel *header_background;

@end
