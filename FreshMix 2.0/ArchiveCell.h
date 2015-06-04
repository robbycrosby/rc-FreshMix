//
//  ArchiveCell.h
//  FreshMix 2.0
//
//  Created by Robert Crosby on 9/1/14.
//  Copyright (c) 2014 8-Bit Pyramid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MixtapeViewController.h"
#import "AFPopupView.h"

@interface ArchiveCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *art;
@property (strong, nonatomic) IBOutlet UILabel *mixtape;
@property (strong, nonatomic) IBOutlet UILabel *artist;
@property (strong, nonatomic) IBOutlet UIButton *load;
-(void)hide;
@property (weak, nonatomic) IBOutlet UILabel *backing;
@property (nonatomic, strong) IBOutlet UIButton *toggleButton;
@property (nonatomic, strong) MixtapeViewController *modalTest;
@property (nonatomic, strong) AFPopupView *popup;
@end
