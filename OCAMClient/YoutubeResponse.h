//
//  YoutubeResponse.h
//  OCAMClient
//
//  Created by Pablo Cruz on 8/25/13.
//  Copyright (c) 2013 Pablo Cruz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YoutubeResponse : NSObject

@property (strong, nonatomic) NSString *videoId;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSNumber *position;
@property (strong, nonatomic) NSData *imageData;
@end
