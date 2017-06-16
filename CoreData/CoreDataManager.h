//
//  CoreDataManager.h
//  test
//
//  Created by A589 on 2017/6/15.
//  Copyright © 2017年 A589. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "VideoModel+CoreDataClass.h"
@interface CoreDataManager : NSObject

@property(nonatomic,strong)NSManagedObjectContext *managedObjectContext;
@property(nonatomic,strong)NSManagedObjectModel *managedIbjectModel;
@property(nonatomic,strong)NSPersistentStoreCoordinator *persistentStoreCoordinator;

+(instancetype)manager;
-(void)saveContext;
//增加
-(void)insertVideoWith:(NSDictionary *)dic;
//取
-(NSArray*)getVideo;
//删除
-(void)DelegateVideoWith:(VideoModel *)video;
//修改
-(void)UpdataVideo:(VideoModel *)video;
-(void)UpdataVideo:(NSString *)ID With:(NSDictionary *)dic;
@end
