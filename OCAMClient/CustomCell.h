//
//  CustomCell.h
//  OCAMClient
//
//  Created by Pablo Cruz on 8/25/13.
//  Copyright (c) 2013 Pablo Cruz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UICollectionViewCell
{
    __weak IBOutlet UIImageView *thumbnailView;
    
    __weak IBOutlet UILabel *thumbnailTitle;
        
}
-(void)setImage:(UIImage *)image;
-(void)setTitle:(NSString *)textValue;
@end