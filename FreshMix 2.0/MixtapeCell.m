//
//  MixtapeCell.m
//  FreshMix 2.0
//
//  Created by Robert Crosby on 8/31/14.
//  Copyright (c) 2014 8-Bit Pyramid. All rights reserved.
//

#import "MixtapeCell.h"

@implementation MixtapeCell
@synthesize songname = _nameLabel;



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

- (IBAction)favorite:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:_nameLabel.text forKey:@"selection"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)shadow:(UIButton*)button{
    button.maskView.layer.cornerRadius = 7.0f;
    button.layer.shadowRadius = 1.5f;
    button.layer.shadowColor = [UIColor blackColor].CGColor;
    button.layer.shadowOffset = CGSizeMake(0.0f, 3.0f);
    button.layer.shadowOpacity = 0.3f;
    button.layer.masksToBounds = NO;
}
@end
