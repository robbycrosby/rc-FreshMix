//
//  Tools.h
//  FreshMix 2.0
//
//  Created by Robert Crosby on 8/30/14.
//  Copyright (c) 2014 8-Bit Pyramid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "UIImage+StackBlur.h"
#import "AFSoundManager.h"
#import <AVFoundation/AVPlayer.h>
#import <Twitter/Twitter.h>
#import "SDWebImage/UIButton+WebCache.h"

@interface Tools : NSObject {
    BOOL done;

}
@property(nonatomic,strong) NSMutableArray *songs;
+(void)tapecount;
+(void)roundbuttons:(UIButton*)button;
+(void)gettapes:(int)skip :(UILabel*)name :(UIButton*)art :(UILabel*)artist;
+(void)newreleases:(int)skip :(UILabel*)name :(UIButton*)art :(UILabel*)artist;
+ (void)getrandomsearch:(int)skip :(UIButton*)search;
+(void)parallax:(UIView*)view;
+(void)index;
+(NSArray*)loadplaylists;
+(void)playRemoteFile:(NSString*)songname;
+(void)pauseAudio;
+(void)resumeAudio;
+ (UIImage *)loadImage:(NSString *)name;
+ (void)saveImage:(UIImage *)image withName:(NSString *)name;
+ (void)twitter:(NSString*)twitter;
+ (void)facebook:(NSString*)twitter;
+(void)soundcloud:(NSString*)soundcloud;
+(void)getfeatured:(UIButton*)artwork :(UILabel*)artist :(int)skip;
+(void)preparenewest:(UIButton*)artwork :(UILabel*)artist :(UILabel*)mixtape :(NSInteger)slot;
+(void)preparerandom:(UIButton*)artwork :(UILabel*)artist :(UILabel*)mixtape :(NSInteger)slot;
+(void)homescreen;
+(void)tweet:(NSString*)artist;
@end
