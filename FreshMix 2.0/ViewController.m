//
//  ViewController.m
//  FreshMix 2.0
//
//  Created by Robert Crosby on 8/30/14.
//  Copyright (c) 2014 8-Bit Pyramid. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+StackBlur.h"

@interface ViewController ()

@end

@implementation ViewController



-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if([title isEqual: @"Rate on the App Store"])
    {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=904521602&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8"]];
    }
  
    
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void)viewDidAppear:(BOOL)animated{
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _infobutton.hidden = NO;
                         _menucontrols.hidden = NO;
                         _search.hidden = NO;
                         _header_background.hidden = NO;
                         _header.hidden = NO;
                         _infobutton.frame = CGRectMake(288, 66, 22, 22);
                         _menucontrols.frame = CGRectMake(47, 63, 226, 29);
                         _search.frame = CGRectMake(9, 63, 29, 29);
                         _header.frame = CGRectMake(0, 20, 320, 36);
                         _header_background.frame = CGRectMake(0, 0, 320, 97);
                         panels.frame = CGRectMake(0, 97, 320, 412);
                         player.frame = CGRectMake(0, 508, 320, 60);
                     }
                     completion:^(BOOL finished){
                     }];
}

-(void) viewWillDisappear:(BOOL)animated{
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _infobutton.hidden = YES;
                         _menucontrols.hidden = YES;
                         _search.hidden = YES;
                         _header_background.hidden = YES;
                         _header.hidden = YES;
    _infobutton.frame = CGRectMake(288, -100, 22, 22);
    _menucontrols.frame = CGRectMake(47, -100, 226, 29);
    _search.frame = CGRectMake(9, -100, 29, 29);
    _header.frame = CGRectMake(0, -100, 320, 36);
    _header_background.frame = CGRectMake(0, -100, 320, 97);
    panels.frame = CGRectMake(0, 600, 320, 412);
    player.frame = CGRectMake(0, 600, 320, 60);
    
                     }
                     completion:^(BOOL finished){
                     }];
}
- (void)viewDidLoad
{
    _infobutton.hidden = YES;
    _menucontrols.hidden = YES;
    _search.hidden = YES;
    _header_background.hidden = YES;
    _header.hidden = YES;
    
    [self shaderhead:_header_background];
    NSInteger runs = [[NSUserDefaults standardUserDefaults] integerForKey:@"opened"];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"done"];
    if (runs == 15) {
        UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"You seem to be liking FreshMix!" delegate:self cancelButtonTitle:@"No Thanks" destructiveButtonTitle:nil otherButtonTitles:
                                @"Rate on the App Store",

                                nil];
        [popup showInView:self.view];


    }
    
     [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"loadingcomplete"];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    UIImage* mygif = [UIImage animatedImageWithAnimatedGIFURL:[NSURL URLWithString:@"http://www.brainpecks.com/wp-content/uploads/2014/02/sun.gif"]];
    _pregif.image = mygif;

    [self getplaylists];
    [self getalltapes];
    bool screen = [[NSUserDefaults standardUserDefaults] boolForKey:@"is3.5"];
    if (screen == YES) {
        [player setFrame:CGRectMake(0, 420, 320, 60)];
        [trending setFrame:CGRectMake(trending.frame.origin.x, trending.frame.origin.y - 30, 320,158)];
        [newest setFrame:CGRectMake(newest.frame.origin.x, newest.frame.origin.y - 70,320,158)];
        
        player.backgroundColor = [UIColor whiteColor];
    }
    [panels setContentSize:CGSizeMake(960, 412)];
    _featured.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    
    [ipad_random setContentSize:CGSizeMake(1141, 271)];
    [ipad_newest setContentSize:CGSizeMake(1141, 271)];
    trending.contentSize = CGSizeMake(595,158);
    newest.contentSize = CGSizeMake(595,158);
    scroll35.contentSize = CGSizeMake(320,412);

    
    
    
    //[_search setTitle:@"     Search..." forState:UIControlStateNormal];
    [super viewDidLoad];
    
    
    _art1.titleLabel.hidden=YES;
    [self shader:_art1];
    [self shader:_art2];
    [self shader:_art3];
    [self shader:_art4];
    [self shader:_art5];
    [self shader:_nart1];
    [self shader:_nart2];
    [self shader:_nart4];
    [self shader:_nart5];
    [self shader:_nart6];
    [_art1 addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
    [_art2 addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
    [_art3 addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
    [_art4 addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
    [_art5 addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
    [_nart1 addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
    [_nart2 addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
    [_nart4 addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
    [_nart5 addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
    [_nart6 addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];

    // Do any additional setup after loading the view.
    
    
}



-(void)shaderhead:(UILabel*)button{
    button.maskView.layer.cornerRadius = 7.0f;
    button.layer.shadowRadius = 3.0f;
    button.layer.shadowColor = [UIColor blackColor].CGColor;
    button.layer.shadowOffset = CGSizeMake(0.0f, 6.0f);
    button.layer.shadowOpacity = 0.3f;
    button.layer.masksToBounds = NO;
}

-(void)shader:(UIButton*)button{
    button.maskView.layer.cornerRadius = 7.0f;
    button.layer.shadowRadius = 3.0f;
    button.layer.shadowColor = [UIColor blackColor].CGColor;
    button.layer.shadowOffset = CGSizeMake(0.0f, 3.0f);
    button.layer.shadowOpacity = 0.3f;
    button.layer.masksToBounds = NO;
}



-(void)getplaylists{
    NSString *currentuser = [[NSUserDefaults standardUserDefaults] objectForKey:@"current"];
    PFQuery *query = [PFQuery queryWithClassName:@"UserData"];
    [query whereKey:@"username" equalTo:currentuser];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (!object) {
            
        } else {
            NSArray *sizes;
            // The find succeeded.
            sizes = object[@"p0"];
            zero = sizes.count;
            sizes = object[@"p1"];
            one = sizes.count;
            sizes = object[@"p2"];
            two = sizes.count;
            sizes = object[@"p3"];
            three = sizes.count;
            sizes = object[@"p4"];
            four = sizes.count;
            sizes = object[@"p5"];
            five = sizes.count;
            sizes = object[@"p6"];
            six = sizes.count;
            sizes = object[@"p7"];
            seven = sizes.count;
            sizes = object[@"p8"];
            eight = sizes.count;
            sizes = object[@"p9"];
            nine = sizes.count;
            playlists = object[@"playlists"];
            [_table reloadData];
            if (playlists.count < 1) {
                _uhoh.hidden = NO;
            }
        }     }];
}


-(void)getalltapes{
    
    
    NSInteger one1,two1,three1,four1,five1;
    int r1,r2,r3,r4,r5;
    one1 = [[NSUserDefaults standardUserDefaults]
           integerForKey:@"1"];
    two1 = [[NSUserDefaults standardUserDefaults]
           integerForKey:@"2"];
    three1 = [[NSUserDefaults standardUserDefaults]
             integerForKey:@"3"];
    four1 = [[NSUserDefaults standardUserDefaults]
            integerForKey:@"4"];
    five1 = [[NSUserDefaults standardUserDefaults]
            integerForKey:@"5"];
    r1 = (int)one1;
    r2 = (int)two1;
    r3 = (int)three1;
    r4 = (int)four1;
    r5 = (int)five1;
    
    [Tools gettapes:r1:_title1:_art1:_name1];
    [Tools gettapes:r2:_title2:_art2:_name2];
    [Tools gettapes:r3:_title3:_art3:_name3];
    [Tools gettapes:r4:_title4:_art4:_name4];
    [Tools gettapes:r5:_title5:_art5:_name5];
    [Tools newreleases:0:_ntitle1 :_nart1:_nname1];
    [Tools newreleases:1:_ntitle2 :_nart2:_nname2];
    [Tools newreleases:2:_ntitle3 :_nart4:_nname3];
    [Tools newreleases:3:_ntitle4 :_nart5:_nname4];
    [Tools newreleases:4:_ntitle5 :_nart6:_nname5];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)go:(id)sender {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"Loading...";
    hud.margin = 20.f;
    hud.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.50];
    hud.yOffset = 150.f;
    hud.removeFromSuperViewOnHide = YES;
    
    
    UIButton *button = (UIButton *)sender;
    NSString *buttonTitle = button.titleLabel.text;
    name = buttonTitle;
    [self performSegueWithIdentifier:@"player" sender:self.view];
    [hud hide:YES afterDelay:2];
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"player"]){
        MixtapeViewController *controller = (MixtapeViewController *)segue.destinationViewController;
        controller.mixtapename = name;
        controller.playlist = -1;
    }
    if([segue.identifier isEqualToString:@"playlist"]){
        MixtapeViewController *controller = (MixtapeViewController *)segue.destinationViewController;
        controller.playlist = playlistselection;
    }

    
}







/*
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

*/


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (playlists.count > 0) {
        _uhoh.hidden = YES;
    }
    return playlists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"CollectionCell";
    
    CollectionCell *cell = (CollectionCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CollectionCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.plistname.text = playlists[indexPath.row];
    cell.plistname.textColor = [UIColor blackColor];
    if (indexPath.row == 0) {
        cell.plistsize.text = [NSString stringWithFormat:@"%ld Songs",(long)zero];
    }
    if (indexPath.row == 1) {
        cell.plistsize.text = [NSString stringWithFormat:@"%ld Songs",(long)one];
    }
    if (indexPath.row == 2) {
        cell.plistsize.text = [NSString stringWithFormat:@"%ld Songs",(long)two];
    }
    if (indexPath.row == 3) {
        cell.plistsize.text = [NSString stringWithFormat:@"%ld Songs",(long)three];
    }
    if (indexPath.row == 4) {
        cell.plistsize.text = [NSString stringWithFormat:@"%ld Songs",(long)four];
    }
    if (indexPath.row == 5) {
        cell.plistsize.text = [NSString stringWithFormat:@"%ld Songs",(long)five];
    }
    if (indexPath.row == 6) {
        cell.plistsize.text = [NSString stringWithFormat:@"%ld Songs",(long)six];
    }
    if (indexPath.row == 7) {
        cell.plistsize.text = [NSString stringWithFormat:@"%ld Songs",(long)seven];
    }
    if (indexPath.row == 8) {
        cell.plistsize.text = [NSString stringWithFormat:@"%ld Songs",(long)eight];
    }
    if (indexPath.row == 9) {
        cell.plistsize.text = [NSString stringWithFormat:@"%ld Songs",(long)nine];
    }
    cell.plistsize.textColor = [UIColor grayColor];
    cell.backgroundColor = [[UIColor whiteColor]
                            colorWithAlphaComponent:0.30f];
    
    // Configure the cell...
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 91;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    playlistselection = indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"playlist" sender:self.view];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        
        [playlists removeObjectAtIndex:indexPath.row];
        for (int x; x<[playlists count]; x++) {
            NSLog(playlists[x]);
        }
        NSArray *newp = playlists;
        NSString *currentuser = [[NSUserDefaults standardUserDefaults] objectForKey:@"current"];
        PFQuery *query = [PFQuery queryWithClassName:@"UserData"];
        [query whereKey:@"username" equalTo:currentuser];
        [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            if (!object) {
                
            } else {
                [object removeObjectForKey:[NSString stringWithFormat:@"p%ld",indexPath.row]];
                [object removeObjectForKey:[NSString stringWithFormat:@"p%ldart",indexPath.row]];
                [object removeObjectForKey:[NSString stringWithFormat:@"p%ldcreator",indexPath.row]];
                [object removeObjectForKey:[NSString stringWithFormat:@"p%ldtape",indexPath.row]];
                object[@"playlists"] = newp;
                [object save];
                [_table reloadData];
                
            }     }];

        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    } 
}



