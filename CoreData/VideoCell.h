//
//  VideoCell.h
//  CoreData
//
//  Created by A589 on 2017/6/16.
//  Copyright © 2017年 A589. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoModel+CoreDataClass.h"

@interface VideoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property(nonatomic,strong)VideoModel *video;
@end
