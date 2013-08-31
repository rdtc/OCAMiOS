//
//  MasterViewController.h
//  OCAMClient
//
//  Created by Pablo Cruz on 8/25/13.
//  Copyright (c) 2013 Pablo Cruz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasterViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@end
