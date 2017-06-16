//
//  EditVideoController.m
//  CoreData
//
//  Created by A589 on 2017/6/16.
//  Copyright © 2017年 A589. All rights reserved.
//

#import "EditVideoController.h"
#import "CoreDataManager.h"

@interface EditVideoController ()
@property (weak, nonatomic) IBOutlet UITextField *titleTF;
@property (weak, nonatomic) IBOutlet UITextField *urlTF;
@property (weak, nonatomic) IBOutlet UITextField *imgTF;
- (IBAction)sureBtnClick:(UIButton *)sender;

@end

@implementation EditVideoController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.video) {
        self.titleTF.text = self.video.title;
        self.imgTF.text = self.video.img;
        self.urlTF.text = self.video.url;
    }
}


- (IBAction)sureBtnClick:(UIButton *)sender {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"url"] = self.urlTF.text;
    dic[@"img"] = self.imgTF.text;
    dic[@"title"] = self.titleTF.text;
    if (self.video) {
        dic[@"createDate"] = self.video.createDate;
        dic[@"id"] = self.video.id;
        [[CoreDataManager manager] UpdataVideo:self.video.id With:dic];
    }else{
        dic[@"createDate"] = [self getDate];
        dic[@"id"] = [self getID];
        [[CoreDataManager manager] insertVideoWith:dic];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updataTable" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(NSString *)getDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [dateFormatter stringFromDate:[NSDate date]];
}
-(NSString *)getID{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyyMMddHHmmss";
    return [dateFormatter stringFromDate:[NSDate date]];
}
@end
