//
//  DQVideoModel.m
//  DQPlayer
//
//  Created by  lizhongqiang on 2017/2/17.
//  Copyright © 2017年  lizhongqiang. All rights reserved.
//
//
//  @class DQVideoModel
//  @description <#添加描述#>
//

#import "DQVideoModel.h"

@implementation DQVideoModel

- (id)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.path = dict[@"path"];
        self.name = dict[@"name"];
        self.size = [dict[@"size"] intValue];
    }
    return self;
}
@end
