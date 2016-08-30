//
//  DataCheck.h
//  tranb
//
//  Created by Smalltask on 16/1/21.
//  Copyright © 2016年 cmf. All rights reserved.
//

#ifndef DataCheck_h
#define DataCheck_h

// 字符串
#define STR_IS_NIL(objStr) (![objStr isKindOfClass:[NSString class]] || objStr == nil || [objStr length] <= 0 || [[objStr stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""])
// 字典
#define DICT_IS_NIL(objDict) (![objDict isKindOfClass:[NSDictionary class]] || objDict == nil || [objDict count] <= 0 )
// 数组
#define ARRAY_IS_NIL(objArray) (![objArray isKindOfClass:[NSArray class]] || objArray == nil || [objArray count] <= 0 )
// Number
#define NUMBER_IS_NIL(objNum) (![objNum isKindOfClass:[NSNumber class]] || objNum == nil )


#define STR_NOT_NIL(objStr)   STR_IS_NIL(objStr)?@"  ":objStr

#endif /* DataCheck_h */
