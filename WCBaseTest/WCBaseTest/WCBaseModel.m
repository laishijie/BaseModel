//
//  WCBaseModel.m
//  WarmCurrent
//
//  Created by Jay on 2018/10/22.
//  Copyright © 2018 广东灵机文化传播有限公司（本内容仅限于广东灵机文化传播有限公司内部传阅，禁止外泄以及用于其他的商业目的）. All rights reserved.
//

#import "WCBaseModel.h"
#import <objc/runtime.h>

@implementation WCBaseModel

+ (instancetype)wcConfigWithDic:(NSDictionary*)dic {
    WCBaseModel *model = [[self alloc]init];
    model.origionDic = dic.copy;
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return model;
    }
    unsigned int properyListCount = 0;
    objc_property_t *propertys = class_copyPropertyList([self class], &properyListCount);
    NSMutableArray *propertyArr = [NSMutableArray new];
    NSMutableDictionary *propertyAttributeDic = [NSMutableDictionary new];
    for (NSInteger i = 0; i < properyListCount; i++) {
        objc_property_t property = propertys[i];
        const char *name = property_getName(property);
        NSString *nameStr = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        [propertyArr addObject:nameStr];
        const char *attribute = property_getAttributes(property);
        NSString *attributeName = [NSString stringWithUTF8String:attribute];
        [propertyAttributeDic setObject:attributeName forKey:nameStr];
    }
    
    free(propertys);//释放
    NSDictionary *replacePropertyDic = [model replacePropertyNames];
    for (NSString *key in dic.allKeys) {
        
        if ([propertyArr containsObject:key]) {
            id value = [dic objectForKey:key];
            if ([[propertyAttributeDic objectForKey:key] containsString:NSStringFromClass([NSNumber class])]) {
                value = @([value integerValue]);
            }
            if ([[propertyAttributeDic objectForKey:key] containsString:@"NSMutable"]) {
                value = [value mutableCopy];
            }
            if ([[propertyAttributeDic objectForKey:key] containsString:NSStringFromClass([NSString class])] && value != nil) {
                value = [NSString stringWithFormat:@"%@",value];
            }
            //BOOL
            if ([[propertyAttributeDic objectForKey:key] hasPrefix:@"Tc,"]) {
                if ([value isKindOfClass:[NSString class]]) {
                    if ([value isEqualToString:@"yes"]||
                        [value isEqualToString:@"1"]) {
                        value = @(1);
                    }
                    else if ([value isEqualToString:@"no"]||
                             [value isEqualToString:@"0"]) {
                        value = @(0);
                    }
                }
            }
            
            [model setValue:value forKey:key];
        }
        else if ([replacePropertyDic objectForKey:key] != nil){
            if ([propertyArr containsObject:[replacePropertyDic objectForKey:key]]) {
                
                id value = [dic objectForKey:key];
                NSString *replaceKey = [replacePropertyDic objectForKey:key];
                
                if ([[propertyAttributeDic objectForKey:replaceKey] containsString:NSStringFromClass([NSNumber class])]) {
                    value = @([value integerValue]);
                }
                if ([[propertyAttributeDic objectForKey:replaceKey] containsString:@"NSMutable"]) {
                    value = [value mutableCopy];
                }
                if ([[propertyAttributeDic objectForKey:replaceKey] containsString:NSStringFromClass([NSString class])] && value != nil) {
                    value = [NSString stringWithFormat:@"%@",value];
                }
                //BOOL
                if ([[propertyAttributeDic objectForKey:replaceKey] hasPrefix:@"Tc,"]) {
                    if ([value isKindOfClass:[NSString class]]) {
                        if ([value isEqualToString:@"yes"]||
                            [value isEqualToString:@"1"]) {
                            value = @(1);
                        }
                        else if ([value isEqualToString:@"no"]||
                                 [value isEqualToString:@"0"]) {
                            value = @(0);
                        }
                    }
                }
                [model setValue:value forKey:replaceKey];
            }
        }
    }
    
    return model;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    if ([value isKindOfClass:[NSArray class]]) {
        if ([[self arrayProperty] isKindOfClass:[NSDictionary class]]) {
            if ([[self arrayProperty].allKeys containsObject:key]) {
                NSMutableArray *newArr = [NSMutableArray new];
                for (int i = 0; i < [value count]; i ++) {
                    Class class = [[self arrayProperty] objectForKey:key];
                    if ([class respondsToSelector:@selector(wcConfigWithDic:)]) {
                        [newArr addObject:[class wcConfigWithDic:[value objectAtIndex:i]]];
                    }
                }
                value = newArr;
            }else {
                if ([[self dicProperty].allKeys containsObject:key]) {
                    value = @{};
                }
            }
        }
        
    }
    if ([value isKindOfClass:[NSDictionary class]]) {
        if ([[self dicProperty] isKindOfClass:[NSDictionary class]]) {
            if ([[self dicProperty].allKeys containsObject:key]) {
                Class class = [[self dicProperty] objectForKey:key];
                if ([class respondsToSelector:@selector(wcConfigWithDic:)]) {
                    value = [class wcConfigWithDic:value];
                }
            }else {
                if ([[self arrayProperty].allKeys containsObject:key]) {
                    value = @[];
                }
            }
        }
    }
    
    if ([[self enumArr] containsObject:key]) {
        NSDictionary *enumDic = [[self enumPropertyDic]objectForKey:key];
        value = [enumDic objectForKey:[NSString stringWithFormat:@"%@",value]];
        if (value == nil) {
            value = @(0);
        }
    }
    
    if ([value isKindOfClass:[NSObject class]]) {
        [super setValue:value forKey:key];
    }
    
}

- (NSDictionary *)turnToDic {
    unsigned int properyListCount = 0;
    objc_property_t *propertys = class_copyPropertyList([self class], &properyListCount);
    NSMutableArray *propertyArr = [NSMutableArray new];
    for (NSInteger i = 0; i < properyListCount; i++) {
        objc_property_t property = propertys[i];
        const char *name = property_getName(property);
        NSString *nameStr = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        [propertyArr addObject:nameStr];
    }
    free(propertys);//释放
    
    NSMutableDictionary *valueDic = [NSMutableDictionary new];
    
    for (NSString *propertyName in propertyArr) {
        id value = [self valueForKey:propertyName];
        
        if ([value isKindOfClass:[NSArray class]]) {
            NSMutableArray *arr = [NSMutableArray new];
            for (int i = 0; i < [value count]; i ++) {
                Class class = [[self arrayProperty] objectForKey:propertyName];
                
                id newValue = [[class alloc]init];
                if ([newValue respondsToSelector:@selector(turnToDic)]) {
                    [arr addObject:[value[i] turnToDic]];
                }else {
                    [arr addObject:value[i]];
                }
            }
            value = arr;
        }
        if ([[self dicProperty] objectForKey:propertyName]) {
            Class class = [[self dicProperty] objectForKey:propertyName];
            
            id newValue = [[class alloc]init];
            if ([newValue respondsToSelector:@selector(turnToDic)]) {
                value = [newValue turnToDic];
            }
        }
        if (value == nil) {
            continue;
        }
        [valueDic setValue:value forKey:propertyName];
    }
    return valueDic;
}

- (NSDictionary *)replacePropertyNames {
    return @{};
}

- (NSDictionary *)arrayProperty {
    return @{};
}

- (NSDictionary *)dicProperty {
    return @{};
}

- (NSArray *)enumArr {
    return @[];
}

- (NSDictionary *)enumPropertyDic{
    return @{};
}

@end
