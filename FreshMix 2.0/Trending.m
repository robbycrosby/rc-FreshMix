//
//  Trending.m
//  FreshMix 2.0
//
//  Created by Robert Crosby on 8/30/14.
//  Copyright (c) 2014 8-Bit Pyramid. All rights reserved.
//

#import "Trending.h"
#import "Tools.h"


@interface Trending ()




@end

@implementation Trending


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
    
    [self.view setBackgroundColor: [UIColor clearColor]];
    [self.view setOpaque: NO];
    trending.contentSize = CGSizeMake(595,158);
    newest.contentSize = CGSizeMake(595,158);
    [Tools tapecount];
    [NSTimer scheduledTimerWithTimeInterval: 0
                                     target: self
                                   selector:@selector(getalltapes)
                                   userInfo: nil repeats:NO];
    
    [super viewDidLoad];
    
    _art1.titleLabel.hidden=YES;
    [_art1 addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
    [_art2 addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
    [_art3 addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
    [_art4 addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
    [_art5 addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
    [_nart1 addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
    [_nart2 addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
    [_nart3 addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
    [_nart4 addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
    [_nart5 addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hide) name:@"HideAFPopup" object:nil];
    // Do any additional setup after loading the view.
    

}






-(void)getalltapes{
    
    
        NSInteger one,two,three,four,five;
        int r1,r2,r3,r4,r5;
        one = [[NSUserDefaults standardUserDefaults]
               integerForKey:@"1"];
        two = [[NSUserDefaults standardUserDefaults]
               integerForKey:@"2"];
        three = [[NSUserDefaults standardUserDefaults]
                 integerForKey:@"3"];
        four = [[NSUserDefaults standardUserDefaults]
                integerForKey:@"4"];
        five = [[NSUserDefaults standardUserDefaults]
                integerForKey:@"5"];
        r1 = (int)one;
        r2 = (int)two;
        r3 = (int)three;
        r4 = (int)four;
        r5 = (int)five;

        [Tools gettapes:r1:_title1:_art1:_name1];
        [Tools gettapes:r2:_title2:_art2:_name2];
        [Tools gettapes:r3:_title3:_art3:_name3];
        [Tools gettapes:r4:_title4:_art4:_name4];
        [Tools gettapes:r5:_title5:_art5:_name5];
        [Tools newreleases:0:_ntitle1 :_nart1:_nname1];
        [Tools newreleases:1:_ntitle2 :_nart2:_nname2];
        [Tools newreleases:2:_ntitle3 :_nart3:_nname3];
        [Tools newreleases:3:_ntitle4 :_nart4:_nname4];
        [Tools newreleases:4:_ntitle5 :_nart5:_nname5];

    
    
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



@end
