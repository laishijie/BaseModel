# BaseModel
turn dic to a model

转换字典为模型，参考 yymodel实现的
暂时未支持float 类型
使用非常简单

简单用法
```
 NSDictionary *dic = @{@"id":@"125",
                          @"name":@"牛逼",
                          @"myNormalArr":@[@"a",@"b",@"c"],
                          @"myDicArr":@[@{@"a":@"1"},
                                        @{@"a":@"2"},
                                        @{@"a":@"3"}],
                          @"dic":@{@"id":@"666",
                                   @"name":@"二级标签"
                                   },
                          @"dicReplace":@{@"id":@"166",
                                   @"name":@"二级标签Replace"
                                   },
                          @"enumStr":@"enum1"
                          };
    WCTestModel *test = [WCTestModel wcConfigWithDic:dic];
```

WCTestModel.h
```
typedef NS_ENUM(NSInteger , WCTestEnumType) {
    WCTestEnumTypeNone,
    WCTestEnumType1,
    WCTestEnumType2,
    WCTestEnumType3
};

@interface WCTestDicModel : WCBaseModel
@property (nonatomic, copy) NSString *dataId;
@property (nonatomic, copy) NSString *name;
@end

@interface WCTestDicArrModel : WCBaseModel
@property (nonatomic, copy) NSString *a;
@end

@interface WCTestModel : WCBaseModel

@property (nonatomic, copy) NSString *dataId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray * myNormalArr;
@property (nonatomic, strong) NSArray<WCTestDicArrModel*>* myDicArr;
@property (nonatomic, strong) WCTestDicModel *dic;
@property (nonatomic, strong) WCTestDicModel *dic_replace;
@property (nonatomic, assign) WCTestEnumType enumStr;

@end
```
WCTestModel.m
```
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

```

新创建子类继承 WCBaseModel即可

<a>子类重写<a>
```
1.需要类型名和Key不一致
/**  return @{@"key":@"property_name"}; */
- (NSDictionary *)replacePropertyNames;

2.数组中为字典，需要直接转换成Model型数组
/** return @{@"arrName":(array内承接的元素类)[Class class]}; */
- (NSDictionary *)arrayProperty;

3.需要转换成模型的字典
/** return @{@"dicName":[Class class]}; */
- (NSDictionary *)dicProperty;

4.字符串转枚举
/** 哪些参数使用枚举 */
- (NSArray *)enumArr;
/** return @{@"枚举对应的参数":@{@"参数值":@(enumvule)}}
 *  需要配合 - (NSArray *)enumArr 使用
 */
- (NSDictionary *)enumPropertyDic;

5.把Model转换成字典
- (NSDictionary *)turnToDic;
```
