//
//  Search.m
//  FreshMix 2.0
//
//  Created by Robert Crosby on 8/31/14.
//  Copyright (c) 2014 8-Bit Pyramid. All rights reserved.
//

#import "Search.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "QRCodeReaderViewController.h"
#import "QRCodeReader.h"

@interface Search ()
@property (nonatomic, strong) IBOutlet UIButton *toggleButton;
@property (nonatomic, strong) MixtapeViewController *modalTest;
@property (nonatomic, strong) AFPopupView *popup;


@end

@implementation Search
@synthesize all,artwork,artists,mixtapes,total,sartists,smixtapes,sartwork,search;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

BOOL first = NO;

- (void)viewWillAppear:(BOOL)animated{
    
    mixtapes =[[NSUserDefaults standardUserDefaults]  arrayForKey:@"amixtapes"];
    tape = mixtapes;
    artists =[[NSUserDefaults standardUserDefaults]  arrayForKey:@"aartists"];
    cre = artists;
    artwork =[[NSUserDefaults standardUserDefaults]  arrayForKey:@"aartworks"];
    art = artwork;
}

-(void)viewDidAppear:(BOOL)animated{
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         _collection.frame = CGRectMake(0, 79, 320, 489);
                         _bg.frame = CGRectMake(0, 0, 320, 80);
                         
                         
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:0.2
                                               delay:0.0
                                             options: UIViewAnimationOptionCurveEaseInOut
                                          animations:^{
                                              
                                              _search_button.frame = CGRectMake(35, 32, 26, 28);
                                              _close.frame = CGRectMake(27, 25, 43, 43);
                                              search.frame = CGRectMake(70, 25, 187, 43);
                                              _shadow.frame = CGRectMake(27, 25, 267, 43);
                                              _qr.frame = CGRectMake(257, 25, 46, 43);
                                              
                                          }
                                          completion:^(BOOL finished){
                                          }];
                     }];
}

- (void)viewDidLoad
{
    
    /*
    bool screen = [[NSUserDefaults standardUserDefaults] boolForKey:@"is3.5"];
    if (screen == YES) {
        [_table setFrame:CGRectMake(0, 97, 320, 383)];
        
    }
     */
    [self shader:_shadow];
    [self shader:_bg];
    //[self shader:_close];
    mixtapes =[[NSUserDefaults standardUserDefaults]  arrayForKey:@"amixtapes"];
    
    artists =[[NSUserDefaults standardUserDefaults]  arrayForKey:@"aartists"];
    artwork =[[NSUserDefaults standardUserDefaults]  arrayForKey:@"aartworks"];
    self.search.delegate = self;
    //UIImage *temp = [UIImage imageNamed:@"1712836.jpg"];
    //UIImage *newIma=[temp stackBlur:30];
    //_bg.image = newIma;
    
        
        
    [super viewDidLoad];
    _collection.backgroundColor = [UIColor clearColor];
    _collection.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    search.autocorrectionType = UITextAutocorrectionTypeNo;
    // Do any additional setup after loading the view.
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    //[_table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                  //atScrollPosition:UITableViewScrollPositionTop animated:YES];
    textField.text = nil;
}

- (UIStatusBarStyle)preferredStatusBarStyle{

    return UIStatusBarStyleLightContent;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return mixtapes.count;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    if (textField == self.search) {
        for (int x =0; x<mixtapes.count; x++) {
            if ([mixtapes[x] rangeOfString:textField.text options:NSCaseInsensitiveSearch].location != NSNotFound) {
                
                [_collection scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:x inSection:0]
                              atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
                [textField resignFirstResponder];
                
            } else if ([artists[x] rangeOfString:textField.text options:NSCaseInsensitiveSearch].location != NSNotFound){
                [_collection scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:x inSection:0]
                              atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
                [textField resignFirstResponder];
                }
                
             else {
                NSLog(@"No Match %d",x);
                 [textField resignFirstResponder];
                   }

        }

        
        return NO;
        
    }
    textField.text = @"Sorry. No Results";
    return YES;

}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"ArchiveCell";
    
    ArchiveCell *cell = (ArchiveCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ArchiveCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.art setImageWithURL:[NSURL URLWithString:artwork[indexPath.row]] placeholderImage:[UIImage imageNamed:@"artwork.png"]];
    //cell.art.image = [Tools loadImage:[mixtapes objectAtIndex:indexPath.row]];
    //LEColorPicker *colorPicker = [[LEColorPicker alloc] init];
    //LEColorScheme *colorScheme = [colorPicker colorSchemeFromImage:cell.art.image];
    //self.view.backgroundColor = [colorScheme backgroundColor];
    //[colorScheme backgroundColor];
    //cell.backing.backgroundColor = [colorScheme primaryTextColor];
    //[colorScheme primaryTextColor];
    //[colorScheme secondaryTextColor];
    cell.mixtape.text = [mixtapes objectAtIndex:indexPath.row];
    cell.artist.text = [artists objectAtIndex:indexPath.row];
    cell.textLabel.hidden = YES;
    cell.textLabel.text = [mixtapes objectAtIndex:indexPath.row];
    //cell.mixtape.textColor = [colorScheme secondaryTextColor];
    //cell.artist.textColor = [colorScheme secondaryTextColor];
    
    return cell;
}
*/
-(void)shader:(UITextField*)button{
    button.maskView.layer.cornerRadius = 7.0f;
    button.layer.shadowRadius = 3.0f;
    button.layer.shadowColor = [UIColor blackColor].CGColor;
    button.layer.shadowOffset = CGSizeMake(0.0f, 6.0f);
    button.layer.shadowOpacity = 0.3f;
    button.layer.masksToBounds = NO;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 381;
}

