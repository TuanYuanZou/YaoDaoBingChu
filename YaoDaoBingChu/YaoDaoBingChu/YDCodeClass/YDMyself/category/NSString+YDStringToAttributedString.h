//
//  NSString+YDStringToAttributedString.h
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/23.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YDStringToAttributedString)


/**
 *  普通文字 --> 属性文字
 *
 *  @param text 普通文字
 *
 *  @return 属性文字
 */
+ (NSAttributedString *)attributedTextWithText:(NSString *)text ;

@end
