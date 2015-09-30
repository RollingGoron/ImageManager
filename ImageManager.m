//
//  ImageManager.m
//  Tweet Machine
//
//  Created by Peter Gosling on 9/5/15.
//  Copyright (c) 2015 SunfireSoft. All rights reserved.
//

#import "ImageManager.h"

static ImageManager *sharedInstance = nil;

@interface ImageManager ()

@property NSCache *imageCache;

@end

@implementation ImageManager

+(instancetype)sharedInfo {
    @synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [[[self class] alloc] init];
        }
        return sharedInstance;
    }
}

-(id)init {
    self = [super init];
    if (self) {
        self.imageCache = [[NSCache alloc] init];
    }
    return self;
}

/*Downloads and caches images*/
-(void)asyncImageView:(NSString *)imageURL withKeyName:(NSString *)key withCompletion:(imageManagerBlock)completionBlock {
    UIImage *cachedImage = [self.imageCache objectForKey:key];
    if (cachedImage == nil) { //Checks for counter in cache
        NSURL *downloadImageURL = [NSURL URLWithString:imageURL];
        NSURLRequest *request = [NSURLRequest requestWithURL:downloadImageURL];
        
        NSURLSession *session = [NSURLSession sharedSession];
        
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            UIImage *returnImage = [UIImage imageWithData:data];
            [self.imageCache setObject:returnImage forKey:key];//Sets the cache with the counter object as the key
            if (completionBlock) {
                completionBlock(YES, nil, returnImage);
            }
        }];
        
        [dataTask resume];
    } else {
        if (completionBlock) {
            completionBlock(YES, nil, cachedImage);
        }
        
    }
    
}


-(void)clearCache {
    [self.imageCache removeAllObjects];
}

@end
