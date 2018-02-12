//
//  MovieCellTableViewCell.h
//  TestMoviesApi
//
//  Created by Kavita Gaitonde on 2/11/18.
//  Copyright © 2018 Kavita Gaitonde. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface MovieTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *movieImageView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *overview;
@property (strong, nonatomic) Movie *movie;

- (void)setupCellForMovie:(Movie *)movie;
- (void)setupCell;


@end
