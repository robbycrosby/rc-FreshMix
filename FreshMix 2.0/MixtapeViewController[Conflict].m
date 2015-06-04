
    
//
//  MixtapeViewController.m
//  FreshMix 2.0
//
//  Created by Robert Crosby on 8/31/14.
//  Copyright (c) 2014 8-Bit Pyramid. All rights reserved.
//

#import "MixtapeViewController.h"

@interface MixtapeViewController ()

@end

@implementation MixtapeViewController
@synthesize mixtapelabel,songs;
@synthesize artist = _artist;
@synthesize player = _player;
@synthesize artwork = _artwork;
@synthesize soundcloud = _soundcloud;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
            }
    return self;
}

-(IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewDidAppear:(BOOL)animated {
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
}


-(void)viewDidLoad {
    [_table setFrame:CGRectMake(0, 0,320, 391)];
    [_player setFrame:CGRectMake(0, 391,320, 60)];
    [_scroll setContentSize:CGSizeMake(640, 386)];
    [_popup addTarget:self action:@selector(popupimage) forControlEvents:UIControlEventTouchUpInside];
    mixtapelabel.alpha = 0;
    _artist.alpha = 0;
    _table.alpha = 0;
    mixtapelabel.text = _mixtapename;
    if (_playlist == -1) {
        [self findtape:_mixtapename];
        _shuffle.hidden = YES;
        [_table setEditing:NO];
    } else {
        [self findplaylist];
        _more.hidden = YES;
        
    }
    stats = 0;
    [super viewDidLoad];
    
    
    //self.view.backgroundColor = [UIColor clearColor];
    //UIToolbar *blurbar = [[UIToolbar alloc] initWithFrame:self.view.frame];
    //blurbar.barStyle = UIBarStyleDefault;
    //[self.view addSubview:blurbar];
    //[self.view sendSubviewToBack:blurbar];
    

}
- (void) remoteControlReceivedWithEvent: (UIEvent *) receivedEvent {
        
        if (receivedEvent.type == UIEventTypeRemoteControl) {
            
            switch (receivedEvent.subtype) {
                    
                case UIEventSubtypeRemoteControlPause:
                    [[AFSoundManager sharedManager]pause];
                    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isplaying"];
                    break;
                    
                case UIEventSubtypeRemoteControlPlay:
                    [[AFSoundManager sharedManager]resume];
                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isplaying"];
                    break;
                    
                case UIEventSubtypeRemoteControlPreviousTrack:
                    NSLog(@"Next Track");
                    [self lasttrack];
                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isplaying"];
                    break;
                    
                case UIEventSubtypeRemoteControlNextTrack:
                    NSLog(@"Next Track");
                    [self nexttrack];
                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isplaying"];
                    

                    break;
                    
                default:
                    break;
            }
        }
    }


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)findtape:(NSString*)find{
    
    PFQuery *query = [PFQuery queryWithClassName:@"Mixtapes"];
    [query whereKey:@"Mixtape" equalTo:find];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (!object) {
            NSLog(@"The getFirstObject request failed.");
        } else {
            // The find succeeded.
                        artist = object[@"Artist"];
            _artist.text = artist;
            _aname.text = artist;
            //artwork = object[@"Art"];
            songs = object[@"Songs"];
            NSString *twittern = object[@"twitter"];
            NSString *facebookn = object[@"facebook"];
            NSString *soundcloudn = object[@"soundcloud"];
            if ([twittern length] < 1) {
                [_twitterhandle setTitle:@"No Twitter" forState:UIControlStateNormal];
                _twitterhandle.enabled = NO;
            } else {
                [_twitterhandle setTitle:[NSString stringWithFormat:@"@%@",twittern] forState:UIControlStateNormal];
            }
            if ([facebookn length] < 1) {
                _facebookname.enabled = NO;
                [_facebookname setTitle:@"No Facebook" forState:UIControlStateNormal];
            } else {
                [_facebookname setTitle:[NSString stringWithFormat:@"%@",_artist.text] forState:UIControlStateNormal];
            }
            if ([soundcloudn length] < 1) {
                _soundcloud.enabled = NO;
                [_soundcloud setTitle:@"No Soundcloud" forState:UIControlStateNormal];
            } else {
                [_soundcloud setTitle:[NSString stringWithFormat:@"@%@",soundcloudn] forState:UIControlStateNormal];
            }
            
            
            
            twitter = twittern;
            facebook = facebookn;
            soundcloud = soundcloudn;
            artwork = object[@"Art"];
            pc = [[object objectForKey:@"playcountnumber"] intValue];

            
            _playcount.text = [NSString stringWithFormat:@"%d",pc];
            _favoritecount.text = [NSString stringWithFormat:@"%d",fc];
            _artwork.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:artwork]]];
            _artwork.hidden = NO;
            [UIView animateWithDuration:0.3
                                  delay:0.0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{ _artwork.alpha = 1; _artist.alpha = 1; _table.alpha = 1; mixtapelabel.alpha = 1;}
                             completion:^(BOOL finished){}
             ];
            
            [_table reloadData];
        }
    }];

}

- (BOOL) canBecomeFirstResponder
{
    return YES;
}

