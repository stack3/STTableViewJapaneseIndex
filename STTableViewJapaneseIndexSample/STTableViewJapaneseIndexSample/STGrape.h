//
//  STGrape.h
//  STTableViewJapaneseIndexSample
//
//  Created by EIMEI on 2015/01/02.
//  Copyright (c) 2015年 stack3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../../STTableViewIndex.h"

@interface STGrape : NSObject <STTableViewIndexObject>

@property (strong, nonatomic, readonly) NSString *name;

- (instancetype)initWithName:(NSString *)name;

@end
