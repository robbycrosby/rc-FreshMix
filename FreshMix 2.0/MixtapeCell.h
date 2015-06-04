//
//  MixtapeCell.h
//  FreshMix 2.0
//
//  Created by Robert Crosby on 8/31/14.
//  Copyright (c) 2014 8-Bit Pyramid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MixtapeCell : UITableViewCell <UIActionSheetDelegate>

@property (nonatomic, weak) IBOutlet UILabel *songname;
- (IBAction)favorite:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *favorite;




@end