-(void)findplaylist{
    PFUser *user = [PFUser currentUser];
    NSString *current = user.username;
    PFQuery *query = [PFQuery queryWithClassName:@"UserData"];
    [query whereKey:@"username" equalTo:current];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (!object) {
            
        } else {
            // The find succeeded.
            NSArray *playlists = object[@"playlists"];
            NSString *which = [playlists objectAtIndex:_playlist];
            allplaylists = playlists;
            mixtapelabel.text = which;
            _artist.text = @"Created by You";
            songs = object[[NSString stringWithFormat:@"p%ld",(long)_playlist]];
            _artworks = object[[NSString stringWithFormat:@"p%ldart",(long)_playlist]];
            _artists = object[[NSString stringWithFormat:@"p%ldcreator",(long)_playlist]];
            _mixtapenames = object[[NSString stringWithFormat:@"p%ldtape",(long)_playlist]];
            if (songs.count < 1) {
                mixtapelabel.text = @"Add Some Songs!";
                _artwork.image = [UIImage imageNamed:@"artwork.png"];
                [UIView animateWithDuration:0.3
                                      delay:0.0
                                    options:UIViewAnimationOptionCurveEaseIn
                                 animations:^{mixtapelabel.alpha = 1; _artwork.alpha = 1;}
                                 completion:^(BOOL finished){}
                 ];

            }
            part = _artworks[0];
            _artwork.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:part]]];
            _artwork.hidden = NO;
            [UIView animateWithDuration:0.3
                                  delay:0.0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{ _artwork.alpha = 1; _artist.alpha = 1; _table.alpha = 1; mixtapelabel.alpha = 1;}
                             completion:^(BOOL finished){}
             ];
            
            [_table reloadData];
        }
    }];
    
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [songs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"MixtapeCell";
    
    MixtapeCell *cell = (MixtapeCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MixtapeCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    if (_artists.count > 0) {
        cell.favorite.hidden = YES;
    }
    
    
    cell.songname.text = [songs objectAtIndex:indexPath.row];
    [cell.favorite addTarget:self action:@selector(adding) forControlEvents:UIControlEventTouchUpInside];
    //cell.songname.textColor = primary;
    //cell.favorite.tintColor = primary;
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 57;
}

-(void)viewWillDisappear:(BOOL)animated{
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
}


-(void)lasttrack{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isplaying"];
    BOOL playlist = [[NSUserDefaults standardUserDefaults] boolForKey:@"isplaylist"];
    if (playlist == YES) {
        NSInteger x = [[NSUserDefaults standardUserDefaults] integerForKey:@"nowplaying-number"];
        NSInteger z = x - 1;
        if (z == -1) {
            nil;
        } else {
            NSArray *nextsongs,*nexttapes,*nextartists,*nextartworks;
            nextsongs = [[NSUserDefaults standardUserDefaults] objectForKey:@"nextplaying-songs"];
            nexttapes = [[NSUserDefaults standardUserDefaults] objectForKey:@"nextplaying-tapes"];
            nextartists = [[NSUserDefaults standardUserDefaults] objectForKey:@"nextplaying-artists"];
            nextartworks = [[NSUserDefaults standardUserDefaults] objectForKey:@"nextplaying-artworks"];
            [[NSUserDefaults standardUserDefaults] setObject:nextsongs[z] forKey:@"nowplaying-song"];
            [[NSUserDefaults standardUserDefaults] setObject:nextartists[z] forKey:@"nowplaying-artist"];
            [[NSUserDefaults standardUserDefaults] setObject:nexttapes[z] forKey:@"nowplaying-tape"];
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:nextartworks[z]]]];
            [Tools saveImage:image withName:@"artwork.png"];
            [[NSUserDefaults standardUserDefaults] setInteger:z forKey:@"nowplaying-number"];
            [self playRemoteFile:nextsongs[z]];
            Class playingInfoCenter = NSClassFromString(@"MPNowPlayingInfoCenter");
            if (playingInfoCenter) {
                
                
                NSMutableDictionary *songInfo = [[NSMutableDictionary alloc] init];
                
                
                MPMediaItemArtwork *albumArt = [[MPMediaItemArtwork alloc] initWithImage:image];
                
                [songInfo setObject:nextsongs[z] forKey:MPMediaItemPropertyTitle];
                [songInfo setObject:nextartists[z] forKey:MPMediaItemPropertyArtist];
                [songInfo setObject:nexttapes[z] forKey:MPMediaItemPropertyAlbumTitle];
                [songInfo setObject:albumArt forKey:MPMediaItemPropertyArtwork];
                [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:songInfo];
                
            }
        }
        
        
    } else {
        NSInteger x = [[NSUserDefaults standardUserDefaults] integerForKey:@"nowplaying-number"];
        NSInteger z = x - 1;
        if (z == -1) {
            nil;
        } else {
        NSArray *song = [[NSUserDefaults standardUserDefaults] objectForKey:@"nextplaying-songs"];
        NSString *artist1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"nextup-artist"];
        NSString *tape = [[NSUserDefaults standardUserDefaults] objectForKey:@"nextup-tape"];
        NSString *art = [[NSUserDefaults standardUserDefaults] objectForKey:@"nextup-art"];
        [[NSUserDefaults standardUserDefaults] setObject:song[z] forKey:@"nowplaying-song"];
        [[NSUserDefaults standardUserDefaults] setObject:artist1 forKey:@"nowplaying-artist"];
        [[NSUserDefaults standardUserDefaults] setObject:tape forKey:@"nowplaying-tape"];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:art]]];
        [Tools saveImage:image withName:@"artwork.png"];
        [[NSUserDefaults standardUserDefaults] setInteger:z forKey:@"nowplaying-number"];
        [self playRemoteFile:song[z]];
        Class playingInfoCenter = NSClassFromString(@"MPNowPlayingInfoCenter");
        if (playingInfoCenter) {
            
            
            NSMutableDictionary *songInfo = [[NSMutableDictionary alloc] init];
            
            
            MPMediaItemArtwork *albumArt = [[MPMediaItemArtwork alloc] initWithImage:image];
            
            [songInfo setObject:song[z] forKey:MPMediaItemPropertyTitle];
            [songInfo setObject:artist1 forKey:MPMediaItemPropertyArtist];
            [songInfo setObject:tape forKey:MPMediaItemPropertyAlbumTitle];
            [songInfo setObject:albumArt forKey:MPMediaItemPropertyArtwork];
            [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:songInfo];
            
        }
        }
    }
}


