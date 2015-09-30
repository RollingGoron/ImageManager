//
//  ImageManager.h
//  Tweet Machine
//
//  Created by Peter Gosling on 9/5/15.
//  Copyright (c) 2015 SunfireSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageManager : NSObject

typedef void (^imageManagerBlock) (BOOL success, NSString *error, UIImage *image);


+(ImageManager *)sharedInfo;

-(void)asyncImageView:(NSString *)imageURL withKeyName:(NSString *)key withCompletion:(imageManagerBlock)completionBlock;
-(void)clearCache;


@end
