//
//  Movie.m
//  TestMoviesApi
//
//  Created by Kavita Gaitonde on 2/7/18.
//  Copyright © 2018 Kavita Gaitonde. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (instancetype)initWithDictionary:(NSDictionary*)dictionary {
    self = [super init];
    if (self) {
        _title = [dictionary objectForKey:@"title"];
        _overview = [dictionary objectForKey:@"overview"];
        _releaseDateString = [dictionary objectForKey:@"release_date"];
        _posterPath = [dictionary objectForKey:@"poster_path"];
        _averageVote = [dictionary objectForKey:@"vote_average"];
        _voteCount = [[dictionary objectForKey:@"vote_count"] intValue];
    }
    return self;
}

#pragma NSCoding
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _title = [aDecoder decodeObjectForKey:@"title"];
        _overview = [aDecoder decodeObjectForKey:@"overview"];
        _releaseDateString = [aDecoder decodeObjectForKey:@"releaseDateString"];
        _posterPath = [aDecoder decodeObjectForKey:@"posterPath"];
        _averageVote = [aDecoder decodeObjectForKey:@"averageVote"];
        _voteCount = [[aDecoder decodeObjectForKey:@"voteCount"] intValue];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.title forKey:@"overview"];
    [aCoder encodeObject:self.releaseDateString forKey:@"releaseDateString"];
    [aCoder encodeObject:self.posterPath forKey:@"posterPath"];
    [aCoder encodeObject:self.averageVote forKey:@"averageVote"];
    [aCoder encodeObject:@(self.voteCount) forKey:@"voteCount"];
    
}

#pragma NSCopying
- (instancetype) copyWithZone:(NSZone *)zone {
    //since the movie object is immutable, its ok to return self.
    return self;
}

@end
