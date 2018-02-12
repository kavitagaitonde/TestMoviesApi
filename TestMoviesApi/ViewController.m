//
//  ViewController.m
//  TestMoviesApi
//
//  Created by Kavita Gaitonde on 1/31/18.
//  Copyright © 2018 Kavita Gaitonde. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//UITableViewDataSource delegate methods



- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Movies header";
}



- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return @"Movies footer";
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}



- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" /*forIndexPath:indexPath*/];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.imageView.backgroundColor = [UIColor blueColor];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %ld", indexPath.row];
    cell.imageView.image = nil; // or cell.imageView.image = [UIImage imageNamed:@"placeholder.png"];
    
    CGSize itemSize = CGSizeMake(40, 40);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    NSURL *url;
    //SYNC
    /*url = [NSURL URLWithString: @"http://myurl/mypic.jpg"];
    NSData * imageData = [[NSData alloc] initWithContentsOfURL:url];
    cell.imageView.image = [UIImage imageWithData: imageData];
    */
    
    
    //ASYNC #1
    url = [NSURL URLWithString: @"http://pngimg.com/upload_small/apple/apple_PNG12507.png"];
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    //check to make sure if the cell for this indexpath exists and only update if it does.
                    UITableViewCell *updateCell = (id)[tableView cellForRowAtIndexPath:indexPath];
                    if (updateCell) {
                        updateCell.imageView.image = image;
                        //[self.tableView reloadData];
                    }
                    //cell.imageView.image = image;
                });
            }
        } else if (error) {
            NSLog(@"Error - %@", [error description]);
        }
    }];
    [task resume];
    
    
    
    //ASYNC #2
    /*dispatch_async(dispatch_get_global_queue(0,0), ^{
        
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: @"http://myurl/mypic.jpg"]];
        
        if ( data == nil )
            
            return;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // WARNING: is the cell still using the same data by this point??
            
            cell.imageView.image = [UIImage imageWithData: data];
            
        });
    });*/
    
    return cell;
    
}



@end
