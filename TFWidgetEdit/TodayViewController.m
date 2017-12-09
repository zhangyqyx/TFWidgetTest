//
//  TodayViewController.m
//  TFWidgetEdit
//
//  Created by 张永强 on 2017/12/8.
//  Copyright © 2017年 TechFantasy. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "TFTodayViewCell.h"

@interface TodayViewController () <NCWidgetProviding , UICollectionViewDelegate,UICollectionViewDataSource>

/**数据 */
@property (nonatomic , strong)NSArray *datas;


@end

@implementation TodayViewController

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

#define kTodayViewCellKey @"kTodayViewCellKey"

- (NSArray *)datas {
    if (!_datas) {
        _datas = @[@{@"name":@"叶" , @"imageName":@"叶" , @"id":@(2001)},
                   @{@"name":@"灯" , @"imageName":@"灯", @"id":@(2002)},
                   @{@"name":@"果" , @"imageName":@"果", @"id":@(2003)},
                   @{@"name":@"鞋" , @"imageName":@"鞋", @"id":@(2004)},];
    }
    return _datas;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    flowLayout.minimumLineSpacing = 0;
//    flowLayout.minimumInteritemSpacing = 0;
//    flowLayout.itemSize = CGSizeMake((kScreenW - 20)/ 4, 110);
//    flowLayout.sectionInset = UIEdgeInsetsMake(0, -5, 0,10);
//    UICollectionView *collectiuonView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 110) collectionViewLayout:flowLayout];
//    collectiuonView.delegate = self;
//    collectiuonView.dataSource = self;
//    collectiuonView.backgroundColor = [UIColor clearColor];
//    [collectiuonView registerNib:[UINib nibWithNibName:@"TFTodayViewCell" bundle:nil] forCellWithReuseIdentifier:kTodayViewCellKey];
//    [self.view addSubview:collectiuonView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 10.0) {
        self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
        self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width,140);
    }
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    completionHandler(NCUpdateResultNewData);
}

- (UIEdgeInsets) widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets {
    return UIEdgeInsetsZero;
}

- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize {
    if (activeDisplayMode == NCWidgetDisplayModeCompact) {
        self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 110);
        
    }else {
        self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 200);
        [self setupLabel];
    }
}
- (void)setupLabel {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 110, kScreenW, 80)];
    label.text = @"编辑日历";
    label.textColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.datas.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TFTodayViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTodayViewCellKey forIndexPath:indexPath];
    NSDictionary *dic = self.datas[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:dic[@"imageName"]];
    cell.titleLabel.text =  dic[@"name"];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
     NSDictionary *dic = self.datas[indexPath.row];
    NSString *url_Str = [NSString stringWithFormat:@"myWidget://%@",dic[@"id"]];
//     NSString *url_Str = @"myWidget://abc";
    NSURL *url = [NSURL URLWithString:url_Str];
    [self.extensionContext openURL:url completionHandler:^(BOOL success) {

    }];
}
- (IBAction)open:(id)sender {
    NSString *url_Str = @"myWidget://2001";
  NSURL *url = [NSURL URLWithString:url_Str];
    [self.extensionContext openURL:url completionHandler:^(BOOL success) {
        
    }];
}

@end
