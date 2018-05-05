//
//  NSString+RegularExpression.h
//  RegularExpression
//
//  Created by Jniying on 15/9/22.
//  Copyright (c) 2015年 Jniying. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RegularExpression)

/**
 *  非空判断
 *
 *  @return yes -> 为非空  No -> 为空
 */
-(BOOL)textToKeyBord:(NSString *)text;

/**
 *  直接判断是否匹配
 *
 *  @param pattern 匹配格式
 */
- (BOOL)isRegexWithPattern:(NSString *)pattern;
/**
 *  正则表达式匹配每找到一个结果回调一次
 *
 *  @param pattern 匹配格式
 *  @param success 成功回调，返回结果字符串，字符串的范围
 *  @param failure 失败回调
 *
 *  @return 判断是否匹配成功
 */
- (BOOL)regexAtOneWithPattern:(NSString *)pattern success:(void(^)(NSString *Result, NSRange range))success  failure:(void(^)())failure;
/**
 *  正则表达式匹配每找到一个结果把字符串切分为每个字符串返回
 *
 *  @param pattern 匹配格式
 *  @param success 成功回调，返回结果字符串，字符串的范围
 *  @param failure 失败回调
 *
 *  @return 判断是否匹配成功
 */
- (BOOL)regexSubStringWithPattern:(NSString *)pattern success:(void(^)(NSString *Result, NSRange range))success  failure:(void(^)())failure;
/**
 *  正则表达式匹配
 *
 *  @param pattern 匹配格式
 *  @param success 成功回调，返回一个装有结果字典object为结果范围，key为匹配结果的字符串
 *  @param failure 失败回调
 *
 *  @return 判断是否匹配成功
 */
- (BOOL)regexWithPattern:(NSString *)pattern success:(void(^)(NSDictionary *successResult))success  failure:(void(^)())failure;

//中文匹配
- (BOOL)regexWithChineseSuccess:(void(^)(NSDictionary *successResult))success  failure:(void(^)())failure;

//英文匹配
- (BOOL)regexWithEnglishSuccess:(void(^)(NSDictionary *successResult))success  failure:(void(^)())failure;

//数字匹配 个数1
- (BOOL)regexWithNumberSuccess:(void (^)(NSDictionary *))success failure:(void (^)())failure;

//数字匹配 个数 可设置
- (BOOL)regexWithNumber:(NSInteger)number
                Success:(void (^)(NSDictionary *))success
                failure:(void (^)())failure;

/**
 *  正则表达式匹配QQ
 *
 *  @param success 成功回调，返回一个装有结果字典object为结果范围，key为匹配结果的字符串
 *  @param failure 失败回调
 *
 *  @return 判断是否匹配成功
 */
- (BOOL)regexWithQQSuccess:(void(^)(NSDictionary *successResult))success  failure:(void(^)())failure;
/**
 *  正则表达式匹配手机号码
 *
 *  @param success 成功回调，返回一个装有结果字典object为结果范围，key为匹配结果的字符串
 *  @param failure 失败回调
 *
 *  @return 判断是否匹配成功
 */
- (BOOL)regexWithPhoneSuccess:(void(^)(NSDictionary *successResult))success  failure:(void(^)())failure;
/**
 *  正则表达式匹配邮箱
 *
 *  @param success 成功回调，返回一个装有结果字典object为结果范围，key为匹配结果的字符串
 *  @param failure 失败回调
 *
 *  @return 判断是否匹配成功
 */
- (BOOL)regexWithMailSuccess:(void(^)(NSDictionary *successResult))success  failure:(void(^)())failure;
/**
 *  正则表达式匹配生分证号码
 *
 *  @param success 成功回调，返回一个装有结果字典object为结果范围，key为匹配结果的字符串
 *  @param failure 失败回调
 *
 *  @return 判断是否匹配成功
 */
- (BOOL)regexWithCardIDSuccess:(void(^)(NSDictionary *successResult))success  failure:(void(^)())failure;
/**
 *  正则表达式匹配车牌号码
 *
 *  @param success 成功回调，返回一个装有结果字典object为结果范围，key为匹配结果的字符串
 *  @param failure 失败回调
 *
 *  @return 判断是否匹配成功
 */
//- (BOOL)regularExpressionWithCarNoSuccess:(void(^)(NSDictionary *successResult))success  failure:(void(^)())failure;

//身份证号
- (BOOL)validateIdentityCard: (NSString *)identityCard;

//邮箱
- (BOOL) validateEmail:(NSString *)email;

//小数点
- (BOOL) validatePoint:(NSString *)point;

/**
 *  动态label
 *
 *  @param string 需要计算高度的文字
 *  @param font   字体大小
 *  @param width  父本宽度
 *  @param height 父本高度
 *
 *  @return CGSize
 */
- (CGSize)sizeWithString:(NSString*)string font:(CGFloat)font width:(CGFloat)width height:(CGFloat)height;

@end
