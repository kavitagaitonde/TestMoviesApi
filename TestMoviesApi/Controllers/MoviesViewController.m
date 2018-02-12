//
//  MoviesViewController.m
//  TestMoviesApi
//
//  Created by Kavita Gaitonde on 2/6/18.
//  Copyright © 2018 Kavita Gaitonde. All rights reserved.
//

#import "MoviesViewController.h"
#import "MoviesManager.h"
#import "MovieDetailsViewController.h"
#import <UIImageView+AFNetworking.h>
#import "Movie.h"
#import "MovieTableViewCell.h"

@interface MoviesViewController ()

@property (strong, nonatomic) NSArray* movies;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.movies = [NSMutableArray array];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    UIRefreshControl* refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(loadData) forControlEvents:UIControlEventValueChanged];
    self.tableView.refreshControl = refreshControl;
    [self setupTableview];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"showMovieDetails"]) {
        UITableViewCell *cell = (UITableViewCell*)sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        MovieDetailsViewController *vc = (MovieDetailsViewController*)segue.destinationViewController;
        vc.movie = [self.movies objectAtIndex:indexPath.row];
    }
}


- (void)setupTableview {
    UILabel *labelView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    labelView.text = @"Now playing";
    labelView.textAlignment = NSTextAlignmentCenter;
    labelView.backgroundColor = [UIColor lightGrayColor];
    self.tableView.tableHeaderView = labelView;
}

- (void)loadData {
    [[MoviesManager sharedInstance] getNowPlayingMovies:^(NSError *error, NSArray *results) {
        if (error) {
            //error
            self.movies = @[];
        } else {
            self.movies = results;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView.refreshControl endRefreshing];
            [self.tableView reloadData];
        });
        
    }];
}



// UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.movies count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    if (!cell) {
        cell = [[MovieTableViewCell alloc] init];
    }
    Movie *movie = [self.movies objectAtIndex:indexPath.row];
    [cell setupCellForMovie:movie];
    
    /*cell.textLabel.text = [movie title];
    cell.detailTextLabel.text  = [ movie overview];
    NSString *imageUrl = [NSString stringWithFormat:@"%@%@", [[MoviesManager sharedInstance] largeImageBaseUrl], [movie posterPath]];
    __weak UITableViewCell *weakCell = cell;
    [cell.imageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
            weakCell.imageView.image = image;
            [weakCell setNeedsLayout];
        } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
           //error
        }];
    //});*/
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

// UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
