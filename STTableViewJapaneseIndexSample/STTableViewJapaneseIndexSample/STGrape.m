//
//  STGrape.m
//  STTableViewJapaneseIndexSample
//
//  Created by MIYAMOTO, Hideaki on 2015/01/02.
//  Copyright (c) 2015年 stack3. All rights reserved.
//

#import "STGrape.h"

@implementation STGrape

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _name = name;
    }
    return self;
}

- (NSString *)indexName {
    return _name;
}

- (NSString *)description {
    return _name;
}

@end
