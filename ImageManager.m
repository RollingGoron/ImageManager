//
//  ImageManager.m
//  Tweet Machine
//
//  Created by Peter Gosling on 9/5/15.
//  Copyright (c) 2015 SunfireSoft. All rights reserved.
//

#import "ImageManager.h"

static ImageManager *sharedInstance = nil;
static UIImage *imageToReturn = nil;

@interface ImageManager ()

@property NSCache *imageCache;

@end

@implementation ImageManager

+(ImageManager *)sharedInfo {
    @synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [[[self class] alloc] init];
        }
        return sharedInstance;
    }
}

-(id)init {
    self.imageCache = [[NSCache alloc] init];
    return self;
}

/*Downloads and caches images*/
-(void)asyncImageView:(NSString *)imageURL withKeyName:(NSString *)key withCompletion:(imageManagerBlock)completionBlock {
    if ([self.imageCache objectForKey:key] == nil) { //Checks for counter in cache
        NSURL *downloadImageURL = [NSURL URLWithString:imageURL];
        NSURLRequest *request = [NSURLRequest requestWithURL:downloadImageURL];
        
        NSURLSession *session = [NSURLSession sharedSession];
        
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            UIImage *returnImage = [UIImage imageWithData:data];
            
            //NSCache *imageCache = [[NSCache alloc] init];
            [self.imageCache setObject:returnImage forKey:key];//Sets the cache with the counter object as the key
            UIImage *image = [self.imageCache objectForKey:key];

            if (completionBlock) {
                completionBlock(YES, nil, image);
            }

            
        }];
        
        [dataTask resume];
    } else {
        UIImage *image = [self.imageCache objectForKey:key];
        if (completionBlock) {
            completionBlock(YES, nil, image);
        }

    }
    
}


-(void)clearCache {
    [self.imageCache removeAllObjects];
}

@end
