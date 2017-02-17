//
//  DQVideoModel.h
//  DQPlayer
//
//  Created by  lizhongqiang on 2017/2/17.
//  Copyright © 2017年  lizhongqiang. All rights reserved.
//
//  
//  @class DQVideoModel
//  @description <#添加描述#>
//

#import <Foundation/Foundation.h>

@interface DQVideoModel : NSObject
@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) int size;

- (id)initWithDictionary:(NSDictionary *)dict;

@end
