//
//  ViewController.m
//  qq下拉菜单
//
//  Created by 简而言之 on 2017/5/9.
//  Copyright © 2017年 jiafa.apple. All rights reserved.
//

#import "ViewController.h"
#import "SectionModel.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *listArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // 假数据
    [self p_setupDataArray];
    [self setupSubViewsLayout];
}

/** 添加下级菜单 */
- (void)setupSubViewsLayout
{
    [self.view addSubview:self.tableView];
    __weak typeof(self) weakSelf = self;
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

#pragma mark ----- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_listArray count];
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SectionModel *sModel = self.listArray[section];
    if (sModel.isSelected == NO) {
        return 0;
    }
    return [sModel.rowArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor blueColor];
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    SectionModel *sModel = self.listArray[section];
    UILabel *headView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    headView.text = sModel.userName;
    headView.backgroundColor = [UIColor greenColor];
    headView.userInteractionEnabled = YES;
    [headView addGestureRecognizer:tapGes];
    headView.tag = section;
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"%@", [[[[self.listArray objectAtIndex:indexPath.section] objectForKey:@"city"] objectAtIndex:indexPath.row] objectForKey:@"name"]);
    
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO animated:YES];
    // 下面方法更好使
//        [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark ----- Method
- (void)tapAction:(UITapGestureRecognizer *)sender
{
    SectionModel *sModel = self.listArray[sender.view.tag];
    if (sModel.isSelected == NO) {
        sModel.isSelected = YES;
    }
    else
    {
        sModel.isSelected = NO;
    }
//    if ([[ objectForKey:@"flag"] isEqualToString:@"NO"]) {
//        [[self.listArray objectAtIndex:sender.view.tag] setObject:@"YES" forKey:@"flag"];
//    } else {
//        [[self.listArray objectAtIndex:sender.view.tag] setObject:@"NO" forKey:@"flag"];
//    }

    NSIndexSet *set = [NSIndexSet indexSetWithIndex:sender.view.tag];
    [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
}

- (void)p_setupDataArray
{
    for (int i = 0; i < 15; i++) {
    SectionModel *sModel = [[SectionModel alloc] init];
    sModel.isSelected = NO;
    sModel.userName = @"分区一";
    rowModel *rModel = [[rowModel alloc] init];
    rModel.userString = @"cell_one";
    rModel.contentString = @"cell_two";
    rowModel *rModel1 = [[rowModel alloc] init];
    rModel1.userString = @"cell_one";
    rModel1.contentString = @"cell_two";
    sModel.rowArray = [NSMutableArray arrayWithArray:@[rModel,rModel1]];
#pragma mark ----- 这里犯了一个严重的错误 数组内放置的元素 都是指向同一个地址的  所以在操作的时候 只要改变一个Model的值 所有的值都会改变 所以在之后运行崩溃  原本我只是改变其中一个section的isSelected状态，但是现在是全部改变了  所以会运行崩溃的 [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
//    self.listArray = [NSMutableArray arrayWithArray:@[sModel,sModel,sModel,sModel,sModel,sModel,sModel,sModel,sModel,sModel,sModel,sModel,sModel,sModel,sModel,sModel]];
    [self.listArray addObject:sModel];
    }
}


#pragma mark ----- Getter
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [UIView new];
        
        // 注册cell
        static NSString *identifier = @"UITableViewCell";
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    }
    return _tableView;
}

- (NSMutableArray *)listArray
{
    if (_listArray == nil) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}
@end
