//
//  CoreDataManager.m
//  test
//
//  Created by A589 on 2017/6/15.
//  Copyright © 2017年 A589. All rights reserved.
//

#import "CoreDataManager.h"


@implementation CoreDataManager
static CoreDataManager *manager = nil;
+(instancetype)manager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CoreDataManager alloc] init];
    });
    return manager;
}
- (NSURL *)applicationDocumentsDirectory {

    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}
-(NSManagedObjectModel *)managedIbjectModel{
    if (_managedIbjectModel != nil) {
        return _managedIbjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CoreData" withExtension:@"momd"];
    _managedIbjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedIbjectModel;
}
-(NSPersistentStoreCoordinator *)persistentStoreCoordinator{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    //创建sqlite数据可以  名字根据需求自定义
    NSString *storepath = @"test.sqlite";
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedIbjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:storepath];
    NSString *failureReaseon = @"创建或加载应用程序的保存数据时出错";
    NSError *error = nil;
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[NSLocalizedDescriptionKey] = @"初始化应用程序保存的数据失败";
        dic[NSLocalizedFailureReasonErrorKey] = failureReaseon;
        dic[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:999 userInfo:dic];
        abort();
    }
    return _persistentStoreCoordinator;
}
-(NSManagedObjectContext *)managedObjectContext{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

-(void)saveContext{
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            abort();
        }
    }
}

-(void)insertVideoWith:(NSDictionary *)dic{
    NSManagedObjectContext *context = [self managedObjectContext];
    //创建一个新的Video
    VideoModel *video = [NSEntityDescription insertNewObjectForEntityForName:@"VideoModel" inManagedObjectContext:context];
    [video setValuesForKeysWithDictionary:dic];
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"插入失败:%@",error.localizedDescription);
    }
}
-(NSArray *)getVideo{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    //关联实体  也就是VideoModel
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"VideoModel" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    /*设置过滤  这里我不需要筛选 所以此部奏省略
    NSPredicate *pre  = [NSPredicate predicateWithFormat:@"id=%@ and url=%@",@"id",@"url"];
    fetchRequest.predicate = pre;
     **/
    
    /** 设置排序，可以设置多个  我不需要 所以省略
     NSSortDescriptor *sortDesc = [NSSortDescriptor sortDescriptorWithKey:@"createDate" ascending:YES];
     fetchRequest.sortDescriptors = @[sortDesc];
     */
    
    NSError *error;
    NSArray *fetchObjects = [context executeFetchRequest:fetchRequest error:&error];
    return fetchObjects;
}
-(void)DelegateVideoWith:(VideoModel *)video{
    
    //获取上下文
    NSManagedObjectContext *context = [self managedObjectContext];
    
    //关联实体
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"VideoModel" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    //获取id匹配的数据库中的数据
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"id = %@",video.id];
    NSError *error;
    NSArray *datas = [context executeFetchRequest:fetchRequest error:&error];
    
    //如果数据库中有 那就删除掉
    if (!error&&datas&&datas.count) {
        for (VideoModel *video in datas) {
            [context deleteObject:video];
        }
        if (![context save:&error]) {
            NSLog(@"删除失败");
        }
    }
     

}


-(void)UpdataVideo:(VideoModel *)video{
    //获取上下文
    NSManagedObjectContext *context = [self managedObjectContext];
    
    //关联实体
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"VideoModel" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"id = %d",video.id];
    NSError *error;
    NSArray *datas = [context executeFetchRequest:fetchRequest error:&error];
    
    for (VideoModel *newVideo in datas) {
        newVideo.url = video.url;
        newVideo.title = video.title;
        newVideo.createDate = video.createDate;
        newVideo.id = video.id;
        newVideo.img = video.img;
    }
    
    //保存
    if ([context save:&error]) {
        //更新成功
        NSLog(@"更新成功");
    }

}

-(void)UpdataVideo:(NSString *)ID With:(NSDictionary *)dic{
    //获取上下文
    NSManagedObjectContext *context = [self managedObjectContext];
    
    //关联实体
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"VideoModel" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"id = %@",ID];
    NSError *error;
    NSArray *datas = [context executeFetchRequest:fetchRequest error:&error];
    
    for (VideoModel *newVideo in datas) {
        [newVideo setValuesForKeysWithDictionary:dic];
    }
    //保存
    if ([context save:&error]) {
        //更新成功
        NSLog(@"更新成功");
    }
}
@end