-(void)nexttrack{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isplaying"];
    BOOL playlist = [[NSUserDefaults standardUserDefaults] boolForKey:@"isplaylist"];
    BOOL shuffle = [[NSUserDefaults standardUserDefaults] boolForKey:@"shuffle"];
    // Playlist Playing
    if (playlist == YES) {
        if (shuffle == YES) {
            NSArray *nextsongs,*nexttapes,*nextartists,*nextartworks;
            nextsongs = [[NSUserDefaults standardUserDefaults] objectForKey:@"nextplaying-songs"];
            nexttapes = [[NSUserDefaults standardUserDefaults] objectForKey:@"nextplaying-tapes"];
            nextartists = [[NSUserDefaults standardUserDefaults] objectForKey:@"nextplaying-artists"];
            nextartworks = [[NSUserDefaults standardUserDefaults] objectForKey:@"nextplaying-artworks"];
            NSInteger x = [[NSUserDefaults standardUserDefaults] integerForKey:@"nowplaying-number"];
            NSInteger z;
            do {
                z = arc4random() % nextsongs.count;
            } while (z == x);
            
            [[NSUserDefaults standardUserDefaults] setObject:nextsongs[z] forKey:@"nowplaying-song"];
            [[NSUserDefaults standardUserDefaults] setObject:nextartists[z] forKey:@"nowplaying-artist"];
            [[NSUserDefaults standardUserDefaults] setObject:nexttapes[z] forKey:@"nowplaying-tape"];
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:nextartworks[z]]]];
            [Tools saveImage:image withName:@"artwork.png"];
            [[NSUserDefaults standardUserDefaults] setInteger:z forKey:@"nowplaying-number"];
            [self playRemoteFile:nextsongs[z]];
            Class playingInfoCenter = NSClassFromString(@"MPNowPlayingInfoCenter");
            if (playingInfoCenter) {
                
                
                NSMutableDictionary *songInfo = [[NSMutableDictionary alloc] init];
                
                
                MPMediaItemArtwork *albumArt = [[MPMediaItemArtwork alloc] initWithImage:image];
                
                [songInfo setObject:nextsongs[z] forKey:MPMediaItemPropertyTitle];
                [songInfo setObject:nextartists[z] forKey:MPMediaItemPropertyArtist];
                [songInfo setObject:nexttapes[z] forKey:MPMediaItemPropertyAlbumTitle];
                [songInfo setObject:albumArt forKey:MPMediaItemPropertyArtwork];
                [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:songInfo];
                
            }
        } else {
            NSInteger x = [[NSUserDefaults standardUserDefaults] integerForKey:@"nowplaying-number"];
            NSInteger z = x + 1;
            NSArray *nextsongs,*nexttapes,*nextartists,*nextartworks;
            nextsongs = [[NSUserDefaults standardUserDefaults] objectForKey:@"nextplaying-songs"];
            nexttapes = [[NSUserDefaults standardUserDefaults] objectForKey:@"nextplaying-tapes"];
            nextartists = [[NSUserDefaults standardUserDefaults] objectForKey:@"nextplaying-artists"];
            nextartworks = [[NSUserDefaults standardUserDefaults] objectForKey:@"nextplaying-artworks"];
            [[NSUserDefaults standardUserDefaults] setObject:nextsongs[z] forKey:@"nowplaying-song"];
            [[NSUserDefaults standardUserDefaults] setObject:nextartists[z] forKey:@"nowplaying-artist"];
            [[NSUserDefaults standardUserDefaults] setObject:nexttapes[z] forKey:@"nowplaying-tape"];
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:nextartworks[z]]]];
            [Tools saveImage:image withName:@"artwork.png"];
            [[NSUserDefaults standardUserDefaults] setInteger:z forKey:@"nowplaying-number"];
            [self playRemoteFile:nextsongs[z]];
            Class playingInfoCenter = NSClassFromString(@"MPNowPlayingInfoCenter");
            if (playingInfoCenter) {
                
                
                NSMutableDictionary *songInfo = [[NSMutableDictionary alloc] init];
                
                
                MPMediaItemArtwork *albumArt = [[MPMediaItemArtwork alloc] initWithImage:image];
                
                [songInfo setObject:nextsongs[z] forKey:MPMediaItemPropertyTitle];
                [songInfo setObject:nextartists[z] forKey:MPMediaItemPropertyArtist];
                [songInfo setObject:nexttapes[z] forKey:MPMediaItemPropertyAlbumTitle];
                [songInfo setObject:albumArt forKey:MPMediaItemPropertyArtwork];
                [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:songInfo];
                
            }
        }
        }

    // Mixtape Playing
    else {
        NSInteger x = [[NSUserDefaults standardUserDefaults] integerForKey:@"nowplaying-number"];
        NSInteger z = x + 1;
        NSArray *song = [[NSUserDefaults standardUserDefaults] objectForKey:@"nextplaying-songs"];
        NSString *artist1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"nextup-artist"];
        NSString *tape = [[NSUserDefaults standardUserDefaults] objectForKey:@"nextup-tape"];
        NSString *art = [[NSUserDefaults standardUserDefaults] objectForKey:@"nextup-art"];
                    [[NSUserDefaults standardUserDefaults] setObject:song[z] forKey:@"nowplaying-song"];
            [[NSUserDefaults standardUserDefaults] setObject:artist1 forKey:@"nowplaying-artist"];
            [[NSUserDefaults standardUserDefaults] setObject:tape forKey:@"nowplaying-tape"];
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:art]]];
            [Tools saveImage:image withName:@"artwork.png"];
            [[NSUserDefaults standardUserDefaults] setInteger:z forKey:@"nowplaying-number"];
            [self playRemoteFile:song[z]];
            Class playingInfoCenter = NSClassFromString(@"MPNowPlayingInfoCenter");
            if (playingInfoCenter) {
                
                
                NSMutableDictionary *songInfo = [[NSMutableDictionary alloc] init];
                
                
                MPMediaItemArtwork *albumArt = [[MPMediaItemArtwork alloc] initWithImage:image];
                
                [songInfo setObject:song[z] forKey:MPMediaItemPropertyTitle];
                [songInfo setObject:artist1 forKey:MPMediaItemPropertyArtist];
                [songInfo setObject:tape forKey:MPMediaItemPropertyAlbumTitle];
                [songInfo setObject:albumArt forKey:MPMediaItemPropertyArtwork];
                [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:songInfo];
                
            }
        }
        

    }



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isplaying"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"shuffle"];
    if (_artists.count == 0) {
        NSString *currentsong = songs[indexPath.row];
        //NSInteger *currentnumber = indexPath.row;
        NSString *currentartist = artist;
        NSString *currenttape = _mixtapename;
        NSString *currentart = artwork;
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isplaylist"];
        [[NSUserDefaults standardUserDefaults] setInteger:indexPath.row forKey:@"nowplaying-number"];
        [[NSUserDefaults standardUserDefaults] setObject:currentsong forKey:@"nowplaying-song"];
        [[NSUserDefaults standardUserDefaults] setObject:currentartist forKey:@"nowplaying-artist"];
        [[NSUserDefaults standardUserDefaults] setObject:currenttape forKey:@"nowplaying-tape"];
        [Tools saveImage:_artwork.image withName:@"artwork.png"];
        [self playRemoteFile:currentsong];
        [[NSUserDefaults standardUserDefaults] setObject:songs forKey:@"nextplaying-songs"];
        [[NSUserDefaults standardUserDefaults] setObject:currentartist forKey:@"nextup-artist"];
        [[NSUserDefaults standardUserDefaults] setObject:currentart forKey:@"nextup-art"];
        [[NSUserDefaults standardUserDefaults] setObject:currenttape forKey:@"nextup-tape"];
                [tableView deselectRowAtIndexPath:indexPath animated:YES];
        Class playingInfoCenter = NSClassFromString(@"MPNowPlayingInfoCenter");
        if (playingInfoCenter) {
            
            
            NSMutableDictionary *songInfo = [[NSMutableDictionary alloc] init];
            
            
            MPMediaItemArtwork *albumArt = [[MPMediaItemArtwork alloc] initWithImage:_artwork.image];
            
            [songInfo setObject:currentsong forKey:MPMediaItemPropertyTitle];
            [songInfo setObject:currentartist forKey:MPMediaItemPropertyArtist];
            [songInfo setObject:currenttape forKey:MPMediaItemPropertyAlbumTitle];
            [songInfo setObject:albumArt forKey:MPMediaItemPropertyArtwork];
            [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:songInfo];
            
            
        }


    } else {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isplaylist"];
        NSString *currentsong = songs[indexPath.row];
        NSString *currentartist = _artists[indexPath.row];
        NSString *currenttape = _mixtapenames[indexPath.row];
        [[NSUserDefaults standardUserDefaults] setObject:currentsong forKey:@"nowplaying-song"];
        [[NSUserDefaults standardUserDefaults] setObject:currentartist forKey:@"nowplaying-artist"];
        [[NSUserDefaults standardUserDefaults] setObject:currenttape forKey:@"nowplaying-tape"];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_artworks[indexPath.row]]]];
        [Tools saveImage:image withName:@"artwork.png"];
        _artwork.image = image;
        [self playRemoteFile:songs[indexPath.row]];
        [[NSUserDefaults standardUserDefaults] setInteger:indexPath.row forKey:@"nowplaying-number"];
        [[NSUserDefaults standardUserDefaults] setObject:songs forKey:@"nextplaying-songs"];
        [[NSUserDefaults standardUserDefaults] setObject:_mixtapenames forKey:@"nextplaying-tapes"];
        [[NSUserDefaults standardUserDefaults] setObject:_artists forKey:@"nextplaying-artists"];
        [[NSUserDefaults standardUserDefaults] setObject:_artworks forKey:@"nextplaying-artworks"];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        Class playingInfoCenter = NSClassFromString(@"MPNowPlayingInfoCenter");
        if (playingInfoCenter) {
            
            
            NSMutableDictionary *songInfo = [[NSMutableDictionary alloc] init];
            
            
            MPMediaItemArtwork *albumArt = [[MPMediaItemArtwork alloc] initWithImage:image];
            
            [songInfo setObject:currentsong forKey:MPMediaItemPropertyTitle];
            [songInfo setObject:currentartist forKey:MPMediaItemPropertyArtist];
            [songInfo setObject:currenttape forKey:MPMediaItemPropertyAlbumTitle];
            [songInfo setObject:albumArt forKey:MPMediaItemPropertyArtwork];
            [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:songInfo];
            
            
        }

            }
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isplaying"];
    if (playingisshowing == YES) {
        nil;
    } else {
        playingisshowing = YES;
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"currentplayer"];
        
        [_player addSubview:vc.view];
        
        [UIView animateWithDuration:1.0
                              delay:0.0
                            options:UIViewAnimationCurveEaseOut
                         animations:^
         {
             [_table setFrame:CGRectMake(0, 0,320, 328)];
             [_player setFrame:CGRectMake(0, 331,320, 60)];
             
         }
                         completion:^(BOOL finished)
         {
             if ( finished )
                 
                 nil;
         }];
    }

    }

