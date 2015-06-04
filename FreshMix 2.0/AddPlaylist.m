//
//  AddPlaylist.m
//  FreshMix 2.0
//
//  Created by Robert Crosby on 9/1/14.
//  Copyright (c) 2014 8-Bit Pyramid. All rights reserved.
//

#import "AddPlaylist.h"

@interface AddPlaylist ()

@end

@implementation AddPlaylist

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [playlists addObject:@"Favorites"];
    [playlists addObject:@"TrapStep"];
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)newplaylist:(id)sender {
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [playlists count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"PlaylistCell";
    
    PlaylistCell *cell = (PlaylistCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PlaylistCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSString *string = playlists[indexPath.row];
    cell.name.text = string;
    NSArray *size = [[NSUserDefaults standardUserDefaults] arrayForKey:[playlists objectAtIndex:indexPath.row]];
    if (size.count == 1) {
        cell.info.text = [NSString stringWithFormat:@"%lu track",(unsigned long)size.count];
    } else {
        cell.info.text = [NSString stringWithFormat:@"%lu tracks",(unsigned long)size.count];
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 83;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
