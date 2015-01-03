//
//  STTableViewIndex.m
//  STTableViewJapaneseIndexSample
//
//  Created by EIMEI on 2015/01/02.
//  Copyright (c) 2015年 stack3. All rights reserved.
//

#import "STTableViewIndex.h"

static const unichar _STIndexChars[] = {
    0x3042, // あ
    0x304B, // か
    0x3055, // さ
    0x305F, // た
    0x306A, // な
    0x306F, // は
    0x307E, // ま
    0x3084, // や
    0x3089, // ら
    0x308F, // わ
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
    '#',
};
static const NSUInteger _STIndexCount = sizeof(_STIndexChars) / sizeof(_STIndexChars[0]);
static const NSUInteger _STLastJapanseCharIndex = 9; // わ

@implementation STTableViewIndex

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _name = name;
        _objects = [NSMutableArray arrayWithCapacity:10];
    }
    return self;
}

+ (NSArray *)generateIndexesFromObjects:(NSArray *)argObjects {
    NSMutableArray *objects = [argObjects mutableCopy];
    /*
    objects = [objects sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString *name1 = ((id<STTableViewIndexObject>)obj1).indexName;
        NSString *name2 = ((id<STTableViewIndexObject>)obj2).indexName;
        return [name1 compare:name2];
    }];
     */
    NSMutableArray *indexes = [NSMutableArray arrayWithCapacity:100];
    int j = 0;
    //
    // あ〜ら
    //
    for (; j < _STLastJapanseCharIndex; j++) {
        unichar indexChar = _STIndexChars[j];
        unichar nextIndexChar = _STIndexChars[j + 1];
        STTableViewIndex *index = [[STTableViewIndex alloc] initWithName:[NSString stringWithCharacters:&indexChar length:1]];
        [indexes addObject:index];

        for (int i = (int)objects.count - 1; i >= 0; i--) {
            id<STTableViewIndexObject> object = objects[i];
            unichar objectIndexChar = [self covertTempIndexFromName:object.indexName];
            if (indexChar <= objectIndexChar && objectIndexChar < nextIndexChar) {
                [index.objects addObject:object];
                [objects removeObjectAtIndex:i];
            }
        }
        [self sortByNameInArray:index.objects];
    }
    //
    // わ
    //
    {
        unichar indexChar = _STIndexChars[j];
        unichar nextIndexChar = 0x3093; // ん
        STTableViewIndex *index = [[STTableViewIndex alloc] initWithName:[NSString stringWithCharacters:&indexChar length:1]];
        [indexes addObject:index];

        for (int i = (int)objects.count - 1; i >= 0; i--) {
            id<STTableViewIndexObject> object = objects[i];
            unichar objectIndexChar = [self covertTempIndexFromName:object.indexName];
            if (indexChar <= objectIndexChar && objectIndexChar < nextIndexChar) {
                [index.objects addObject:object];
                [objects removeObjectAtIndex:i];
            }
        }
        [self sortByNameInArray:index.objects];
        j++;
    }
    //
    // A〜Z
    //
    for (; j < _STIndexCount - 1; j++) {
        unichar indexChar = _STIndexChars[j];
        STTableViewIndex *index = [[STTableViewIndex alloc] initWithName:[NSString stringWithCharacters:&indexChar length:1]];
        [indexes addObject:index];

        for (int i = (int)objects.count - 1; i >= 0; i--) {
            id<STTableViewIndexObject> object = objects[i];
            unichar objectIndexChar = [[object.indexName uppercaseString] characterAtIndex:0];
            if (indexChar == objectIndexChar) {
                [index.objects addObject:object];
                [objects removeObjectAtIndex:i];
            }
        }
        [self sortByNameInArray:index.objects];
    }
    //
    // #
    //
    {
        unichar indexChar = _STIndexChars[_STIndexCount - 1];
        STTableViewIndex *index = [[STTableViewIndex alloc] initWithName:[NSString stringWithCharacters:&indexChar length:1]];
        [indexes addObject:index];
        
        for (int i = (int)objects.count - 1; i >= 0; i--) {
            id<STTableViewIndexObject> object = objects[i];
            [index.objects addObject:object];
        }
        [self sortByNameInArray:index.objects];
    }
    
    return indexes;
}

+ (STTableViewIndex *)findIndexByName:(NSString *)name inArray:(NSArray *)indexArray {
    for (STTableViewIndex *index in indexArray) {
        if ([index.name isEqualToString:name]) {
            return index;
        }
    }
    return nil;
}

+ (NSArray *)indexNamesInArray:(NSArray *)indexArray {
    NSMutableArray *names = [NSMutableArray arrayWithCapacity:indexArray.count];
    for (STTableViewIndex *index in indexArray) {
        [names addObject:index.name];
    }
    return names;
}

+ (void)sortByNameInArray:(NSMutableArray *)array {
    [array sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString *name1 = ((id<STTableViewIndexObject>)obj1).indexName;
        NSString *name2 = ((id<STTableViewIndexObject>)obj2).indexName;
        return [name1 compare:name2];
    }];
}

/**
 * 比較しやすいインデックスに便宜上変換
 */
+ (unichar)covertTempIndexFromName:(NSString *)name {
    NSMutableString *firstStr = [[name substringWithRange:NSMakeRange(0, 1)] mutableCopy];
    // カタカナをひらがなにする
    CFStringTransform((CFMutableStringRef)firstStr, NULL, kCFStringTransformHiraganaKatakana, true);
    unichar indexUnichar = [firstStr characterAtIndex:0];
    if (indexUnichar == 0x3094 /*ゔ*/) {
        return 0x3046; /*う*/
    } else if (indexUnichar == 0x3041 /*ぁ*/) {
        // 「ぁ」は「あ」よりunicode値が小さいので調整
        return 0x3042; /*あ*/
    } else if (indexUnichar == 0x3041 /*ヵ*/) {
        return 0x304B; /*か*/
    } else if (indexUnichar == 0x3041 /*ヶ*/) {
        return 0x3051; /*け*/
    }
    return indexUnichar;
}

@end