-(void)playRemoteFile:(NSString*)songname{
    NSString *newString = [songname stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    [[AFSoundManager sharedManager]startStreamingRemoteAudioFromURL:[NSString stringWithFormat:@"https://s3-us-west-1.amazonaws.com/freshmix/%@.mp3",newString] andBlock:^(int percentage, CGFloat elapsedTime, CGFloat timeRemaining, NSError *error, BOOL finished) {
        
        if (!error) {
            
            [[NSUserDefaults standardUserDefaults] setInteger:percentage forKey:@"elapsed"];
            NSLog(@"%i percent played",percentage);
            if (percentage == 100) {
                [self nexttrack];
            }
        } else {
            
            NSLog(@"There has been an error playing the remote file: %@", [error description]);
        }
        
    }];
}

/*-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    NSString *selectedsong = songs[indexPath.row];
    
            NSString *selectedartist = artist;
    if (_artists.count == 0) {
        [[NSUserDefaults standardUserDefaults] setObject:selectedsong forKey:@"selectedsong"];
        [[NSUserDefaults standardUserDefaults] setObject:selectedartist forKey:@"selectedartist"];
        [[NSUserDefaults standardUserDefaults] setObject:_mixtapename forKey:@"selectedtape"];
        [[NSUserDefaults standardUserDefaults] setObject:artwork forKey:@"selectedart"];
         [Tools saveImage:_artwork.image withName:@"artwork.png"];
        int temp = pc + 1;
        _playcount.text = [NSString stringWithFormat:@"%d",temp];
        PFQuery *query = [PFQuery queryWithClassName:@"Mixtapes"];
        // Retrieve the object by id
        [query whereKey:@"Mixtape" equalTo:mixtapelabel.text];
        [query getFirstObjectInBackgroundWithBlock:^(PFObject *gameScore, NSError *error) {
            [gameScore incrementKey:@"playcountnumber"];
            
            [gameScore saveInBackground];
            
        }];
        
        Class playingInfoCenter = NSClassFromString(@"MPNowPlayingInfoCenter");
        if (playingInfoCenter) {
            
            
            NSMutableDictionary *songInfo = [[NSMutableDictionary alloc] init];
            
            
            MPMediaItemArtwork *albumArt = [[MPMediaItemArtwork alloc] initWithImage:[Tools loadImage:@"artwork.png"]];
            
            [songInfo setObject:selectedsong forKey:MPMediaItemPropertyTitle];
            [songInfo setObject:selectedartist forKey:MPMediaItemPropertyArtist];
            [songInfo setObject:_mixtapename forKey:MPMediaItemPropertyAlbumTitle];
            [songInfo setObject:albumArt forKey:MPMediaItemPropertyArtwork];
            [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:songInfo];
        }

        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isplaying"];
        if (playingisshowing == YES) {
            nil;
        } else {
            playingisshowing = YES;
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"currentplayer"];
            
            [_player addSubview:vc.view];
            
            [UIView animateWithDuration:1.0
                                  delay:0.0
                                options:UIViewAnimationCurveEaseOut
                             animations:^
             {
                 [_table setFrame:CGRectMake(0, 0,320, 328)];
                 [_player setFrame:CGRectMake(0, 331,320, 60)];
                 
             }
                             completion:^(BOOL finished)
             {
                 if ( finished )
 
                     nil;
             }];
        }

        [Tools playRemoteFile:selectedsong];
        [NSTimer scheduledTimerWithTimeInterval:1.0
                                         target:self
                                       selector:@selector(autonexttrack)
                                       userInfo:nil
                                        repeats:YES];
 
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:selectedsong forKey:@"selectedsong"];
        [[NSUserDefaults standardUserDefaults] setObject:[_artists objectAtIndex:indexPath.row] forKey:@"selectedartist"];
        [[NSUserDefaults standardUserDefaults] setObject:[_artworks objectAtIndex:indexPath.row] forKey:@"selectedart"];
        _artwork.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[_artworks objectAtIndex:indexPath.row]]]];
        [Tools saveImage:_artwork.image withName:@"artwork.png"];
        [[NSUserDefaults standardUserDefaults] setObject:[_mixtapenames objectAtIndex:indexPath.row] forKey:@"selectedtape"];
        
        Class playingInfoCenter = NSClassFromString(@"MPNowPlayingInfoCenter");
        if (playingInfoCenter) {
            
            
            NSMutableDictionary *songInfo = [[NSMutableDictionary alloc] init];
            
            
            MPMediaItemArtwork *albumArt = [[MPMediaItemArtwork alloc] initWithImage:[Tools loadImage:@"artwork.png"]];
            
            [songInfo setObject:selectedsong forKey:MPMediaItemPropertyTitle];
            [songInfo setObject:[_artists objectAtIndex:indexPath.row] forKey:MPMediaItemPropertyArtist];
            [songInfo setObject:[_mixtapenames objectAtIndex:indexPath.row] forKey:MPMediaItemPropertyAlbumTitle];
            [songInfo setObject:albumArt forKey:MPMediaItemPropertyArtwork];
            [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:songInfo];
        }
        

        current = indexPath.row;

        // release the newView as -addSubview: will retain it
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isplaying"];
    if (playingisshowing == YES) {
        nil;
    } else {
        playingisshowing = YES;
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"currentplayer"];
        
        [_player addSubview:vc.view];
        
        [UIView animateWithDuration:1.0
                              delay:0.0
                            options:UIViewAnimationCurveEaseOut
                         animations:^
         {
             [_table setFrame:CGRectMake(0, 0,320, 328)];
             [_player setFrame:CGRectMake(0, 331,320, 60)];
             
         }
                         completion:^(BOOL finished)
         {
             if ( finished )
 
                 nil;
         }];
    }
    
    
    [Tools playRemoteFile:selectedsong];
    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(autonexttrack)
                                   userInfo:nil
                                    repeats:YES];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }}

*/
-(void)autonexttrack{
    NSInteger percentage = [[NSUserDefaults standardUserDefaults] integerForKey:@"elapsed"];
    if (percentage == 100) {
        [self next];
    }}

-(void)manualnexttrack{
    [self next];
    }

-(void)next{
    if (current != songs.count) {
        NSInteger x = current + 1;
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_artworks[x]]]];
        [Tools saveImage:image withName:@"artwork.png"];
        Class playingInfoCenter = NSClassFromString(@"MPNowPlayingInfoCenter");
        if (playingInfoCenter) {
            
            
            NSMutableDictionary *songInfo = [[NSMutableDictionary alloc] init];
            
            
            MPMediaItemArtwork *albumArt = [[MPMediaItemArtwork alloc] initWithImage:image];
            
            [songInfo setObject:songs[x] forKey:MPMediaItemPropertyTitle];
            [songInfo setObject:_artists[x] forKey:MPMediaItemPropertyArtist];
            [songInfo setObject:_mixtapenames[x] forKey:MPMediaItemPropertyAlbumTitle];
            [songInfo setObject:albumArt forKey:MPMediaItemPropertyArtwork];
            [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:songInfo];
            [[NSUserDefaults standardUserDefaults] setObject:songs[x] forKey:@"selectedsong"];
            [[NSUserDefaults standardUserDefaults] setObject:_artists[x] forKey:@"selectedartist"];
            [[NSUserDefaults standardUserDefaults] setObject:_mixtapenames[x] forKey:@"selectedtape"];
            [[NSUserDefaults standardUserDefaults] setObject:_artworks[x] forKey:@"selectedart"];
        }
        [Tools playRemoteFile:songs[x]];
        current = x;
        
    } else {
        current = 0;
        [self next];
    }

}

