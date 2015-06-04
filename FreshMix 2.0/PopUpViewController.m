//
//  PopUpViewController.m
//  NMPopUpView
//
//  Created by Nikos Maounis on 9/12/13.
//  Copyright (c) 2013 Nikos Maounis. All rights reserved.
//

#import "PopUpViewController.h"

@interface PopUpViewController ()

@end

@implementation PopUpViewController
@synthesize mixtapelabel,songs;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    mixtapelabel.text = self.title;
    _mixtapename = self.title;
    self.view.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:.6];
    self.popUpView.layer.cornerRadius = 5;
    self.popUpView.layer.shadowOpacity = 0.8;
    self.popUpView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    
    //[self findtape:mixtapelabel.text];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)showAnimate
{
    self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.view.alpha = 0;
    [UIView animateWithDuration:.25 animations:^{
        self.view.alpha = 1;
        self.view.transform = CGAffineTransformMakeScale(1, 1);
    }];
    
}

- (IBAction)closePopup:(id)sender {
    [self removeAnimate];
}

-(void)findtape:(NSString*)find{
    PFQuery *query = [PFQuery queryWithClassName:@"Mixtapes"];
    [query whereKey:@"Mixtape" equalTo:find];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (!object) {
            NSLog(@"The getFirstObject request failed.");
        } else {
            // The find succeeded.
            _artist.text = object[@"Artist"];
            songs = object[@"Songs"];
            _artwork.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:object[@"Art"]]]];
            _artwork.hidden = NO;
            [UIView animateWithDuration:0.3
                                  delay:0.0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{ _artwork.alpha = 1; _artist.alpha = 1; _table.alpha = 1; mixtapelabel.alpha = 1;}
                             completion:^(BOOL finished){}
             ];
            
            [_table reloadData];
        }
    }];
    
}


- (void)removeAnimate
{
    [UIView animateWithDuration:.25 animations:^{
        self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.view removeFromSuperview];
        }
    }];
}

- (void)showInView:(UIView *)aView withImage:(UIImage *)image withMessage:(NSString *)message animated:(BOOL)animated
{
    dispatch_async(dispatch_get_main_queue(), ^{
    [aView addSubview:self.view];
    self.logoImg.image = image;
    self.mixtapelabel.text = message;
    if (animated) {
        [self showAnimate];
    }
    });
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [songs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"MixtapeCell";
    
    MixtapeCell *cell = (MixtapeCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MixtapeCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.songname.text = [songs objectAtIndex:indexPath.row];
    [cell.favorite addTarget:self action:@selector(go) forControlEvents:UIControlEventTouchUpInside];
    //cell.songname.textColor = primary;
    //cell.favorite.tintColor = primary;
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 57;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)go{
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"addsong"];
    [super presentViewController:vc animated:YES completion:nil];
}
@end
