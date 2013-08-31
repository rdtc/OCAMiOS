//
//  SearchCell.m
//  OCAMClient
//
//  Created by Pablo Cruz on 8/30/13.
//  Copyright (c) 2013 Pablo Cruz. All rights reserved.
//

#import "SearchCell.h"

@implementation SearchCell

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
    [_thumbnailView setImage:image];
}
-(void)setTitle:(NSString *)textValue
{
    _thumbnailTitle.text = textValue;
}

@end
