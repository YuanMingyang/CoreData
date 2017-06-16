//
//  VideoModel+CoreDataProperties.h
//  CoreData
//
//  Created by A589 on 2017/6/16.
//  Copyright © 2017年 A589. All rights reserved.
//

#import "VideoModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface VideoModel (CoreDataProperties)

+ (NSFetchRequest<VideoModel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *url;
@property (nullable, nonatomic, copy) NSString *createDate;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *id;
@property (nullable, nonatomic, copy) NSString *img;

@end

NS_ASSUME_NONNULL_END
