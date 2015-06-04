//
//  MixtapeViewController.h
//  FreshMix 2.0
//
//  Created by Robert Crosby on 8/31/14.
//  Copyright (c) 2014 8-Bit Pyramid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "UIImage+StackBlur.h"
#import "MixtapeCell.h"
#import "Tools.h"
#import "ListenCell.h"
#import "Player.h"
#import <AVFoundation/AVPlayer.h>
#import <MediaPlayer/MPNowPlayingInfoCenter.h>
#import <MediaPlayer/MPMediaItem.h>
#import <AVFoundation/AVFoundation.h>
#import "MBProgressHUD.h"
#import "zoomPopup.h"
#import <Twitter/Twitter.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "LEColorPicker.h"
#import "UIImage+StackBlur.h"
#import <QuartzCore/QuartzCore.h>
#import "MarqueeLabel.h"



@interface MixtapeViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIAlertViewDelegate,MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate> {
    NSInteger current;
    NSMutableArray *nexttrack,*nexttape,*nextartwork,*nextartist;
    UIColor *back,*primary,*secondary;
    NSString *title,*artist,*artwork,*selection,*part;
    UIView *player;
    int pc,fc;
    int stats;
    NSString *twitter,*facebook,*soundcloud;
    BOOL playingisshowing;
    NSMutableArray *allplaylists;
    NSString *savetape,*saveartist,*saveartwork;
    IBOutlet UIScrollView *moreinfo;
    UIColor *main,*weak,*backcolor;
    UIImage *blur;
    __weak IBOutlet UILabel *card;
    MarqueeLabel *mixtapescroll,*artistscroll;
}
@property (weak, nonatomic) IBOutlet UILabel *menubar;
@property (weak, nonatomic) IBOutlet UILabel *top;
@property (weak, nonatomic) IBOutlet UILabel *bottom;

@property (weak, nonatomic) IBOutlet UIButton *roundbutton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrolltable;
@property (weak, nonatomic) IBOutlet UILabel *color;
@property (weak, nonatomic) IBOutlet UIImageView *blurart;

@property (weak, nonatomic) IBOutlet UIButton *popup;

@property (strong, nonatomic) IBOutlet UIView *player;
-(IBAction)close:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *table;
@property(nonatomic) BOOL load;
// Title Stuff
@property (strong, nonatomic) IBOutlet UILabel *artist;
@property (strong, nonatomic) IBOutlet UIImageView *artwork;
@property (strong, nonatomic) IBOutlet UILabel *mixtapelabel;
@property(nonatomic) NSString *mixtape;
@property(nonatomic) NSMutableArray *songs;
@property(nonatomic) NSMutableArray *artists;
@property(nonatomic) NSMutableArray *artworks;
@property(nonatomic) NSMutableArray *artworksp;
@property(nonatomic) NSMutableArray *mixtapenames;
@property(nonatomic) NSMutableArray *artistsp;
@property(nonatomic) NSString *mixtapename;
@property(nonatomic) NSInteger playlist;
- (IBAction)more:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *scroll;
@property (strong, nonatomic) IBOutlet UIButton *more;
@property (strong, nonatomic) IBOutlet UILabel *playcount;
@property (strong, nonatomic) IBOutlet UILabel *favoritecount;
@property (strong, nonatomic) IBOutlet UIButton *twitterhandle;
@property (strong, nonatomic) IBOutlet UIButton *facebookname;
@property (strong, nonatomic) IBOutlet UIButton *soundcloud;
@property (strong, nonatomic) IBOutlet UILabel *plays;
@property (strong, nonatomic) IBOutlet UILabel *favorites;
@property (strong, nonatomic) IBOutlet UILabel *aname;
- (IBAction)artisttwitter:(id)sender;
- (IBAction)artistfacebook:(id)sender;
- (IBAction)artistsoundcloud:(id)sender;
- (IBAction)shuffle:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *shuffle;
@property (weak, nonatomic) IBOutlet UIButton *favorite;
- (IBAction)favorite:(id)sender;
+(void)playRemoteFile:(NSString*)songname;
+(void)nexttrack;
- (IBAction)email:(id)sender;

- (IBAction)sharetwitter:(id)sender;

- (IBAction)sharefacebook:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *sharesms;
- (IBAction)sharesms:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *sharefacebook;
@property (weak, nonatomic) IBOutlet UIButton *sharetwitter;
@property (weak, nonatomic) IBOutlet UIButton *shareemail;
@property (weak, nonatomic) IBOutlet UILabel *sharetitle;
@property (weak, nonatomic) IBOutlet UILabel *bgheight;


// Info
@property (weak, nonatomic) IBOutlet UILabel *more_title;
@property (weak, nonatomic) IBOutlet UILabel *more_twitter;
@property (weak, nonatomic) IBOutlet UILabel *more_facebook;
@property (weak, nonatomic) IBOutlet UILabel *more_soundcloud;
@property (weak, nonatomic) IBOutlet UIButton *done;
@property (weak, nonatomic) IBOutlet UIView *playercontrols;
@property (weak, nonatomic) IBOutlet UILabel *platercontrolsbackground;


@end
