//
//  VideoModel+CoreDataProperties.m
//  CoreData
//
//  Created by A589 on 2017/6/16.
//  Copyright © 2017年 A589. All rights reserved.
//

#import "VideoModel+CoreDataProperties.h"

@implementation VideoModel (CoreDataProperties)

+ (NSFetchRequest<VideoModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"VideoModel"];
}

@dynamic url;
@dynamic createDate;
@dynamic title;
@dynamic id;
@dynamic img;

@end
