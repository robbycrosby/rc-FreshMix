//
//  Tools.m
//  FreshMix 2.0
//
//  Created by Robert Crosby on 8/30/14.
//  Copyright (c) 2014 8-Bit Pyramid. All rights reserved.
//

#import "Tools.h"

@implementation Tools
@synthesize songs;

+ (void)roundbuttons:(UIButton*)button{
    button.layer.cornerRadius = 0;
    button.layer.masksToBounds = YES;
}
+ (void)tapecount{
    PFQuery *query = [PFQuery queryWithClassName:@"Mixtapes"];
    [query countObjectsInBackgroundWithBlock:^(int count, NSError *error) {
        if (!error) {
            // The count request succeeded. Log the count
            int x = count;
            NSLog(@"%d",x);
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
        } else {
            // The request failed
        }
    }];
    
}
+ (void)gettapes:(int)skip :(UILabel*)name :(UIButton*)art :(UILabel*)artist{
    
            // The find succeeded.
            NSArray *mixtape = [[NSUserDefaults standardUserDefaults] arrayForKey:@"mixtapes"];
            NSArray *artists = [[NSUserDefaults standardUserDefaults] arrayForKey:@"artists"];
            NSArray *artwork = [[NSUserDefaults standardUserDefaults] arrayForKey:@"artworks"];
            name.text = mixtape[skip];
    
    artist.text = artists[skip];
    [art setBackgroundImageWithURL:[NSURL URLWithString:artwork[skip]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"artwork.png"]];
            art.titleLabel.text = mixtape[skip];
            art.titleLabel.hidden = YES;
            NSInteger x = [[NSUserDefaults standardUserDefaults] integerForKey:@"doneloadingnum"];
            NSInteger y = x+1;
            [[NSUserDefaults standardUserDefaults] setInteger:y forKey:@"doneloadingnum"];
                    }


+ (void)newreleases:(int)skip :(UILabel*)name :(UIButton*)art :(UILabel*)artist{
    
    
            // The find succeeded.
    NSArray *mixtape = [[NSUserDefaults standardUserDefaults] arrayForKey:@"mixtapes"];
    NSArray *artists = [[NSUserDefaults standardUserDefaults] arrayForKey:@"artists"];
    NSArray *artwork = [[NSUserDefaults standardUserDefaults] arrayForKey:@"artworks"];
            name.text = mixtape[skip];
            art.titleLabel.text = mixtape[skip];
            art.titleLabel.hidden = YES;
            artist.text = artists[skip];
    
    [art setBackgroundImageWithURL:[NSURL URLWithString:artwork[skip]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"artwork.png"]];
    
}

+ (void)getrandomsearch:(int)skip :(UIButton*)search{
    
    PFQuery *query = [PFQuery queryWithClassName:@"Mixtapes"];
    [query setSkip:skip];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (!object) {
            if ([search.titleLabel.text isEqualToString:@"   Listen to an Artist"]) {
                [search setTitle:@"   Listen to a Mixtape" forState:UIControlStateNormal];
            } else {
                [search setTitle:@"   Listen to an Artist" forState:UIControlStateNormal];
            }
        } else {
            
            NSString *mixtape = object[@"Artist"];
            [search setTitle:[NSString stringWithFormat:@"   Listen to %@",mixtape] forState:UIControlStateNormal];
            
        }
    }];
}

+ (void) parallax:(UIView *)view{
    UIInterpolatingMotionEffect *verticalMotionEffect =
    [[UIInterpolatingMotionEffect alloc]
     initWithKeyPath:@"center.y"
     type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    verticalMotionEffect.minimumRelativeValue = @(-50);
    verticalMotionEffect.maximumRelativeValue = @(50);
    
    // Set horizontal effect
    UIInterpolatingMotionEffect *horizontalMotionEffect =
    [[UIInterpolatingMotionEffect alloc]
     initWithKeyPath:@"center.x"
     type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    horizontalMotionEffect.minimumRelativeValue = @(-50);
    horizontalMotionEffect.maximumRelativeValue = @(50);
    
    // Create group to combine both
    UIMotionEffectGroup *group = [UIMotionEffectGroup new];
    group.motionEffects = @[horizontalMotionEffect, verticalMotionEffect];
    
    // Add both effects to your view
    [view addMotionEffect:group];

    
}

+(void)index{
    
    
    
    NSMutableArray *mixtapes=[[NSMutableArray alloc]init];
    NSMutableArray *artistarray=[[NSMutableArray alloc]init];
    NSMutableArray *artarray=[[NSMutableArray alloc]init];
    NSInteger x = [[NSUserDefaults standardUserDefaults]
     integerForKey:@"tapes"];
    for (int z; z<x; z++) {
        PFQuery *query = [PFQuery queryWithClassName:@"Mixtapes"];
        [query orderByAscending:@"Artist"];
        [query setSkip:z];
        [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            if (!object) {
                NSLog(@"Woops.");
            } else {
                // The find succeeded.
                NSString *mixname = object[@"Mixtape"];
                NSString *mixartist = object[@"Artist"];
                NSString *mixart = object[@"Art"];
                [mixtapes addObject:mixname];
                [artistarray addObject:mixartist];
                [artarray addObject:mixart];
                [[NSUserDefaults standardUserDefaults] setObject:mixtapes forKey:@"mixtapenames"];
                [[NSUserDefaults standardUserDefaults] setObject:artistarray forKey:@"mixtapeartist"];
                [[NSUserDefaults standardUserDefaults] setObject:artarray forKey:@"artowrk"];
            }
        }];
        
    }
}

+(NSArray*)loadplaylists{
    PFUser *user = [PFUser currentUser];
    NSString *current = user.username;
    __block NSArray *playlists;
    PFQuery *query = [PFQuery queryWithClassName:@"UserData"];
    [query whereKey:@"user" equalTo:current];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (!object) {
            NSLog(@"The getFirstObject request failed.");
        } else {
            // The find succeeded.
            playlists = object[@"playlists"];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:playlists forKey:@"playlists"];
            [userDefaults synchronize];
            NSLog(@"Successfully retrieved the object.");
        }
    }];
    return playlists;
    
}

