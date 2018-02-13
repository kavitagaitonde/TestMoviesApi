//
//  MovieCellTableViewCell.m
//  TestMoviesApi
//
//  Created by Kavita Gaitonde on 2/11/18.
//  Copyright © 2018 Kavita Gaitonde. All rights reserved.
//

#import "MovieTableViewCell.h"
#import "MoviesManager.h"

@implementation MovieTableViewCell

- (instancetype)init {
    self = [super init];
    if (self) {
        _movie = nil;
    }
    return self;
}

- (void)setupCell {
    if (!_movie) {
        return;
    }
    _title.text = _movie.title;
    _overview.text = _movie.overview;
    
    [[MoviesManager sharedInstance] downloadImageForPath:_movie.posterPath completionBlock:^(NSError *error, NSData *data) {
        if (data) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImage *image = [UIImage imageWithData:data];
                _movieImageView.image = image;
            });
        }
    }];
    
    if (_movie.videoId) {
        NSString *urlString = [NSString stringWithFormat:@"https://www.youtube.com/watch?v=%@", _movie.videoId];
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [_movieWebView loadRequest:request];
    }
    
    
    if (UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])) {
        [_movieWebView setHidden:NO];
        [_movieImageView setHidden:YES];
    } else {
        [_movieWebView setHidden:YES];
        [_movieImageView setHidden:NO];
    }
    /*
     NSString *imageUrl = [NSString stringWithFormat:@"%@%@", self.smallImageBaseUrl, path];
     __weak MovieTableViewCell *weakSelf = self;
     [self.movieImageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
     weakSelf.movieImageView.image = image;
     //[weakSelf setNeedsLayout];
     } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
     //error
     }];*/
}

- (void)setupCellForMovie:(Movie *)movie {
    _movie = movie;
    [self setupCell];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupCell];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
