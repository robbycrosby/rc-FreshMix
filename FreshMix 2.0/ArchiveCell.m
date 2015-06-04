//
//  ArchiveCell.m
//  FreshMix 2.0
//
//  Created by Robert Crosby on 9/1/14.
//  Copyright (c) 2014 8-Bit Pyramid. All rights reserved.
//

#import "ArchiveCell.h"

@implementation ArchiveCell
@synthesize art = _art;
@synthesize mixtape = _mixtape;
@synthesize artist = _artist;
@synthesize backing = _backing;

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
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:Nil];
    _modalTest = [storyboard instantiateViewControllerWithIdentifier:@"album"];

    [_load addTarget:self action:@selector(go) forControlEvents:UIControlEventTouchUpInside];
    [self shader:_backing];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hide) name:@"HideAFPopup" object:nil];
}

-(void)shader:(UILabel*)button{
    button.maskView.layer.cornerRadius = 4.0f;
    button.layer.shadowRadius = 2.0f;
    button.layer.shadowColor = [UIColor blackColor].CGColor;
    button.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    button.layer.shadowOpacity = 0.3f;
    button.layer.masksToBounds = NO;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    if (highlighted) {
        _backing.alpha = 0.5;
    } else {
        _backing.alpha = 1.0;
    }
}



-(void)go{
    
    
    
    
    _modalTest.mixtapelabel.text = _mixtape.text;
    _modalTest.load = YES;
    [_popup show];
    
}

-(void)hide {
    
    [_popup hide];
}

@end
