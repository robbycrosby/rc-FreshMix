
    
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
    _roundbutton.imageView.alpha = 0.5f;
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
    
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         //_menubar.hidden = NO;
                         _shuffle.hidden = YES;
                         _done.hidden = NO;
                         [self shadow:_shuffle];
                         [self shadow:_done];
                         _menubar.frame = CGRectMake(0, 0, 320, 49);
                         //_shuffle.frame = CGRectMake(266, 5, 39, 39);
                         _done.frame = CGRectMake(5, 5, 39, 39);
                         _scrolltable.frame = CGRectMake(0, 67, 320, 492);
                         _top.frame = CGRectMake(0, 320, 320, 103);
                         [[UIApplication sharedApplication] setStatusBarHidden:YES
                                                                 withAnimation:UIStatusBarAnimationFade];
                         _artwork.frame = CGRectMake(0, 0, 320, 320);
                         [_scrolltable setContentSize:CGSizeMake(320, 640)];
                         
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:0.2
                                               delay:0.0
                                             options: UIViewAnimationOptionCurveEaseInOut
                                          animations:^{
                                              
                                              _scrolltable.frame = CGRectMake(0, 97, 320, 472);
                                              
                                          }
                                          completion:^(BOOL finished){
                                              bool playstatus = [[NSUserDefaults standardUserDefaults] boolForKey:@"isplaying"];
                                              if (playstatus == NO) {
                                                  nil;
                                              } else {
                                                  [UIView animateWithDuration:0.2
                                                                        delay:0.0
                                                                      options: UIViewAnimationOptionCurveEaseInOut
                                                                   animations:^{
                                                                       _playercontrols.hidden =NO;
                                                                       _platercontrolsbackground.hidden =NO;
                                                                       _playercontrols.frame = CGRectMake(0, 0, 320, 60);
                                                                       _platercontrolsbackground.frame = CGRectMake(0, 0, 320, 60);
                                                                       _done.frame = CGRectMake(0, 59, 39, 39);
                                                                       
                                                                   }
                                                                   completion:^(BOOL finished){
                                                                   }];
                                              }
                                              
                                          }];
                     }];
    
}

-(void)viewWillAppear:(BOOL)animated{
    _menubar.hidden = YES;
    _shuffle.hidden = YES;
    _done.hidden = YES;
    bool is35 = [[NSUserDefaults standardUserDefaults] boolForKey:@"is3.5"];
    if (is35 == YES) {
        
        [_table setFrame:CGRectMake(0, 0,320, 302)];
        [_player setFrame:CGRectMake(0, 391,320, 60)];
        [_scroll setContentSize:CGSizeMake(640, 386)];
        _shareemail.hidden = YES;
        _sharesms.hidden = YES;
        _sharefacebook.hidden = YES;
        _sharetwitter.hidden = YES;
        _sharetitle.hidden = YES;
        
    } else {
       // [_table setFrame:CGRectMake(0, 0,320, 391)];
        //[_player setFrame:CGRectMake(0, 391,320, 60)];
        
       // [moreinfo setContentSize:CGSizeMake(320, 391)];
        
        
    }
    
    //mixtapelabel.alpha = 0;
    //_artist.alpha = 0;
    //_table.alpha = 0;
    mixtapelabel.text = _mixtapename;
    //_artist.text = _art
    if (_playlist == -1) {
        [self findtape:_mixtapename];
        
        [_table setEditing:NO];
    } else {
        _scroll.scrollEnabled = NO;
        
        [self findplaylist];
        _more.enabled = NO;
        _favorite.enabled = NO;
        _shareemail.enabled = NO;
        _sharefacebook.enabled = NO;
        _sharetwitter.enabled = NO;
        _sharesms.enabled = NO;
        
    }
    stats = 0;
    [super viewDidLoad];
    [_popup addTarget:self action:@selector(popupimage) forControlEvents:UIControlEventTouchUpInside];
    [self shadow:_roundbutton];
    [self shadow:_color];
    //[Tools parallax:_roundbutton];
}