-(void)adding{
    NSString *currentuser = [[NSUserDefaults standardUserDefaults] objectForKey:@"current"];
    PFQuery *query = [PFQuery queryWithClassName:@"UserData"];
    [query whereKey:@"username" equalTo:currentuser];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (!object) {
            UIActionSheet *alert = [[UIActionSheet alloc] initWithTitle: @"Choose a Playlist"
                                                               delegate: self
                                                      cancelButtonTitle: nil
                                                 destructiveButtonTitle: nil
                                                      otherButtonTitles: @"New Playlist",nil];
            alert.delegate = self;
            alert.cancelButtonIndex = [alert addButtonWithTitle:@"Cancel"];
            [alert showInView:self.view];
        } else {
            // The find succeeded.
            
            NSArray *playlists = object[@"playlists"];
            NSLog(@"Successfully retrieved the object.");
            
            UIActionSheet *alert = [[UIActionSheet alloc] initWithTitle: @"Choose a Playlist"
                                                               delegate: self
                                                      cancelButtonTitle: nil
                                                 destructiveButtonTitle: nil
                                                      otherButtonTitles: @"New Playlist",nil];
            
            for (int x = 0; x<playlists.count; x++) {
                if (x<10) {
                    [alert addButtonWithTitle:playlists[x]];
                } else {
                    nil;
                }
                
            }
            
            alert.cancelButtonIndex = [alert addButtonWithTitle:@"Cancel"];
            [alert showInView:self.view];
        }
    }];

    
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_artists.count == 0) {
        
    } else {
        if (editingStyle == UITableViewCellEditingStyleDelete)
        {
            
            [songs removeObjectAtIndex:indexPath.row];
            [_artists removeObjectAtIndex:indexPath.row];
            [_mixtapenames removeObjectAtIndex:indexPath.row];
            [_artworks removeObjectAtIndex:indexPath.row];
            NSArray *newsongs = songs;
            NSArray *newartists = _artists;
            NSArray *newtapes = _mixtapenames;
            NSArray *newart = _artworks;
            NSString *currentuser = [[NSUserDefaults standardUserDefaults] objectForKey:@"current"];
            PFQuery *query = [PFQuery queryWithClassName:@"UserData"];
            [query whereKey:@"username" equalTo:currentuser];
            [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
                if (!object) {
                    
                } else {
                    object[[NSString stringWithFormat:@"p%ld",_playlist]] = newsongs;
                    object[[NSString stringWithFormat:@"p%ldcreator",_playlist]] = newartists;
                    object[[NSString stringWithFormat:@"p%ldart",_playlist]] = newart;
                    object[[NSString stringWithFormat:@"p%ldtape",_playlist]] = newtapes;
                    [object save];
                    if (newsongs.count < 1) {
                        [allplaylists removeObjectAtIndex:_playlist];
                        [object save];
                        [self dismissViewControllerAnimated:YES completion:nil];
                    }

                    
                    
                }     }];
            
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }

    }
    }




