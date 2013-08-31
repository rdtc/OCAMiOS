//
//  SearchViewController.m
//  OCAMClient
//
//  Created by Pablo Cruz on 8/29/13.
//  Copyright (c) 2013 Pablo Cruz. All rights reserved.
//

#import "SearchViewController.h"
#import "HUD.h"
#import "SearchCell.h"
#import "JSONHTTPClient.h"
#import "YoutubeResponse.h"

static NSString *CellIdentifier = @"SearchCell";
@interface SearchViewController () <UISearchBarDelegate>{
    NSMutableArray *_objects;
}

@end

@implementation SearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    UIBarButtonItem *logo = [[UIBarButtonItem alloc] initWithCustomView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"OCAMLogo" ]]];
    self.navigationItem.leftBarButtonItem = logo;
    //[self.navigationController setNavigationBarHidden: YES animated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _objects = [NSMutableArray array];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)searchBarSearchButtonClicked:(UISearchBar*)searchBar{

    [searchBar resignFirstResponder];
     _objects = [NSMutableArray array];
    
    NSMutableString *query =[NSMutableString stringWithString: [ searchBar.text stringByReplacingOccurrencesOfString:@" " withString:@"+"]];
    NSMutableString *url = [NSMutableString stringWithString:@"https://www.googleapis.com/youtube/v3/search?part=snippet&channelId=UCyBGi6r3Qc-agYNLZVb-5kg&maxResults=25&order=relevance&key=AIzaSyBTT4LO4X_w9KF4IBLgD6wWL_G9M-Jxgp0&q="];
    
    [url appendString:query];
    [JSONHTTPClient getJSONFromURLWithString:url
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
    SearchCell *cell = (SearchCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    YoutubeResponse *obj = [_objects objectAtIndex:indexPath.row];
    
    [cell setTitle:obj.title];
    [cell setImage:[UIImage imageWithData:obj.imageData]];
    
    return cell;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    /*
    if ([[segue identifier] isEqualToString:@"showSearchDetail"]) {
        NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems] lastObject];
        YoutubeResponse *obj = [_objects objectAtIndex:indexPath.row];
        [[segue destinationViewController] setDetailItem:obj];
    }
     */
    
}


@end
