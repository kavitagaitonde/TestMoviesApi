//
//  MoviesManager.m
//  TestMoviesApi
//
//  Created by Kavita Gaitonde on 2/6/18.
//  Copyright © 2018 Kavita Gaitonde. All rights reserved.
//

#import "MoviesManager.h"
#import "Movie.h"

/*static NSString* nowPlayingUrl = @"https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed";
NSString* const smallImageBaseUrl = @"http://image.tmdb.org/t/p/w45";
NSString* const largeImageBaseUrl = @"http://image.tmdb.org/t/p/w300";
*/

@interface MoviesManager()

@property(strong, nonatomic) NSString* smallImageBaseUrl ;
@property(strong, nonatomic) NSString* largeImageBaseUrl ;
@property(strong, nonatomic) NSString* nowPlayingUrl;

@end

@implementation MoviesManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static MoviesManager *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"movieresources" ofType:@"plist"];
        if (bundlePath) {
            NSDictionary* configDict = [NSDictionary dictionaryWithContentsOfFile:bundlePath];
            if (configDict) {
                sharedInstance = [[MoviesManager alloc] init];
                sharedInstance.nowPlayingUrl = [configDict objectForKey:@"nowPlayingUrl"];
                sharedInstance.smallImageBaseUrl = [configDict objectForKey:@"smallImageBaseUrl"];
                sharedInstance.largeImageBaseUrl = [configDict objectForKey:@"largeImageBaseUrl"];
            } else {
                NSLog(@"Missing configuration in movieresources configuration file.");
            }
        } else {
            NSLog(@"Cannot find movieresources configuration file.");
        }
    });
    return sharedInstance;
}


- (void)getNowPlayingMovies:(void (^)(NSError *error, NSArray *results))completionBlock {
    NSURL *url = [NSURL URLWithString:self.nowPlayingUrl];
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completionBlock(error, nil);
        } else {
            NSError *e;
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&e];
            NSLog(@"json: %@", json);
            NSMutableArray *array = [NSMutableArray array];
            for (NSDictionary *movie in [json objectForKey:@"results"]) {
                Movie *m = [[Movie alloc] initWithDictionary:movie];
                [array addObject:m];
            }
            completionBlock(nil, array);
        }
    }];
    [task resume];
}

- (void)downloadImageForPath:(NSString *)path completionBlock:(void (^)(NSError *error, NSData *data))completionBlock {
    NSString *imageUrl = [NSString stringWithFormat:@"%@%@", self.smallImageBaseUrl, path];
    NSURL *url = [NSURL URLWithString:imageUrl];
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completionBlock(error, nil);
        } else {
            completionBlock(nil, data);
        }
    }];
    [task resume];
}

- (void)downloadLargeImageForPath:(NSString *)path completionBlock:(void (^)(NSError *error, NSData *data))completionBlock {
    NSString *imageUrl = [NSString stringWithFormat:@"%@%@", self.largeImageBaseUrl, path];
    NSURL *url = [NSURL URLWithString:imageUrl];
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completionBlock(error, nil);
        } else {
            completionBlock(nil, data);
        }
    }];
    [task resume];
}


@end
