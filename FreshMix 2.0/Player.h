//
//  Player.h
//  FreshMix 2.0
//
//  Created by Robert Crosby on 8/31/14.
//  Copyright (c) 2014 8-Bit Pyramid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tools.h"
#import "MixtapeViewController.h"
#import <MediaPlayer/MPNowPlayingInfoCenter.h>
#import <MediaPlayer/MPMediaItem.h>


@interface Player : UIViewController{
    NSString *tapename;
    bool doneloading;
    id _adBannerView;
    BOOL _adBannerViewIsVisible;
}
@property (weak, nonatomic) IBOutlet UILabel *ad_back;
@property (strong, nonatomic) IBOutlet UILabel *songname;
@property (strong, nonatomic) IBOutlet UILabel *artist;
@property (strong, nonatomic) IBOutlet UIButton *artwork;
@property (strong,nonatomic) NSString *songtext;
@property (strong,nonatomic) NSString *artisttext;
@property (strong,nonatomic) NSString *artworkurl;
@property (strong,nonatomic) NSString *tape;
- (IBAction)playpause:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *playpause;
@property (strong, nonatomic) IBOutlet UIProgressView *elapsed;
@property (strong, nonatomic) IBOutlet UIScrollView *more;
@property (strong, nonatomic) IBOutlet UIButton *moreoptions;
- (IBAction)more:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *last;
- (IBAction)last:(id)sender;
- (IBAction)shuffle:(id)sender;
- (IBAction)next:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;




@end