-(void)viewDidLoad {
    _roundbutton.layer.cornerRadius = 30;

    /*
    bool is35 = [[NSUserDefaults standardUserDefaults] boolForKey:@"is3.5"];
    if (is35 == YES) {
        
        [_table setFrame:CGRectMake(0, 0,320, 302)];
        [_player setFrame:CGRectMake(0, 391,320, 60)];
        [_scroll setContentSize:CGSizeMake(640, 386)];
        _shareemail.hidden = YES;
        _sharesms.hidden = YES;
        _sharefacebook.hidden = YES;
        _sharetwitter.hidden = YES;
        _sharetitle.hidden = YES;
        
    } else {
        [_table setFrame:CGRectMake(0, 0,320, 391)];
        [_player setFrame:CGRectMake(0, 391,320, 60)];
        [_scroll setContentSize:CGSizeMake(640, 302)];
        [moreinfo setContentSize:CGSizeMake(320, 391)];
        
        
    }
   
    //mixtapelabel.alpha = 0;
    //_artist.alpha = 0;
    //_table.alpha = 0;
    mixtapelabel.text = _mixtapename;
    if (_playlist == -1) {
        [self findtape:_mixtapename];
        
        [_table setEditing:NO];
    } else {
        [self findplaylist];
        _more.enabled = NO;
        _favorite.enabled = NO;
        _shareemail.enabled = NO;
        _sharefacebook.enabled = NO;
        _sharetwitter.enabled = NO;
        _sharesms.enabled = NO;
        
    }
    stats = 0;
    [super viewDidLoad];
    [_popup addTarget:self action:@selector(popupimage) forControlEvents:UIControlEventTouchUpInside];
    
     */
    //self.view.backgroundColor = [UIColor clearColor];
    //UIToolbar *blurbar = [[UIToolbar alloc] initWithFrame:self.view.frame];
    //blurbar.barStyle = UIBarStyleDefault;
    //[self.view addSubview:blurbar];
    //[self.view sendSubviewToBack:blurbar];
    [super viewDidLoad];
    
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
                    [MixtapeViewController nexttrack];
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
    NSArray *mixtapes = [[NSUserDefaults standardUserDefaults] arrayForKey:@"mixtapes"];
    NSArray *artists = [[NSUserDefaults standardUserDefaults] arrayForKey:@"artists"];
    NSArray *artworks = [[NSUserDefaults standardUserDefaults] arrayForKey:@"artworks"];
    for (int x = 0; x < [[NSUserDefaults standardUserDefaults] integerForKey:@"mixtapecount"]; x++) {
        if ([find isEqualToString:mixtapes[x]]) {
            NSString *mixtapename = mixtapes[x];
            NSString *artistname = artists[x];
            NSString *artworkurl = artworks[x];
            songs = [[NSUserDefaults standardUserDefaults] objectForKey:mixtapename];
            saveartist = artistname;
            artist = artistname;
            _artist.text = artistname;
            _aname.text = artistname;
            _artwork.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:artworkurl]]];
            _artwork.hidden = NO;
            [UIView animateWithDuration:0.3
                                  delay:0.0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{ _artwork.alpha = 1; _artist.alpha = 1; _table.alpha = 1; mixtapelabel.alpha = 1;}
                             completion:^(BOOL finished){}
             ];
            //_artwork.layer.cornerRadius = 5;
            //_artwork.clipsToBounds = YES;
            blur =[_artwork.image stackBlur:50];
            _blurart.image = blur;
            [self shader:_blurart];
            LEColorPicker *colorPicker = [[LEColorPicker alloc] init];
            LEColorScheme *colorScheme = [colorPicker colorSchemeFromImage:_artwork.image];
            //self.view.backgroundColor = [colorScheme backgroundColor];
            backcolor = [colorScheme backgroundColor];
            main = [colorScheme primaryTextColor];
            weak = [colorScheme secondaryTextColor];
            //self.view.backgroundColor = main;
            _color.backgroundColor = main;
            _roundbutton.backgroundColor = backcolor;
            mixtapelabel.textColor = backcolor;
            _artist.textColor = backcolor;
            // _table.backgroundColor = main;
            //_bottom.backgroundColor = backcolor;
            _top.backgroundColor = main;
            //_artist.alpha = .75f;
            _table.separatorColor = main;
            [_table reloadData];
        }
    }
    /*
    PFQuery *query = [PFQuery queryWithClassName:@"Mixtapes"];
    [query whereKey:@"Mixtape" equalTo:find];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (!object) {
            NSLog(@"The getFirstObject request failed.");
        } else {
            // The find succeeded.
            savetape = object[@"Mixtape"];
            artist = object[@"Artist"];
            saveartist = artist;
            _artist.text = artist;
            _aname.text = artist;
            //artwork = object[@"Art"];
            songs = object[@"Songs"];
            
            saveartwork = artwork;
            
            _artwork.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:artwork]]];
            _artwork.hidden = NO;
            [UIView animateWithDuration:0.3
                                  delay:0.0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{ _artwork.alpha = 1; _artist.alpha = 1; _table.alpha = 1; mixtapelabel.alpha = 1;}
                             completion:^(BOOL finished){}
             ];
            //_artwork.layer.cornerRadius = 5;
            //_artwork.clipsToBounds = YES;
            blur =[_artwork.image stackBlur:50];
            _blurart.image = blur;
            [self shader:_blurart];
            LEColorPicker *colorPicker = [[LEColorPicker alloc] init];
            LEColorScheme *colorScheme = [colorPicker colorSchemeFromImage:_artwork.image];
            //self.view.backgroundColor = [colorScheme backgroundColor];
            backcolor = [colorScheme backgroundColor];
            main = [colorScheme primaryTextColor];
            weak = [colorScheme secondaryTextColor];
            //self.view.backgroundColor = main;
            _color.backgroundColor = main;
            _roundbutton.backgroundColor = backcolor;
            mixtapelabel.textColor = backcolor;
            _artist.textColor = backcolor;
           // _table.backgroundColor = main;
            //_bottom.backgroundColor = backcolor;
            _top.backgroundColor = main;
            //_artist.alpha = .75f;
            _table.separatorColor = main;
            [_table reloadData];
        }
    }];*/

}

