//
//  ListenCell.m
//  FreshMix 2.0
//
//  Created by Robert Crosby on 9/11/14.
//  Copyright (c) 2014 8-Bit Pyramid. All rights reserved.
//

#import "ListenCell.h"

@implementation ListenCell
@synthesize songart = _songart;
@synthesize songmake = _songmake;
@synthesize songname = _songname;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