- (IBAction)collection:(id)sender {
    _featured.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    _collection.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    _home.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [panels setContentOffset:CGPointMake(640, 0) animated:YES];
    [self getplaylists];
}

- (IBAction)home:(id)sender {
    _featured.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    _collection.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    _home.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
   [panels setContentOffset:CGPointMake(320, 0) animated:YES];
}

- (IBAction)details:(id)sender {
    UIAlertView *myAlert = [[UIAlertView alloc]
                            initWithTitle:@"FreshMx"
                            message:@"Copyright© 2014 FreshMix\n\nCreated by Robert Crosby and John Fournier\n"
                            delegate:self
                            cancelButtonTitle:@"Ok"
                            otherButtonTitles:@"Rate Us",@"Feedback",@"Refresh",@"Sign Out",nil];
    [myAlert show];
    
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    // the user clicked OK
    NSString *button = [alertView buttonTitleAtIndex:buttonIndex];
    if ([button isEqualToString:@"Rate Us"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=904521602&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8"]];
    }
    
    if ([button isEqualToString:@"Sign Out"]) {
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"current"];
        [PFUser logOut];
        [self performSegueWithIdentifier:@"signout" sender:self];
    }
    if ([button isEqualToString:@"Feedback"]) {
        if ([MFMailComposeViewController canSendMail]) {
            
            MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
            mailViewController.mailComposeDelegate = self;
            [mailViewController setToRecipients:@[@"robthecros@gmail.com"]];
            [mailViewController setSubject:@"FreshMix Support"];
            
            [self presentModalViewController:mailViewController animated:YES];
            
            
        }
        
        else {
            
            NSLog(@"Device is unable to send email in its current state.");
            
        }

    }
    if ([button isEqualToString:@"Refresh"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"refresh"];
        [self performSegueWithIdentifier:@"signout" sender:self];
    }
    }


- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)featured:(id)sender {
    _featured.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    _collection.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    _home.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [panels setContentOffset:CGPointMake(0, 0) animated:YES];
}
- (IBAction)controlbar:(id)sender {
    UISegmentedControl *seg = (UISegmentedControl*)sender;
    if (seg.selectedSegmentIndex == 0) {
        
        [panels setContentOffset:CGPointMake(0, 0) animated:YES];
    } else if (seg.selectedSegmentIndex == 1) {
        [panels setContentOffset:CGPointMake(320, 0) animated:YES];
    } else {
        [panels setContentOffset:CGPointMake(640, 0) animated:YES];
    }
}


@end