-(void)shader:(UIImageView*)button{
    button.maskView.layer.cornerRadius = 7.0f;
    button.layer.shadowRadius = 3.0f;
    button.layer.shadowColor = [UIColor blackColor].CGColor;
    button.layer.shadowOffset = CGSizeMake(0.0f, 3.0f);
    button.layer.shadowOpacity = 0.3f;
    button.layer.masksToBounds = NO;
}

-(void)shadow:(UIButton*)button{
    button.maskView.layer.cornerRadius = 7.0f;
    button.layer.shadowRadius = 1.5f;
    button.layer.shadowColor = [UIColor blackColor].CGColor;
    button.layer.shadowOffset = CGSizeMake(0.0f, 3.0f);
    button.layer.shadowOpacity = 0.3f;
    button.layer.masksToBounds = NO;
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
            LEColorPicker *colorPicker = [[LEColorPicker alloc] init];
            LEColorScheme *colorScheme = [colorPicker colorSchemeFromImage:_artwork.image];
            //self.view.backgroundColor = [colorScheme backgroundColor];
            backcolor = [colorScheme backgroundColor];
            main = [colorScheme primaryTextColor];
            weak = [colorScheme secondaryTextColor];
            //self.view.backgroundColor = main;
            _color.backgroundColor = main;
            _roundbutton.backgroundColor = backcolor;
            mixtapelabel.textColor = backcolor;
            _artist.textColor = backcolor;
            // _table.backgroundColor = main;
            //_bottom.backgroundColor = backcolor;
            _top.backgroundColor = main;
            //_artist.alpha = .75f;
            _table.separatorColor = main;
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
    if (_artists.count == 0) {
        
        //cell.songname.textColor = main;
        //cell.favorite.tintColor = main;
    }
    cell.songname.text = [songs objectAtIndex:indexPath.row];
    NSString *song = [[NSUserDefaults standardUserDefaults] stringForKey:@"nowplaying-song"];
    if ([cell.songname.text isEqualToString:song]) {
        cell.songname.textColor = main;
    }
    
    

    [cell.favorite addTarget:self action:@selector(adding) forControlEvents:UIControlEventTouchUpInside];
    //cell.backgroundColor = backcolor;
    //cell.songname.textColor = weak;
    //cell.favorite.tintColor = weak;
    _shuffle.tintColor = main;
    [_shuffle setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_done setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //cell.favorite.hidden = YES;
    //_table.backgroundColor = backcolor;
    //_scroll.backgroundColor = backcolor;
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
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"justloaded"];
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
            [MixtapeViewController playRemoteFile:nextsongs[z]];
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
        [MixtapeViewController playRemoteFile:song[z]];
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


+(void)nexttrack{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"justloaded"];
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
    
    [_table reloadData];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"showads"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"justloaded"];
    //UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isplaying"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"shuffle"];
    if (_artists.count == 0) {
        NSLog(@"mixtape");
        NSString *currentsong = songs[indexPath.row];
        NSLog(currentsong);
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
        [MixtapeViewController playRemoteFile:currentsong];
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
        LEColorPicker *colorPicker = [[LEColorPicker alloc] init];
        LEColorScheme *colorScheme = [colorPicker colorSchemeFromImage:image];
        //self.view.backgroundColor = [colorScheme backgroundColor];
        backcolor = [colorScheme backgroundColor];
        main = [colorScheme primaryTextColor];
        weak = [colorScheme secondaryTextColor];
        //self.view.backgroundColor = main;
        
        
        
        
        // _table.backgroundColor = main;
        //_bottom.backgroundColor = backcolor;
        
        //_artist.alpha = .75f;
        
        
        [UIView transitionWithView:_color duration:0.25 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            _color.backgroundColor = main;
        } completion:nil];
        [UIView transitionWithView:mixtapelabel duration:0.25 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            mixtapelabel.textColor = backcolor;
        } completion:nil];
        [UIView transitionWithView:_artist duration:0.25 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            _artist.textColor = backcolor;
        } completion:nil];
        [UIView transitionWithView:_top duration:0.25 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            _top.backgroundColor = main;
        } completion:nil];
        [UIView transitionWithView:_table duration:0.25 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            _table.separatorColor = main;
        } completion:nil];
        [UIView transitionWithView:_roundbutton duration:0.25 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            _roundbutton.backgroundColor = backcolor;
        } completion:nil];
        [MixtapeViewController playRemoteFile:songs[indexPath.row]];
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
    if (_platercontrolsbackground.frame.origin.y < 0) {
        [UIView animateWithDuration:0.3
                              delay:0.0
                            options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             _playercontrols.hidden =NO;
                             _platercontrolsbackground.hidden =NO;
                             _playercontrols.frame = CGRectMake(0, 0, 320, 60);
                             _platercontrolsbackground.frame = CGRectMake(0, 0, 320, 60);
                             _done.frame = CGRectMake(0, 59, 39, 39);
                             
                         }
                         completion:^(BOOL finished){
                         }];

    }
    
    
    /*
    if (playingisshowing == YES) {
        nil;
    } else {
        bool screen = [[NSUserDefaults standardUserDefaults] boolForKey:@"is3.5"];
        if (screen != YES) {
            playingisshowing = YES;
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"currentplayer"];
            
            [_player addSubview:vc.view];
            
            [UIView animateWithDuration:1.0
                                  delay:0.0
                                options:UIViewAnimationCurveEaseOut
                             animations:^
             {
                 [_table setFrame:CGRectMake(0, 275,320, 234)];
                 [_player setFrame:CGRectMake(0, 331,320, 60)];
                 
             }
                             completion:^(BOOL finished)
             {
                 if ( finished )
                     
                     nil;
             }];
        }
        
    } */

    }