-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"selection"];
    selection = savedValue;
    NSString *buttonpressed = [actionSheet buttonTitleAtIndex:buttonIndex];
    PFUser *user = [PFUser currentUser];
    NSString *current = user.username;
    if([buttonpressed isEqualToString:@"New Playlist"])
    {
        PFQuery *query = [PFQuery queryWithClassName:@"UserData"];
        
        // Retrieve the object by id
        [query whereKey:@"username" equalTo:current];
        [query getFirstObjectInBackgroundWithBlock:^(PFObject *gameScore, NSError *error) {
            NSArray *playlists = gameScore[@"playlists"];
            if (playlists.count > 9) {
                UIAlertView *toast = [[UIAlertView alloc] initWithTitle:@"Sorry!"
                                                                message:@"Unfortuantely there is a maximum of 10 Playlists"
                                                               delegate:nil
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:nil, nil];
                [toast show];
                
                int duration = 2.5; // duration in seconds
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [toast dismissWithClickedButtonIndex:0 animated:YES];
                });
            } else {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Playlist Creation" message:@"Name Your New Playlist" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: @"Done",nil] ;
                alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
                [alertView show];
                
            }
            
        }];
        

        
    }
    else if ([buttonpressed isEqualToString:@"Cancel"]) {
        nil;
    }
    
    else {
        PFQuery *query = [PFQuery queryWithClassName:@"UserData"];
        NSInteger x = buttonIndex - 1;
        // Retrieve the object by id
        [query whereKey:@"username" equalTo:current];
        [query getFirstObjectInBackgroundWithBlock:^(PFObject *gameScore, NSError *error) {
            [gameScore addObject:savedValue forKey:[NSString stringWithFormat:@"p%ld",(long)x]];
            [gameScore addObject:artwork forKey:[NSString stringWithFormat:@"p%ldart",(long)x]];
            [gameScore addObject:artist forKey:[NSString stringWithFormat:@"p%ldcreator",(long)x]];
            [gameScore addObject:mixtapelabel.text forKey:[NSString stringWithFormat:@"p%ldtape",(long)x]];
            [gameScore saveInBackground];
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
            // Configure for text only and offset down
            hud.mode = MBProgressHUDModeText;
            hud.labelText = [NSString stringWithFormat:@"Added: %@",savedValue];
            hud.margin = 20.f;
            hud.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.50];
            hud.yOffset = 150.f;
            hud.removeFromSuperViewOnHide = YES;
            
            [hud hide:YES afterDelay:1];

            PFQuery *query = [PFQuery queryWithClassName:@"Mixtapes"];
            // Retrieve the object by id
            [query whereKey:@"Mixtape" equalTo:mixtapelabel.text];
            [query getFirstObjectInBackgroundWithBlock:^(PFObject *gameScore, NSError *error) {
                [gameScore incrementKey:@"favcountnumber"];
                [gameScore saveInBackground];
                
            }];

        }];
    }
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    UITextField * alertTextField = [alertView textFieldAtIndex:0];
    PFUser *user = [PFUser currentUser];
    NSString *current = user.username;
    PFQuery *query = [PFQuery queryWithClassName:@"UserData"];
    if ([alertTextField.text length] < 1) {
        UIAlertView *toast = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"\nName Your Playlist Next Time...\n"
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:nil, nil];
        [toast show];
        int duration = 2.5; // duration in seconds
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [toast dismissWithClickedButtonIndex:0 animated:YES];
        });
    } else {
        // Retrieve the object by id
        [query whereKey:@"username" equalTo:current];
        [query getFirstObjectInBackgroundWithBlock:^(PFObject *gameScore, NSError *error) {
            [gameScore addUniqueObjectsFromArray:@[alertTextField.text] forKey:@"playlists"];
            [gameScore save];
            [self adding];
        }];

    }
    
    // do whatever you want to do with this UITextField.
}





