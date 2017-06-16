//
//  VideoCell.m
//  CoreData
//
//  Created by A589 on 2017/6/16.
//  Copyright © 2017年 A589. All rights reserved.
//

#import "VideoCell.h"
#import "UIImageView+WebCache.h"

@implementation VideoCell

-(void)setVideo:(VideoModel *)video{
    _video = video;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:video.img]];
    NSLog(@"%@",video.img);
    self.titleLabel.text = video.title;
    self.dateLabel.text = video.createDate;
}

@end