+(void)playRemoteFile:(NSString*)songname{
    NSString *newString = [songname stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    [[AFSoundManager sharedManager]startStreamingRemoteAudioFromURL:[NSString stringWithFormat:@"https://s3-us-west-1.amazonaws.com/freshmix/%@.mp3",newString] andBlock:^(int percentage, CGFloat elapsedTime, CGFloat timeRemaining, NSError *error, BOOL finished) {
        
        if (!error) {
            
            [[NSUserDefaults standardUserDefaults] setInteger:percentage forKey:@"elapsed"];
            NSLog(@"%i percent played",percentage);
            if (percentage == 100) {
                [MixtapeViewController nexttrack];
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
    bool shuffle = [[NSUserDefaults standardUserDefaults] boolForKey:@"shuffle"];
    if (shuffle == YES) {
        if (current != songs.count) {
            
            NSInteger x = arc4random() % songs.count;
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
            
        }
    } else {
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
    

}

-(void)adding{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
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
        }];// Do something...
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
    

    
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
            
            [MixtapeViewController nexttrack];
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
        _more.titleLabel.textColor = main;
        stats = 1;
    } else {
            [_scroll setContentOffset:CGPointMake(0, 0) animated:YES];
            [_more setTitle:@"More" forState:UIControlStateNormal];
            stats = 0;
        _more.titleLabel.textColor = main;
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
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"justloaded"];
    if (_artists.count < 1) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"shuffle"];
        NSInteger random = arc4random() % songs.count;
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isplaylist"];
        NSString *currentsong = songs[random];
        //NSInteger *currentnumber = indexPath.row;
        NSString *currentartist = artist;
        NSString *currenttape = _mixtapename;
        NSString *currentart = artwork;
        [[NSUserDefaults standardUserDefaults] setObject:artwork forKey:@"selectedart"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isplaylist"];
        [[NSUserDefaults standardUserDefaults] setInteger:random forKey:@"nowplaying-number"];
        [[NSUserDefaults standardUserDefaults] setObject:currentsong forKey:@"nowplaying-song"];
        [[NSUserDefaults standardUserDefaults] setObject:currentartist forKey:@"nowplaying-artist"];
        [[NSUserDefaults standardUserDefaults] setObject:currenttape forKey:@"nowplaying-tape"];
        [Tools saveImage:_artwork.image withName:@"artwork.png"];
        [MixtapeViewController playRemoteFile:currentsong];
        [[NSUserDefaults standardUserDefaults] setObject:songs forKey:@"nextplaying-songs"];
        [[NSUserDefaults standardUserDefaults] setObject:currentartist forKey:@"nextup-artist"];
        [[NSUserDefaults standardUserDefaults] setObject:currentart forKey:@"nextup-art"];
        [[NSUserDefaults standardUserDefaults] setObject:currenttape forKey:@"nextup-tape"];
        Class playingInfoCenter = NSClassFromString(@"MPNowPlayingInfoCenter");
        if (playingInfoCenter) {
            
            
            NSMutableDictionary *songInfo = [[NSMutableDictionary alloc] init];
            
            
            MPMediaItemArtwork *albumArt = [[MPMediaItemArtwork alloc] initWithImage:_artwork.image];
            
            [songInfo setObject:currentsong forKey:MPMediaItemPropertyTitle];
            [songInfo setObject:currentartist forKey:MPMediaItemPropertyArtist];
            [songInfo setObject:currenttape forKey:MPMediaItemPropertyAlbumTitle];
            [songInfo setObject:albumArt forKey:MPMediaItemPropertyArtwork];
            [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:songInfo];
            
            
        }    } else {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"shuffle"];
        NSInteger random = arc4random() % songs.count;
        [MixtapeViewController playRemoteFile:songs[random]];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isplaylist"];
        NSString *currentsong = songs[random];
        NSString *currentartist = _artists[random];
        NSString *currenttape = _mixtapenames[random];
            NSString *currentart = _artworks[random];
        [[NSUserDefaults standardUserDefaults] setObject:currentsong forKey:@"nowplaying-song"];
        [[NSUserDefaults standardUserDefaults] setObject:currentartist forKey:@"nowplaying-artist"];
        [[NSUserDefaults standardUserDefaults] setObject:currenttape forKey:@"nowplaying-tape"];
            [[NSUserDefaults standardUserDefaults] setObject:currentart forKey:@"selectedart"];
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
            if (_platercontrolsbackground.frame.origin.y < 0) {
                [UIView animateWithDuration:0.3
                                      delay:0.0
                                    options: UIViewAnimationOptionCurveEaseInOut
                                 animations:^{
                                     _playercontrols.hidden =NO;
                                     _platercontrolsbackground.hidden =NO;
                                     _playercontrols.frame = CGRectMake(0, 0, 320, 60);
                                     _platercontrolsbackground.frame = CGRectMake(0, 0, 320, 60);
                                     _done.frame = CGRectMake(0, 59, 39, 39);
                                     
                                 }
                                 completion:^(BOOL finished){
                                 }];
                
            }

    }
    
    

[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isplaying"];
    /*
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
     */
}



- (IBAction)favorite:(id)sender {
    NSString *currentuser = [[NSUserDefaults standardUserDefaults] objectForKey:@"current"];
    PFQuery *query = [PFQuery queryWithClassName:@"UserData"];
    // Retrieve the object by id
    [query whereKey:@"username" equalTo:currentuser];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *gameScore, NSError *error) {
        [gameScore addObject:savetape forKey:@"saved_mixtapes"];
        [gameScore addObject:saveartist forKey:@"saved_artists"];
        [gameScore addObject:saveartwork forKey:@"saved_artwork"];
        [gameScore saveInBackground];
    }];
    // Configure for text only and offset down
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
    hud.mode = MBProgressHUDModeText;
    hud.labelText = [NSString stringWithFormat:@"Saved Mixtape: %@",savetape];
    hud.margin = 20.f;
    hud.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.50];
    hud.yOffset = 150.f;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:1];
    }


