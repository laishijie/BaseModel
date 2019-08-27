//
//  WCTestModel.m
//  WCBaseTest
//
//  Created by Jay on 2019/5/16.
//  Copyright © 2019 jay. All rights reserved.
//

#import "WCTestModel.h"

@implementation WCTestDicModel
//子类重写
/**  return @{@"oldDicName":@"newName"}; */
- (NSDictionary *)replacePropertyNames {
    return @{@"id":@"dataId"};
}

@end

@implementation WCTestDicArrModel

@end

@implementation WCTestModel

//子类重写
/**  return @{@"oldDicName":@"newName"}; */
- (NSDictionary *)replacePropertyNames {
    return @{@"id":@"dataId",@"dicReplace":@"dic_replace"};
}
/** return @{@"arrName":(array内承接的元素类)[Class class]}; */
- (NSDictionary *)arrayProperty {
    return @{@"myDicArr":[WCTestDicArrModel class],};
}
/** return @{@"dicName":[Class class]}; */
- (NSDictionary *)dicProperty {
    return @{@"dic":[WCTestDicModel class],
             @"dic_replace":[WCTestDicModel class]
             };
}

/** 哪些参数使用枚举 */
- (NSArray *)enumArr {
    return @[@"enumStr"];
}
/** return @{@"枚举对应的参数":@{@"参数值":@(enumvule)}}
 *  需要配合 - (NSArray *)enumArr 使用
 */
- (NSDictionary *)enumPropertyDic {
    return @{@"enumStr":@{@"enum1":@(WCTestEnumType1),
                          @"enum2":@(WCTestEnumType2),
                          @"enum3":@(WCTestEnumType3),
                          }
             
             };
}

@end


