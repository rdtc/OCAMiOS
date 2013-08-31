//
//  DetailViewController.m
//  OCAMClient
//
//  Created by Pablo Cruz on 8/25/13.
//  Copyright (c) 2013 Pablo Cruz. All rights reserved.
//

#import "DetailViewController.h"
#import "HUD.h"
#import "JSONHTTPClient.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden: NO animated:YES];
}
- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem)
    {
        [HUD showUIBlockingIndicator];
        NSMutableString *videoID = [self.detailItem valueForKey:@"videoId"];
        NSMutableString *url = [NSMutableString stringWithString:@"https://www.googleapis.com/youtube/v3/videos?part=snippet,contentDetails,statistics,player&key=AIzaSyBTT4LO4X_w9KF4IBLgD6wWL_G9M-Jxgp0&id="];
        
        [url appendString:videoID];
        
        [JSONHTTPClient getJSONFromURLWithString:url
                                      completion:^(NSDictionary *json, JSONModelError *err) {
                                          
                                          NSArray *items = [json objectForKey:@"items"];
                                          for(NSDictionary *item in items){
                                              NSMutableString *titleDetail = [NSMutableString stringWithString:@"Published at:"];
                                              
                                              NSDictionary *snippet = [item objectForKey:@"snippet"];
                                              [titleDetail appendString:[snippet objectForKey:@"publishedAt"]];
                                              NSDictionary *details = [item objectForKey:@"contentDetails"];
                                              [titleDetail appendString:@" Duration:"];
                                              [titleDetail appendString:[details objectForKey:@"duration"]];
                                              
                                              self.subTitleLabel.text = titleDetail;
                                              self.aboutLabel.text = [snippet objectForKey:@"description"];
                                              
                                              NSDictionary *player =[item objectForKey:@"player"];
                                              
                                              NSMutableString *embedPlayer = [NSMutableString stringWithString:@"<iframe type='text/html' src='https://www.youtube.com/embed/"];
                                              [embedPlayer appendString:videoID];
                                              [embedPlayer appendString:@"?fs=1&modestbranding=1&showinfo=0'"];
                                              [embedPlayer appendString:@"width=300 height=200 frameborder='0'>"];
                                              
                                              NSString *videoUrl = [player objectForKey:@"embedHtml"];
                                              videoUrl = [videoUrl stringByReplacingOccurrencesOfString:@"width='640'" withString:@"width='300'"];
                                              videoUrl =[videoUrl stringByReplacingOccurrencesOfString:@"height='360'" withString:@"height='200'"];
                                              videoUrl=[videoUrl stringByReplacingOccurrencesOfString:@">" withString:@"&modestbranding='1'&showinfo='0'>"];
                                              
                                              [self.webPlayer loadHTMLString:embedPlayer baseURL:nil];
                                              [self.view addSubview:self.webPlayer];
                                          }
                                          
                                          
                                          
                                          [HUD hideUIBlockingIndicator];
                                      }];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