- (IBAction)scanAction:(id)sender
{
    if ([QRCodeReader supportsMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]]) {
        static QRCodeReaderViewController *reader = nil;
        static dispatch_once_t onceToken;
        
        dispatch_once(&onceToken, ^{
            reader                        = [QRCodeReaderViewController new];
            reader.modalPresentationStyle = UIModalPresentationFormSheet;
        });
        reader.delegate = self;
        
        [reader setCompletionWithBlock:^(NSString *resultAsString) {
            NSLog(@"Completion with result: %@", resultAsString);
        }];
        
        [self presentViewController:reader animated:YES completion:NULL];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Reader not supported by the current device" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }
}

#pragma mark - QRCodeReader Delegate Methods

- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
{
    [self dismissViewControllerAnimated:YES completion:^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        // Configure for text only and offset down
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"Loading...";
        hud.margin = 20.f;
        hud.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.50];
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        name = result;
        
        [self performSegueWithIdentifier:@"player" sender:self.view];
        [hud hide:YES afterDelay:2.0f];
            }];
}

- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:@"Mixtapes"];
    
    // If no objects are loaded in memory, we look to the cache
    // first to fill the table and then subsequently do a query
    // against the network.

    
    [query orderByDescending:@"createdAt"];
    
    return query;
}
/*
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    name = cell.textLabel.text;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     [self performSegueWithIdentifier:@"player" sender:self.view];
}
*/

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
   
    if([segue.identifier isEqualToString:@"player"]){
        MixtapeViewController *controller = (MixtapeViewController *)segue.destinationViewController;
        controller.mixtapename = name;
        controller.playlist = -1;
    }
}

- (void) collectionview:(UICollectionView *)tableView willDisplayCell:(UICollectionViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.isDragging) {
        UIView *myView = cell.contentView;
        CALayer *layer = myView.layer;
        CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
        rotationAndPerspectiveTransform.m34 = 1.0 / -1000;
        if (scrollOrientation == UIImageOrientationDown) {
            rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, M_PI*0.5, 1.0f, 0.0f, 0.0f);
        } else {
            rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, -M_PI*0.5, 1.0f, 0.0f, 0.0f);
        }
        layer.transform = rotationAndPerspectiveTransform;
        [UIView animateWithDuration:.5 animations:^{
            layer.transform = CATransform3DIdentity;
        }];
    }
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    scrollOrientation = scrollView.contentOffset.y > lastPos.y?UIImageOrientationDown:UIImageOrientationUp;
    lastPos = scrollView.contentOffset;
}

