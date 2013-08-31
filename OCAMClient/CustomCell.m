//
//  CustomCell.m
//  OCAMClient
//
//  Created by Pablo Cruz on 8/25/13.
//  Copyright (c) 2013 Pablo Cruz. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setImage:(UIImage *)image
{
    [thumbnailView setImage:image];
}
-(void)setTitle:(NSString *)textValue
{
    thumbnailTitle.text = textValue;
}

@end
