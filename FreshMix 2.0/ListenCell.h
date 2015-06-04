//
//  ListenCell.h
//  FreshMix 2.0
//
//  Created by Robert Crosby on 9/11/14.
//  Copyright (c) 2014 8-Bit Pyramid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListenCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *songname;
@property (strong, nonatomic) IBOutlet UIImageView *songart;
@property (strong, nonatomic) IBOutlet UILabel *songmake;

@end
