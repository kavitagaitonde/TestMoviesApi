//
//  MoviesManager.h
//  TestMoviesApi
//
//  Created by Kavita Gaitonde on 2/6/18.
//  Copyright © 2018 Kavita Gaitonde. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoviesManager : NSObject

+ (instancetype) sharedInstance;
- (void)getNowPlayingMovies:(void (^)(NSError *error, NSArray *results))completionBlock;
- (void)downloadImageForPath:(NSString *)path completionBlock:(void (^)(NSError *error,  NSData *data))completionBlock;
- (void)downloadLargeImageForPath:(NSString *)path completionBlock:(void (^)(NSError *error, NSData *data))completionBlock;
- (void)getVideoInfoFor:(NSString *)movieId completionBlock:(void (^)(NSError *error, NSDictionary *result))completionBlock;
@end