+(void)addplaylist:(NSString *)playlistname{
    NSString *objectid = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"mixtapenames"];
    PFQuery *query = [PFQuery queryWithClassName:@"UserData"];
    
    // Retrieve the object by id
    [query getObjectInBackgroundWithId:objectid block:^(PFObject *gameScore, NSError *error) {
        
        // Now let's update it with some new data. In this case, only cheatMode and score
        // will get sent to the cloud. playerName hasn't changed.
        [gameScore[@"playlists"] addObject:playlistname];
        [gameScore saveInBackground];
        
    }];
    


}

+(void)playRemoteFile:(NSString*)songname{
    NSString *newString = [songname stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    [[AFSoundManager sharedManager]startStreamingRemoteAudioFromURL:[NSString stringWithFormat:@"https://s3-us-west-1.amazonaws.com/freshmix/%@.mp3",newString] andBlock:^(int percentage, CGFloat elapsedTime, CGFloat timeRemaining, NSError *error, BOOL finished) {
        
        if (!error) {
            
            [[NSUserDefaults standardUserDefaults] setInteger:percentage forKey:@"elapsed"];
            NSLog(@"%i percent played",percentage);
            
        } else {
            
            NSLog(@"There has been an error playing the remote file: %@", [error description]);
        }
        
    }];
}


+(void)pauseAudio {
    [[AFSoundManager sharedManager]pause];
}

+(void)resumeAudio {
    [[AFSoundManager sharedManager]resume];
}


+ (void)saveImage:(UIImage *)image withName:(NSString *)name {
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *fullPath = [NSTemporaryDirectory() stringByAppendingPathComponent:name];
    [fileManager createFileAtPath:fullPath contents:data attributes:nil];
}

+ (UIImage *)loadImage:(NSString *)name {
    NSString *fullPath = [NSTemporaryDirectory() stringByAppendingPathComponent:name];
    UIImage *img = [UIImage imageWithContentsOfFile:fullPath];
    
    return img;
}

+ (void)twitter:(NSString*)twitter{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://twitter.com/%@",twitter]]];
}

+ (void)facebook:(NSString*)twitter{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:twitter]];
}

+(void)soundcloud:(NSString*)soundcloud{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://soundcloud.com/%@",soundcloud]]];
    
}

+(void)getfeatured:(UIButton*)artwork :(UILabel*)artist :(int)skip{
    NSArray *featured = [[NSUserDefaults standardUserDefaults] arrayForKey:@"featured"];
    NSInteger x = [(NSNumber *)[featured objectAtIndex:skip] intValue];
    NSArray *mixtapes,*artists,*artworks;
    mixtapes = [[NSUserDefaults standardUserDefaults] arrayForKey:@"mixtapes"];
    artists = [[NSUserDefaults standardUserDefaults] arrayForKey:@"artists"];
    artworks = [[NSUserDefaults standardUserDefaults] arrayForKey:@"artworks"];
    // The find succeeded.
            
    NSString *mixartist = artists[x];
    NSString *mixtape = mixtapes[x];
            artist.text = mixartist;
            [artwork setTitle:mixtape forState:UIControlStateNormal];
    NSString *mixart = artworks[x];
     [artwork setBackgroundImageWithURL:[NSURL URLWithString:mixart] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"artwork.png"]];
            NSInteger z = [[NSUserDefaults standardUserDefaults] integerForKey:@"doneloadingnum"];
            NSInteger y = z+1;
            [[NSUserDefaults standardUserDefaults] setInteger:y forKey:@"doneloadingnum"];
    

}



@end

