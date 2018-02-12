//
//  Movie.h
//  TestMoviesApi
//
//  Created by Kavita Gaitonde on 2/7/18.
//  Copyright © 2018 Kavita Gaitonde. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject <NSCoding, NSCopying>

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *overview;
@property (nonatomic, copy, readonly) NSString *releaseDateString;
@property (nonatomic, copy, readonly) NSNumber *averageVote;
@property (nonatomic, copy, readonly) NSString *posterPath;
@property (nonatomic, assign, readonly) NSInteger voteCount;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;

@end
