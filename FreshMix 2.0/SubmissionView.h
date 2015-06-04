//
//  SubmissionView.h
//  Young California
//
//  Created by Rob Crosby on 10/8/14.
//  Copyright (c) 2014 8-Bit Pyramid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubmissionView : UIViewController <UIAlertViewDelegate> {
    NSString *artwork;
    NSInteger which;
}
- (IBAction)cancel:(id)sender;
- (IBAction)submit:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIButton *submit;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *artist;
@property (weak, nonatomic) IBOutlet UITextField *link;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *twitter;
@property (weak, nonatomic) IBOutlet UITextField *facebook;
@property (weak, nonatomic) IBOutlet UITextField *soundcloud;
@property (weak, nonatomic) IBOutlet UITextField *other;
@property (weak, nonatomic) IBOutlet UIButton *artwork;

@end