- (void)playerItemDidReachEnd:(NSNotification *)notification {
    
    //  code here to play next sound file
    
}

-(void)currentPlayingStatusChanged:(AFSoundManagerStatus)status {
    //NSInteger rando = arc4random() % infonames.count-1;
    //NSString *newString = [infonames[rando] stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    switch (status) {
        case AFSoundManagerStatusFinished:
            
            [self nexttrack];
            break;
            
        case AFSoundManagerStatusPaused:
            //Playing was paused
            break;
            
        case AFSoundManagerStatusPlaying:
            //Playing got started or resumed
            break;
            
        case AFSoundManagerStatusRestarted:
            //Playing got restarted
            break;
            
        case AFSoundManagerStatusStopped:
            //Playing got stopped
            break;
            
        default:
            break;
    }
}




- (IBAction)more:(id)sender {
    if (stats == 0) {
        [_scroll setContentOffset:CGPointMake(320, 0) animated:YES];
        [_more setTitle:@"Less" forState:UIControlStateNormal];
        stats = 1;
    } else {
        [_scroll setContentOffset:CGPointMake(0, 0) animated:YES];
        [_more setTitle:@"More" forState:UIControlStateNormal];
        stats = 0;
    }
    
}
- (IBAction)artisttwitter:(id)sender {
    [Tools twitter:twitter];
}

