# BaseModel
turn dic to a model

转换字典为模型，参考 yymodel实现的
暂时未支持float 类型
使用非常简单

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
