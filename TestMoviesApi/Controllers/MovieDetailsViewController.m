//
//  MovieDetailsViewController.m
//  TestMoviesApi
//
//  Created by Kavita Gaitonde on 2/8/18.
//  Copyright © 2018 Kavita Gaitonde. All rights reserved.
//

#import "MovieDetailsViewController.h"
#import "MoviesManager.h"

@interface MovieDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *overviewLabel;
@property (weak, nonatomic) IBOutlet UILabel *voteLabel;

@end

@implementation MovieDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (!self.movie) {
        NSLog(@"No movie selected");
        return;
    }
    [[MoviesManager sharedInstance] downloadLargeImageForPath:self.movie.posterPath completionBlock:^(NSError *error, NSData *data) {
        if (data) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImage *image = [UIImage imageWithData:data];
                self.imageView.image = image;
            });
        }
    }];
    self.titleLabel.text = self.movie.title;
    self.overviewLabel.text = self.movie.overview;
    self.voteLabel.text = [self.movie.averageVote stringValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
