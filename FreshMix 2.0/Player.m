//
//  Player.m
//  FreshMix 2.0
//
//  Created by Robert Crosby on 8/31/14.
//  Copyright (c) 2014 8-Bit Pyramid. All rights reserved.
//

#import "Player.h"

@interface Player ()

@end

@implementation Player


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

    
    [super viewDidLoad];
    [self shader:_playpause];
    [_scroll setContentSize:CGSizeMake(640, 60)];
    //[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isplaying"];
    
    [self.view setBackgroundColor: [UIColor clearColor]];
    [self.view setOpaque: NO];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)setsongnames{
    bool playstatus = [[NSUserDefaults standardUserDefaults] boolForKey:@"isplaying"];
    if (playstatus == NO) {

        [_playpause setBackgroundImage:[UIImage imageNamed: @"play.png"] forState:UIControlStateNormal];

    } else {
       [_playpause setBackgroundImage:[UIImage imageNamed: @"pause.png"] forState:UIControlStateNormal];
    }
    
    NSString *artist = [[NSUserDefaults standardUserDefaults] stringForKey:@"selectedartist"];
    NSString *song = [[NSUserDefaults standardUserDefaults] stringForKey:@"selectedsong"];
    
    NSString *art = [[NSUserDefaults standardUserDefaults] stringForKey:@"selectedart"];
    NSString *tape = [[NSUserDefaults standardUserDefaults] stringForKey:@"selectedtape"];
    if ([art length] < 1) {
        
        art = @"http://www.runrig.co.uk/wp-content/themes/soundcheck/images/default-album-artwork.png";
        tapename = tape;
        _songname.text = song;
        _artist.text = artist;
        _tape = tape;
        UIImage *artwork = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:art]]];
        [_artwork setBackgroundImage:artwork forState:UIControlStateNormal];
        

    } else {

        art = @"http://www.runrig.co.uk/wp-content/themes/soundcheck/images/default-album-artwork.png";
        tapename = tape;
        _songname.text = song;
        _artist.text = artist;
        _tape = tape;
        
    }
    
        [NSTimer scheduledTimerWithTimeInterval:0.5
                                     target:self
                                   selector:@selector(gettime)
                                   userInfo:nil
                                    repeats:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [self setsongnames];
}


-(void)gettime{
    bool noads = [[NSUserDefaults standardUserDefaults] boolForKey:@"showads"];
    //bool launch = [[NSUserDefaults standardUserDefaults]  boolForKey:@"launched"];
    if (noads == NO) {

    } 
    
    NSInteger time = [[NSUserDefaults standardUserDefaults] integerForKey:@"elapsed"];
    _elapsed.progress = time * 0.01;
    [_artwork addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
    _songname.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"nowplaying-song"];
    tapename = [[NSUserDefaults standardUserDefaults] stringForKey:@"nowplaying-tape"];
    _artist.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"nowplaying-artist"];
    [_artwork setBackgroundImage:[Tools loadImage:@"artwork.png"] forState:UIControlStateNormal];
    bool justloaded = [[NSUserDefaults standardUserDefaults] boolForKey:@"justloaded"];
    if (justloaded == YES) {
        _artwork.enabled = NO;
        [_artwork setBackgroundImage:[UIImage imageNamed: @"artwork.png"] forState:UIControlStateNormal];
    } else {
        _artwork.enabled = YES;
    }
    bool playstatus = [[NSUserDefaults standardUserDefaults] boolForKey:@"isplaying"];
    if (playstatus == YES) {
                [_playpause setBackgroundImage:[UIImage imageNamed: @"pause.png"] forState:UIControlStateNormal];
    } else {
        [_playpause setBackgroundImage:[UIImage imageNamed: @"play.png"] forState:UIControlStateNormal];
    }
   
    
    
    }



-(void)nexttrack{
    
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
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:nextartists[z]]]];
    [Tools saveImage:image withName:@"artwork.png"];
    [[NSUserDefaults standardUserDefaults] setInteger:z forKey:@"nowplaying-number"];
    [self playRemoteFile:nextsongs[z]];
    Class playingInfoCenter = NSClassFromString(@"MPNowPlayingInfoCenter");
    if (playingInfoCenter) {
        
        
        NSMutableDictionary *songInfo = [[NSMutableDictionary alloc] init];
        
        
        //MPMediaItemArtwork *albumArt = [[MPMediaItemArtwork alloc] initWithImage:[Tools loadImage:@"artwork.png"]];
        
        [songInfo setObject:nextsongs[z] forKey:MPMediaItemPropertyTitle];
        [songInfo setObject:nextartists[z] forKey:MPMediaItemPropertyArtist];
        [songInfo setObject:nexttapes[z] forKey:MPMediaItemPropertyAlbumTitle];
        //[songInfo setObject:albumArt forKey:MPMediaItemPropertyArtwork];
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:songInfo];
        
        
    }
    
    
    

}

-(void)playRemoteFile:(NSString*)songname{
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

- (IBAction)playpause:(id)sender {
    bool playstatus = [[NSUserDefaults standardUserDefaults] boolForKey:@"isplaying"];
    if (playstatus == YES) {
        [Tools pauseAudio];
        [_playpause setBackgroundImage:[UIImage imageNamed: @"play.png"] forState:UIControlStateNormal];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isplaying"];
        
    } else {
        [Tools resumeAudio];
        [_playpause setBackgroundImage:[UIImage imageNamed: @"pause.png"] forState:UIControlStateNormal];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isplaying"];
    }
}


-(void)go:(id)sender {

    [self performSegueWithIdentifier:@"player" sender:self.view];
}

-(void)shader:(UIButton*)button{
    button.maskView.layer.cornerRadius = 7.0f;
    button.layer.shadowRadius = 3.0f;
    button.layer.shadowColor = [UIColor blackColor].CGColor;
    button.layer.shadowOffset = CGSizeMake(0.0f, 6.0f);
    button.layer.shadowOpacity = 0.3f;
    button.layer.masksToBounds = NO;
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"player"]){
        MixtapeViewController *controller = (MixtapeViewController *)segue.destinationViewController;
        controller.mixtapename = tapename;
        controller.playlist = -1;
    } else {
        nil;
    }
    
    
}

- (IBAction)last:(id)sender {

}

- (IBAction)shuffle:(id)sender {
    
}

- (IBAction)next:(id)sender {
    [MixtapeViewController nexttrack];
}
@end
