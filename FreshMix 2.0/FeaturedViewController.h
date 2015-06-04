//
//  FeaturedViewController.h
//  FreshMix 2.0
//
//  Created by Robert Crosby on 9/18/14.
//  Copyright (c) 2014 8-Bit Pyramid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tools.h"
#import "MixtapeViewController.h"
#import "UIImage+animatedGIF.h"
#import <QuartzCore/CoreAnimation.h>
#import "QRCodeReaderDelegate.h"


@interface FeaturedViewController : UIViewController {
    NSString *name;
    NSString *name1,*name2,*name3,*name4;

}
@property (weak, nonatomic) IBOutlet UIImageView *preparinggif;

@property (weak, nonatomic) IBOutlet UIImageView *preparingback;
@property (strong, nonatomic) IBOutlet UIButton *oneart;

@property (strong, nonatomic) IBOutlet UIButton *twoart;
@property (strong, nonatomic) IBOutlet UIButton *threeart;
@property (strong, nonatomic) IBOutlet UIButton *fourart;
@property (strong, nonatomic) IBOutlet UILabel *oneartist;
@property (strong, nonatomic) IBOutlet UILabel *twoartist;
@property (strong, nonatomic) IBOutlet UILabel *threeartist;
@property (strong, nonatomic) IBOutlet UILabel *fourartist;

@end
