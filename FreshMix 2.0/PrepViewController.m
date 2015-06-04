//
//  PrepViewController.m
//  Young California
//
//  Created by Robert Crosby on 9/22/14.
//  Copyright (c) 2014 8-Bit Pyramid. All rights reserved.
//

#import "PrepViewController.h"

@interface PrepViewController ()

@end

@implementation PrepViewController

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
    
    [self loading];
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


-(void)loading{
    [Tools tapecount];
    NSLog(@"tapes");
    NSMutableArray *mixtapes=[[NSMutableArray alloc]init];
    NSMutableArray *artistarray=[[NSMutableArray alloc]init];
    NSMutableArray *artarray=[[NSMutableArray alloc]init];
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
                [artistarray addObject:mixartist];
                [artarray addObject:mixart];
                [[NSUserDefaults standardUserDefaults] setObject:mixtapes forKey:@"mixtapenames"];
                [[NSUserDefaults standardUserDefaults] setObject:artistarray forKey:@"mixtapeartist"];
                [[NSUserDefaults standardUserDefaults] setObject:artarray forKey:@"mixtapeartwork"];
                if (z == [[NSUserDefaults standardUserDefaults]
                          integerForKey:@"tapes"] -1) {
                    NSLog(@"Done.");
                    NSString * storyboardName = @"Main";
                    
                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
                    
                    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"homescreen"];
                    
                    [self presentViewController:vc animated:YES completion:nil];
                }
            }
        }];
        
    }
    
}


@end
