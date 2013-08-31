//
//  SearchCell.h
//  OCAMClient
//
//  Created by Pablo Cruz on 8/30/13.
//  Copyright (c) 2013 Pablo Cruz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *thumbnailView;
@property (weak, nonatomic) IBOutlet UILabel *thumbnailTitle;

-(void)setImage:(UIImage *)image;
-(void)setTitle:(NSString *)textValue;
@end
