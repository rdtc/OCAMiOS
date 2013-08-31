//
//  SearchViewController.h
//  OCAMClient
//
//  Created by Pablo Cruz on 8/29/13.
//  Copyright (c) 2013 Pablo Cruz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
