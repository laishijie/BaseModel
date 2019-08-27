//
//  WCTestModel.h
//  WCBaseTest
//
//  Created by Jay on 2019/5/16.
//  Copyright © 2019 jay. All rights reserved.
//

#import "WCBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

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

NS_ASSUME_NONNULL_END


//NSDictionary *dic = @{@"id":@"125",
//                      @"name":@"牛逼",
//                      @"myNormalArr":@[@"a",@"b",@"c"],
//                      @"myDicArr":@[@{@"a":@"1"},
//                                    @{@"a":@"2"},
//                                    @{@"a":@"3"}],
//                      @"dic":@{@"id":@"666",
//                               @"name":@"二级标签"
//                               },
//                      @"dicReplace":@{@"id":@"166",
//                                      @"name":@"二级标签Replace"
//                                      },
//                      @"enumStr":@"enum1"
//                      };
