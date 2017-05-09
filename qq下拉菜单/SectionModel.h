//
//  SectionModel.h
//  qq下拉菜单
//
//  Created by 简而言之 on 2017/5/9.
//  Copyright © 2017年 jiafa.apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "rowModel.h"
@interface SectionModel : NSObject

/** 是否被点击 */
@property (nonatomic, assign) BOOL isSelected;

/** section显示内容 */
@property (nonatomic, copy) NSString *userName;

/** 每一个section下的row显示的内容 */
@property (nonatomic, strong) NSMutableArray<rowModel *> *rowArray;

@end
