//
//  AddPlaylist.h
//  FreshMix 2.0
//
//  Created by Robert Crosby on 9/1/14.
//  Copyright (c) 2014 8-Bit Pyramid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaylistCell.h"

@interface AddPlaylist : UIViewController <UITableViewDataSource,UITableViewDelegate> {
    NSMutableArray *playlists;
}
@property (strong, nonatomic) IBOutlet UITableView *table;
- (IBAction)newplaylist:(id)sender;

@end
