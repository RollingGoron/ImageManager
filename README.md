# ImageManager

This is a simple image caching class that pulls images from the web and caches them asycnornously.

Import the class:
	#import "ImageManager.h"

Useage:

	[[ImageManager  sharedInfo] asyncImageView:<imageURL> withKeyName:<reference key> withCompletion:^(BOOL success, NSString *errorMessage, UIImage *image) {
        UIImage *webImage = image;
    }];
