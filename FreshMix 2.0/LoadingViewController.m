//
//  LoadingViewController.m
//  Young California
//
//  Created by Robert Crosby on 9/18/14.
//  Copyright (c) 2014 8-Bit Pyramid. All rights reserved.
//

#import "LoadingViewController.h"

@interface LoadingViewController ()

@end

@implementation LoadingViewController

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
    
    
    [super viewDidLoad];
    [Tools tapecount];
    [Tools index];
    
    [NSTimer scheduledTimerWithTimeInterval:0.1
                                     target:self
                                   selector:@selector(nextscene)
                                   userInfo:nil
                                    repeats:YES];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)nextscene{
    BOOL done = [[NSUserDefaults standardUserDefaults] boolForKey:@"doneloading"];
    if (done == YES) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"doneloading"];
        [self performSegueWithIdentifier:@"done" sender:self.view];
    } else {
        nil;
    }
    
}
@end
