//
//  AGViewController.m
//  YCDB
//
//  Created by 952303557@qq.com on 04/16/2022.
//  Copyright (c) 2022 952303557@qq.com. All rights reserved.
//

#import "AGViewController.h"
#import "DBManager+Sqlite.h"

@interface AGViewController ()

@end

@implementation AGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = UIColor.cyanColor;
    
//    [DBManager shareManager]isExiswithTableName:<#(nonnull NSString *)#> modelClass:<#(nonnull Class)#> where:<#(const WCTCondition &)#>
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