/*
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //1. Setup the CATransform3D structure
    CATransform3D rotation;
    rotation = CATransform3DMakeRotation( 0, 0.0, 0, 0);
    rotation.m34 = 0/ 0;
    
    
    //2. Define the initial state (Before the animation)
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    
    cell.layer.transform = rotation;
    cell.layer.anchorPoint = CGPointMake(0, 0.5);
    
    
    //3. Define the final state (After the animation) and commit the animation
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:0.3];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
    
}
*/
/*
-(void)loading{
    NSLog(@"tapes");
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        // Do something...
        
    for (int z; z<[[NSUserDefaults standardUserDefaults]
                   integerForKey:@"tapes"]; z++) {
        PFQuery *query = [PFQuery queryWithClassName:@"Mixtapes"];
        [query orderByAscending:@"Artist"];
        [query setSkip:z];
        [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            if (!object) {
                NSLog(@"Woops.");
            } else {
                
                // The find succeeded.
                NSString *mixname = object[@"Mixtape"];
                NSLog(mixname);
                NSString *mixartist = object[@"Artist"];
                NSString *mixart = object[@"Art"];
                //UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:mixart]]];
                //[Tools saveImage:image withName:[NSString stringWithFormat:@"%@.png",mixname]];
                
                [mixtapes addObject:mixname];
                [artists addObject:mixartist];
                [artwork addObject:mixart];
                [UIView transitionWithView:_table
                                  duration:0.5f
                                   options:UIViewAnimationCurveEaseInOut
                                animations:^(void) {
                                    [_table reloadData];
                                } completion:NULL];
                if (z == [[NSUserDefaults standardUserDefaults]
                          integerForKey:@"tapes"] / 2) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                    });
                    
                }
            }
        }];
        
    }
        
    });
    
}*/


-(void)viewDidDisappear:(BOOL)animated{
    mixtapes = nil;
    artists = nil;
    artwork = nil;
}



- (IBAction)cancel:(id)sender {
    [UIView animateWithDuration:0.2
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         _search_button.frame = CGRectMake(35, -500, 26, 28);
                         _close.frame = CGRectMake(27, -500, 43, 43);
                         _qr.frame = CGRectMake(257, -500, 46, 43);
                         search.frame = CGRectMake(70, -500, 224, 43);
                         _shadow.frame = CGRectMake(27, -500, 267, 43);
                         _collection.frame = CGRectMake(0, 900, 320, 489);
                         _bg.frame = CGRectMake(0, -500, 320, 80);
                         
                         [self dismissViewControllerAnimated:YES completion:nil];
                     }
                     completion:^(BOOL finished){
                         
                     }];
}

- (IBAction)saved:(id)sender {
    
  
    
   
}


-(void)loadall{
    PFQuery *query = [PFQuery queryWithClassName:@"Mixtapes"];
    [query orderByAscending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *allobjects, NSError *error) {
        // iterate through the objects array, which contains PFObjects for each Student
        
        for (int i = 0; i < allobjects.count; i++) {
            
            PFObject *object = [allobjects objectAtIndex:i];
            NSString *mixtapename = [object objectForKey:@"Mixtape"];
            NSString *mixtapecreator = [object objectForKey:@"Artist"];
            NSString *mixtapeart = [object objectForKey:@"Art"];
            NSLog(mixtapename);
            [tape addObject:mixtapename];
            [cre addObject:mixtapecreator];
            [art addObject:mixtapeart];
                    }}];
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return mixtapes.count;
}

-(NSInteger ) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
        UILabel *mixtape = (UILabel *)[cell viewWithTag:1];
    UIButton *mixtapenamebutton = (UIButton *)[cell viewWithTag:5];
    UILabel *artist = (UILabel *)[cell viewWithTag:2];
    UILabel *bg = (UILabel *)[cell viewWithTag:4];
    UIImageView *mixtart = (UIImageView *)[cell viewWithTag:3];
    mixtape.text = mixtapes[indexPath.row];
    artist.text = [artists objectAtIndex:indexPath.row];
    [self cellshader:bg];
    [mixtapenamebutton setTitle:mixtapes[indexPath.row] forState:UIControlStateNormal];
    [mixtart setImageWithURL:[NSURL URLWithString:artwork[indexPath.row]] placeholderImage:[UIImage imageNamed:@"artwork.png"]];

    
    return cell;
}

-(void)cellshader:(UILabel*)button{
    button.maskView.layer.cornerRadius = 4.0f;
    button.layer.shadowRadius = 2.0f;
    button.layer.shadowColor = [UIColor blackColor].CGColor;
    button.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    button.layer.shadowOpacity = 0.3f;
    button.layer.masksToBounds = NO;
}
- (IBAction)opentape:(id)sender {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"Loading...";
    hud.margin = 20.f;
    hud.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.50];
    hud.yOffset = 150.f;
    hud.removeFromSuperViewOnHide = YES;
    UIButton *button = (UIButton*)sender;
    name = button.titleLabel.text;
    
    [self performSegueWithIdentifier:@"player" sender:self.view];
    [hud hide:YES afterDelay:2.0f];
}
@end
