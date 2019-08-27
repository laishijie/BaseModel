//
//  WCBaseModel.h
//  WarmCurrent
//
//  Created by Jay on 2018/10/22.
//  Copyright © 2018 广东灵机文化传播有限公司（本内容仅限于广东灵机文化传播有限公司内部传阅，禁止外泄以及用于其他的商业目的）. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WCBaseModel : NSObject

@property (nonatomic, copy) NSDictionary * origionDic;


+ (instancetype)wcConfigWithDic:(NSDictionary*)dic;

//子类重写
/**  return @{@"oldDicName":@"newName"}; */
- (NSDictionary *)replacePropertyNames;
/** return @{@"arrName":(array内承接的元素类)[Class class]}; */
- (NSDictionary *)arrayProperty;
/** return @{@"dicName":[Class class]}; */
- (NSDictionary *)dicProperty;

/** 哪些参数使用枚举 */
- (NSArray *)enumArr;
/** return @{@"枚举对应的参数":@{@"参数值":@(enumvule)}}
 *  需要配合 - (NSArray *)enumArr 使用
 */
- (NSDictionary *)enumPropertyDic;

- (NSDictionary *)turnToDic;

@end

NS_ASSUME_NONNULL_END
