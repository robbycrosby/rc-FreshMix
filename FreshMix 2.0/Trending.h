//
//  Trending.h
//  FreshMix 2.0
//
//  Created by Robert Crosby on 8/30/14.
//  Copyright (c) 2014 8-Bit Pyramid. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "UIImage+StackBlur.h"
#import "Player.h"
#import "AFPopupView.h"
#import "MixtapeViewController.h"
#import "AppDelegate.h"


@interface Trending : UIViewController {
    int tapes;
    IBOutlet UIScrollView *newest;
    IBOutlet UIScrollView *trending;
    UIColor *back,*primary,*secondary;
}


// Artwork Buttons
@property (strong, nonatomic) IBOutlet UIButton *art1;
@property (strong, nonatomic) IBOutlet UIButton *art2;
@property (strong, nonatomic) IBOutlet UIButton *art3;
@property (strong, nonatomic) IBOutlet UIButton *art4;
@property (strong, nonatomic) IBOutlet UIButton *art5;

// Trending Artists
@property (strong, nonatomic) IBOutlet UILabel *name1;
@property (strong, nonatomic) IBOutlet UILabel *name2;
@property (strong, nonatomic) IBOutlet UILabel *name3;
@property (strong, nonatomic) IBOutlet UILabel *name4;
@property (strong, nonatomic) IBOutlet UILabel *name5;

// Latest Artists
@property (strong, nonatomic) IBOutlet UILabel *nname1;
@property (strong, nonatomic) IBOutlet UILabel *nname2;
@property (strong, nonatomic) IBOutlet UILabel *nname3;
@property (strong, nonatomic) IBOutlet UILabel *nname4;
@property (strong, nonatomic) IBOutlet UILabel *nname5;

// Newest Buttons
@property (strong, nonatomic) IBOutlet UIButton *nart1;
@property (strong, nonatomic) IBOutlet UIButton *nart2;
@property (strong, nonatomic) IBOutlet UIButton *nart3;
@property (strong, nonatomic) IBOutlet UIButton *nart4;
@property (strong, nonatomic) IBOutlet UIButton *nart5;

// Titles
@property (strong, nonatomic) IBOutlet UILabel *title1;
@property (strong, nonatomic) IBOutlet UILabel *title2;
@property (strong, nonatomic) IBOutlet UILabel *title3;
@property (strong, nonatomic) IBOutlet UILabel *title4;
@property (strong, nonatomic) IBOutlet UILabel *title5;

// Newest Titles
@property (strong, nonatomic) IBOutlet UILabel *ntitle1;
@property (strong, nonatomic) IBOutlet UILabel *ntitle2;
@property (strong, nonatomic) IBOutlet UILabel *ntitle3;
@property (strong, nonatomic) IBOutlet UILabel *ntitle4;
@property (strong, nonatomic) IBOutlet UILabel *ntitle5;

// Other

-(void)hide;



@end
