//
//  MasterViewController.m
//  OCAMClient
//
//  Created by Pablo Cruz on 8/25/13.
//  Copyright (c) 2013 Pablo Cruz. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"
#import "JSONHTTPClient.h"
#import "CustomCell.h"
#import "YoutubeResponse.h"

static NSString *CellIdentifier = @"CustomCell";

@interface MasterViewController (){
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}
-(void)viewWillAppear:(BOOL)animated{
    UIBarButtonItem *logo = [[UIBarButtonItem alloc] initWithCustomView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"OCAMLogo" ]]];
    self.navigationItem.leftBarButtonItem = logo;
    //[self.navigationController setNavigationBarHidden: YES animated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	_objects = [NSMutableArray array];
    
    
    [JSONHTTPClient getJSONFromURLWithString:@"https://www.googleapis.com/youtube/v3/playlistItems?part=contentDetails,snippet&maxResults=50&fields=items(snippet/title,snippet/position,snippet/thumbnails/medium,contentDetails)&playlistId=UUyBGi6r3Qc-agYNLZVb-5kg&key=AIzaSyBTT4LO4X_w9KF4IBLgD6wWL_G9M-Jxgp0"
                                  completion:^(NSDictionary *json, JSONModelError *err) {
                                     
                                      
                                      NSArray *items = [json objectForKey:@"items"];
                                      for(NSDictionary *item in items){
                                          YoutubeResponse *response = [[YoutubeResponse alloc] init];
                                          
                                          NSDictionary *snippet = [item objectForKey:@"snippet"];
                                          NSDictionary *details = [item objectForKey:@"contentDetails"];
                                          
                                          NSString *title = [snippet objectForKey:@"title"];
                                          NSDictionary *thumbnails = [snippet objectForKey:@"thumbnails"];
                                          NSDictionary *thumbnail = [thumbnails objectForKey:@"medium"];
                                          
                                          response.title = title;
                                          response.videoId = [details valueForKey:@"videoId"];
                                          
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              [self.collectionView reloadData];
                                          });
                                          
                                          NSInteger *index = _objects.count;
                                          [_objects insertObject:response atIndex:index];
                                          
                                          dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                                              NSString *urlString = [thumbnail valueForKey:@"url"];
                                              NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  
                                                  response.imageData = imageData;
                                                  [self.collectionView reloadData];

                                              });
                                          });
                                          
                                          
                                      }
                                      
                                      
                                      
                                  }];

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UICollectionView Datasource
// 1
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _objects.count;
}
// 2
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView {
    // _data is a class member variable that contains one array per section.
    return 1;
}
// 3
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CustomCell *cell = (CustomCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    YoutubeResponse *obj = [_objects objectAtIndex:indexPath.row];
  
    [cell setTitle:obj.title];
    [cell setImage:[UIImage imageWithData:obj.imageData]];
    
    return cell;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems] lastObject];
        YoutubeResponse *obj = [_objects objectAtIndex:indexPath.row];
        [[segue destinationViewController] setDetailItem:obj];
    }

    /*
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
  */
}

@end