- (IBAction)artistfacebook:(id)sender {
    [Tools facebook:facebook];
}

- (IBAction)artistsoundcloud:(id)sender {
    [Tools soundcloud:soundcloud];
}


- (IBAction)shuffle:(id)sender {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"shuffle"];
    NSInteger random = arc4random() % songs.count;
    [self playRemoteFile:songs[random]];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isplaylist"];
    NSString *currentsong = songs[random];
    NSString *currentartist = _artists[random];
    NSString *currenttape = _mixtapenames[random];
    [[NSUserDefaults standardUserDefaults] setObject:currentsong forKey:@"nowplaying-song"];
    [[NSUserDefaults standardUserDefaults] setObject:currentartist forKey:@"nowplaying-artist"];
    [[NSUserDefaults standardUserDefaults] setObject:currenttape forKey:@"nowplaying-tape"];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_artworks[random]]]];
    [Tools saveImage:image withName:@"artwork.png"];
    _artwork.image = image;
    [[NSUserDefaults standardUserDefaults] setInteger:random forKey:@"nowplaying-number"];
    [[NSUserDefaults standardUserDefaults] setObject:songs forKey:@"nextplaying-songs"];
    [[NSUserDefaults standardUserDefaults] setObject:_mixtapenames forKey:@"nextplaying-tapes"];
    [[NSUserDefaults standardUserDefaults] setObject:_artists forKey:@"nextplaying-artists"];
    [[NSUserDefaults standardUserDefaults] setObject:_artworks forKey:@"nextplaying-artworks"];
    Class playingInfoCenter = NSClassFromString(@"MPNowPlayingInfoCenter");
    if (playingInfoCenter) {
        
        
        NSMutableDictionary *songInfo = [[NSMutableDictionary alloc] init];
        
        
        MPMediaItemArtwork *albumArt = [[MPMediaItemArtwork alloc] initWithImage:image];
        
        [songInfo setObject:currentsong forKey:MPMediaItemPropertyTitle];
        [songInfo setObject:currentartist forKey:MPMediaItemPropertyArtist];
        [songInfo setObject:currenttape forKey:MPMediaItemPropertyAlbumTitle];
        [songInfo setObject:albumArt forKey:MPMediaItemPropertyArtwork];
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:songInfo];
        
        
    }
    

[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isplaying"];
    if (playingisshowing == YES) {
        nil;
    } else {
        playingisshowing = YES;
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"currentplayer"];
        
        [_player addSubview:vc.view];
        
        [UIView animateWithDuration:1.0
                              delay:0.0
                            options:UIViewAnimationCurveEaseOut
                         animations:^
         {
             [_table setFrame:CGRectMake(0, 0,320, 328)];
             [_player setFrame:CGRectMake(0, 331,320, 60)];
             
         }
                         completion:^(BOOL finished)
         {
             if ( finished )
                 
                 nil;
         }];
   
    }
}



@end
