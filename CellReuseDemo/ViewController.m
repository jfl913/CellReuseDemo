//
//  ViewController.m
//  CellReuseDemo
//
//  Created by jfl913 on 15/3/4.
//  Copyright (c) 2015年 jfl913. All rights reserved.
//

#import "ViewController.h"
#import "TestViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *imageURLStringsArray;
@property (nonatomic, strong) NSURLSession *session;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.imageURLStringsArray = @[@"http://img.hb.aicdn.com/55185392c658c2e1dedd9953a1d904998f155218f81f-BXtJFP_fw658",
                                      @"http://img.hb.aicdn.com/3e5344e306697ee226b2efe82403027b7b3be4ee178dd-c5TNyM_fw658",
                                      @"http://img.hb.aicdn.com/f5a35dd99cdf423b633f33de5cb849007529f1c27b6eb-yY9qDO_fw658",
                                      @"http://img.hb.aicdn.com/817b5a4665f9d0d6b4ddf26a14f4fb16bdc0603e1fbc8a-f1Hhhf_fw658",
                                      @"http://img.hb.aicdn.com/340bd88bc3a91c7c7733ba9b06daadbf685d3b8a28101-EuZcBl_fw658",
                                      @"http://img.hb.aicdn.com/dcacb01048cfb180e2a216bf42f657167177cb7fe0bb-yvnd6I_fw658",
                                      @"http://img.hb.aicdn.com/cb4e9679edf9ebef1d90227f479b4be66399b5efe7f5-yOFHUA_fw658"];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.session = [NSURLSession sessionWithConfiguration:configuration];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.imageURLStringsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TestViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    cell.testImageView.image = nil;
    if (cell.dataTask) {
        [cell.dataTask cancel];
    }
    NSURL *url = [NSURL URLWithString:self.imageURLStringsArray[indexPath.row]];
    cell.dataTask = [self.session dataTaskWithURL:url
                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                  if (!error) {
                                      UIImage *image = [UIImage imageWithData:data];
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          cell.testImageView.image = image;
                                      });
                                  }
    }];
    [cell.dataTask resume];
//    [cell.testImageView sd_setImageWithURL:url];
    
    return cell;
}

@end
