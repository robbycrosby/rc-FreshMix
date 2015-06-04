//
//  Search.h
//  FreshMix 2.0
//
//  Created by Robert Crosby on 8/31/14.
//  Copyright (c) 2014 8-Bit Pyramid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+StackBlur.h"
#import "Tools.h"
#import <Parse/Parse.h>
#import "ArchiveCell.h"
#import "AFPopupView.h"
#import "MixtapeViewController.h"
#import "MBProgressHUD.h"
#import <QuartzCore/QuartzCore.h>
#import "QRCodeReaderDelegate.h"

@interface Search : UIViewController <QRCodeReaderDelegate,UITextFieldDelegate,UICollectionViewDataSource,UICollectionViewDelegate> {
    NSString *name;
    BOOL saved;
    int max,min,stop;
    NSMutableArray *savetape,*saveart,*savecre;
    NSMutableArray *tape,*art,*cre;
    PFObject *current;
    UIImageOrientation scrollOrientation;
    CGPoint lastPos;
}
- (IBAction)scanAction:(id)sender;
- (IBAction)opentape:(id)sender;
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (weak, nonatomic) IBOutlet UILabel *bg;
@property (strong, nonatomic) IBOutlet UITextField *search;

//@property (strong, nonatomic) IBOutlet UIImageView *bg;
@property(nonatomic) NSArray *all;
@property(nonatomic) NSArray *mixtapes;
@property(nonatomic) NSArray *artwork;
@property(nonatomic) NSArray *artists;

@property(nonatomic) NSMutableArray *smixtapes;
@property(nonatomic) NSMutableArray *sartwork;
@property(nonatomic) NSMutableArray *sartists;
@property(nonatomic) int total;
@property (strong, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIButton *qr;

// Other
- (IBAction)cancel:(id)sender;
- (IBAction)saved:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *saved;
@property (weak, nonatomic) IBOutlet UILabel *close;
@property (weak, nonatomic) IBOutlet UILabel *shadow;

@property (weak, nonatomic) IBOutlet UIButton *search_button;


@end