-(void)popupimage{
    UIImageView *image = [[UIImageView alloc] initWithImage:_artwork.image];
    
    zoomPopup *popup = [[zoomPopup alloc] initWithMainview:self.view andStartRect:_artwork.frame];
    [popup setBlurRadius:10];
    [popup showPopup:image];
}

-(void)twitter:(NSString*)listen{
    TWTweetComposeViewController *tweetSheet = [[TWTweetComposeViewController alloc] init];
    
    //Customize the tweet sheet here
    //Add a tweet message
    [tweetSheet setInitialText:[NSString stringWithFormat:@"Listening to %@ on Young California #YoungCalifornia",listen]];
    
    //Add an image
    [tweetSheet addImage:_artwork.image];
    
    //Add a link
    //Don't worry, Twitter will handle turning this into a t.co link
    [tweetSheet addURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/freshmix/id904521602?ls=1&mt=8"]];
    
    //Set a blocking handler for the tweet sheet
    tweetSheet.completionHandler = ^(TWTweetComposeViewControllerResult result){
        [self dismissModalViewControllerAnimated:YES];
    };
    
    //Show the tweet sheet!
    [self presentModalViewController:tweetSheet animated:YES];
}

-(void)facebook:(NSString*)listen{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeFacebook];
        [tweetSheet setInitialText:[NSString stringWithFormat:@"Listening to %@ on Young California #YoungCalifornia",listen]];
        [tweetSheet addImage:_artwork.image];
        [self presentViewController:tweetSheet animated:YES completion:nil];
        
        
        
    } else {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
        { SLComposeViewController *tweetSheet = [SLComposeViewController
                                                 composeViewControllerForServiceType:SLServiceTypeFacebook];
            [tweetSheet setInitialText:@"😭"];
            
            [self presentViewController:tweetSheet animated:YES completion:nil];
            
            
            //inform the user that no account is configured with alarm view.
        }
        
    }
}
- (IBAction)sharefacebook:(id)sender {
    [self facebook:artist];
}
- (IBAction)sharesms:(id)sender {
    if(![MFMessageComposeViewController canSendText]) {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [warningAlert show];
        return;
    }
    
    NSArray *recipents = nil;
    NSString *message = [NSString stringWithFormat:@"Listening to %@ on Young California, you should check it out!",artist];
    
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;
    [messageController setRecipients:recipents];
    [messageController setBody:message];
    
    
    // Present message view controller on screen
    [self presentViewController:messageController animated:YES completion:nil];
}
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissModalViewControllerAnimated:YES];
    
    if (result == MessageComposeResultCancelled)
        NSLog(@"Message cancelled");
    else if (result == MessageComposeResultSent)
        NSLog(@"Message sent");
    else
        NSLog(@"Message failed")  ;
}

- (IBAction)email:(id)sender {
    // Email Subject
    NSString *emailTitle = @"Sweet New Mixtape";
    // Email Content
    NSString *messageBody = [NSString stringWithFormat:@"Listening to %@ by %@ on Young California.\n\nCheck it out here: http://goo.gl/r7zZjs!",mixtapelabel.text,artist];// Change the message body to HTML
    // To address
    NSArray *toRecipents = nil;
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
}

- (IBAction)sharetwitter:(id)sender {
    [self twitter:artist];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
