//
//  STTableViewIndex.h
//  STTableViewJapaneseIndexSample
//
//  Created by EIMEI on 2015/01/02.
//  Copyright (c) 2015年 stack3. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 1索引を示す
 */
@interface STTableViewIndex : NSObject

/** 索引（あ〜わ、A〜Z、#。常に1文字） */
@property (strong, nonatomic, readonly) NSString *name;
/** 索引に属するオブジェクト */
@property (strong, nonatomic, readonly) NSMutableArray *objects;

- (instancetype)initWithName:(NSString *)name;
/**
 * オブジェクトの配列を索引分けしてSTTableViewIndex配列を返す
 */
+ (NSArray *)generateIndexesFromObjects:(NSArray *)objects;
/**
 * STTableViewIndex配列から指定索引のSTTableViewIndexを返す
 */
+ (STTableViewIndex *)findIndexByName:(NSString *)name inArray:(NSArray *)indexArray;
/**
 * STTableViewIndex配列からnameの配列を得る
 */
+ (NSArray *)indexNamesInArray:(NSArray *)indexArray;

@end

/**
 * 索引化するオブジェクトが実装すべきプロトコル。
 * STTableViewIndex#generateIndexesFromObjectsに渡すオブジェクトは、これを実装すること。
 */
@protocol STTableViewIndexObject <NSObject>

/** 索引に使う名前 */
- (NSString *)indexName;

@end
