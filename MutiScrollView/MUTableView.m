//
//  MUTableView.m
//  MutiScrollView
//
//  Created by zhuchao on 15/3/4.
//  Copyright (c) 2015年 zhuchao. All rights reserved.
//

#import "MUTableView.h"
@interface MUTableView()<UITableViewDelegate,UITableViewDataSource>

@end


@implementation MUTableView

-(instancetype)init{
    self = [super init];
    if(self){
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = [UIColor clearColor];
        self.showsVerticalScrollIndicator = NO;
        
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return self;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = @"test";
    cell.backgroundColor = [UIColor blueColor];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}


@end
