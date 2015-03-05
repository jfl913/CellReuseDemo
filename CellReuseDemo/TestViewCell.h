//
//  TestViewCell.h
//  CellReuseDemo
//
//  Created by jfl913 on 15/3/4.
//  Copyright (c) 2015年 jfl913. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *testImageView;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

@end
