//
//  ViewController.m
//  CoreData
//
//  Created by A589 on 2017/6/16.
//  Copyright © 2017年 A589. All rights reserved.
//

#import "ViewController.h"
#import "VideoModel+CoreDataClass.h"
#import "VideoCell.h"
#import "CoreDataManager.h"
#import "EditVideoController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;
- (IBAction)addVideoBtnClick:(id)sender;
@property(nonatomic,strong)NSArray *dataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [[CoreDataManager manager] getVideo];
    self.table.delegate = self;
    self.table.dataSource = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updataTable) name:@"updataTable" object:nil];
    NSLog(@"111111");
}
-(void)updataTable{
    self.dataSource = [[CoreDataManager manager] getVideo];
    [self.table reloadData];
}

#pragma mark -- UITableViewDelegateAndDataSource;
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VideoCell"];
    cell.video = self.dataSource[indexPath.row];
    return cell;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"222");
    VideoModel *video = self.dataSource[indexPath.row];
    [[CoreDataManager manager] DelegateVideoWith:video];
    self.dataSource = [[CoreDataManager manager] getVideo];
    [self.table reloadData];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    VideoModel *video = self.dataSource[indexPath.row];
    EditVideoController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"EditVideoController"];
    vc.video = video;
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)addVideoBtnClick:(id)sender {
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"EditVideoController"] animated:YES];
}
@end
