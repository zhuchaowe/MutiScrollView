//
//  ViewController.m
//  MutiScrollView
//
//  Created by zhuchao on 15/3/4.
//  Copyright (c) 2015年 zhuchao. All rights reserved.
//

#import "ViewController.h"
#import "MUTableView.h"
#import "HMSegmentedControl.h"

@interface ViewController ()<UIScrollViewDelegate>
@property(nonatomic,retain)SceneScrollView *scrollView;
@property(nonatomic,retain)MUTableView *tableView1;
@property(nonatomic,retain)MUTableView *tableView2;
@property(nonatomic,retain)HMSegmentedControl *segmentedControl;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _scrollView = [[SceneScrollView alloc]init];
    _scrollView.backgroundColor = [UIColor redColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    [self.scrollView addHorizontalContentView];
    
    [self.scrollView horizontalAlignTopWithToView:self.scrollView.superview predicate:@"0"];
    [self.scrollView horizontalAlignBottomWithToView:self.scrollView.superview predicate:@"0"];
    [self.scrollView alignLeading:@"0" trailing:@"0" toView:self.scrollView.superview];

    _tableView1 = [[MUTableView alloc]init];
    _tableView1.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
    [self.scrollView.contentView addSubview:_tableView1];
    [_tableView1 constrainWidthToView:self.scrollView.superview predicate:@"0"];
    [_tableView1 alignTop:@"64" bottom:@"0" toView:_tableView1.superview];
    [_tableView1 alignLeadingEdgeWithView:_tableView1.superview predicate:@"0"];
//    [self.scrollView addHorizontalSubView:_tableView1 atIndex:0];

    
    _tableView2 = [[MUTableView alloc]init];
    _tableView2.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
    [self.scrollView.contentView addSubview:_tableView2];
    [_tableView2 constrainWidthToView:self.scrollView.superview predicate:@"0"];
    [_tableView2 alignTop:@"64" bottom:@"0" toView:_tableView2.superview];
    [_tableView2 alignLeadingEdgeWithView:_tableView2.superview predicate:@"320"];
    
    
    [self.scrollView endWithHorizontalView:_tableView2];
    
    @weakify(self);
    [[RACObserve(self.tableView1, contentOffset)
     filter:^BOOL(id value) {
         @strongify(self);
         return !CGPointEqualToPoint(self.tableView1.contentOffset, self.tableView2.contentOffset);
     }]
     subscribeNext:^(id x) {
         @strongify(self);
         self.tableView2.contentOffset = self.tableView1.contentOffset;
    }];
    
    [[RACObserve(self.tableView2, contentOffset)
      filter:^BOOL(id value) {
          @strongify(self);
          return !CGPointEqualToPoint(self.tableView1.contentOffset, self.tableView2.contentOffset);
      }]
     subscribeNext:^(id x) {
         @strongify(self);
         self.tableView1.contentOffset = self.tableView2.contentOffset;
     }];
    
    self.segmentedControl = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 40)];
    self.segmentedControl.sectionTitles = @[@"tab1", @"tab2"];
    self.segmentedControl.selectedSegmentIndex = 0;
    self.segmentedControl.backgroundColor = [UIColor yellowColor];
    self.segmentedControl.textColor = [UIColor blackColor];
    self.segmentedControl.selectedTextColor = [UIColor blackColor];
    self.segmentedControl.selectionIndicatorColor = [UIColor colorWithString:@"#f06292"];
//    self.segmentedControl.font = [UIFont fontWithName:XinGothic size:17.0f];
    self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;

    
    [self.segmentedControl setIndexChangeBlock:^(NSInteger index) {
        @strongify(self);
        [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.width * index, 0, self.scrollView.width, self.scrollView.height) animated:YES];
    }];
    [self.view addSubview:self.segmentedControl];
    
    [[RACObserve(self.tableView1, contentOffset)
     filter:^BOOL(id value) {
         @strongify(self);
         return self.tableView1.contentOffset.y<0;
     }]
    subscribeNext:^(id x) {
        @strongify(self);
        CGRect frame = self.segmentedControl.frame;
        frame.origin.y = -self.tableView1.contentOffset.y - 40 +64;
        self.segmentedControl.frame = frame;
    }];
    
    [self.tableView1 setContentOffset:CGPointMake(0, -self.tableView1.contentInset.top) animated:NO];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger index = scrollView.contentOffset.x / pageWidth;
    [self.segmentedControl setSelectedSegmentIndex:index animated:YES];
}

@end
