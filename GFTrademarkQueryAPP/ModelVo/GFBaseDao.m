//
//  GFBaseDao.m
//  GFTrademark
//
//  Created by 夏伟耀 on 16/3/18.
//  Copyright © 2016年 gf. All rights reserved.
//

#import "GFBaseDao.h"
#import <AdSupport/ASIdentifierManager.h>

@implementation GFBaseDao
//
///**
// *  生成随机字符串
// *  @return 随机字符串
// */
//+ (NSString *)makeRand {
//    int NUMBER_OF_CHARS = 6;
//    char data[NUMBER_OF_CHARS];
//    for (int x=0; x < NUMBER_OF_CHARS; data[x++] = (char)('A' + (arc4random_uniform(26))));
//    return [[NSString alloc] initWithBytes:data length:NUMBER_OF_CHARS encoding:NSUTF8StringEncoding];
//}
//
///**
// *  生成checkCode platformCheckCode=平台验证码&rand=随机字符串
// *  @param mRandStr 随机字符串
// *  @return checkCode
// */
//+ (NSString *)makeCheckCodeWithRand:(NSString *)mRandStr {
//    NSString *checkCode = [NSString stringWithFormat:@"platformCheckCode=%@&rand=%@", PLATFORM_CHECK_CODE, mRandStr];
//    return [self makeMD5Code:checkCode];
//}
//
///**
// *  生成checkCode platformCheckCode=平台验证码&userID=用户ID&loginID=登录ID&loginCheckCode=登录验证码&rand=随机字符串
// *  @param userID         用户ID
// *  @param loginID        登录ID
// *  @param loginCheckCode 登录验证码
// *  @param rand           随机字符串
// *  @return checkCode
// */
//+ (NSString *)makeCheckCodeWithUserID:(NSString *)userID
//                              loginID:(NSString *)loginID
//                       loginCheckCode:(NSString *)loginCheckCode
//                                 rand:(NSString *)rand {
//    NSString *checkCode = [NSString stringWithFormat:@"platformCheckCode=%@&userID=%@&loginID=%@&loginCheckCode=%@&rand=%@", PLATFORM_CHECK_CODE, userID, loginID, loginCheckCode, rand];
//    NSLog(@"checkCode原文：%@", checkCode);
//    return [self makeMD5Code:checkCode];
//}
//
///**
// *  生成32位MD5
// *  @param mString 原文
// *  @return MD5结果
// */
//+ (NSString *)makeMD5Code:(NSString *)mString {
//    const char *mChar = [mString UTF8String];
//    unsigned char result[CC_MD5_DIGEST_LENGTH];
//    CC_MD5(mChar, strlen(mChar), result);
//    NSMutableString *mResultStr = [NSMutableString string];
//    for(int i = 0;i < CC_MD5_DIGEST_LENGTH; i++) {
//        [mResultStr appendFormat:@"%02X",result[i]];
//    }
//    return [mResultStr lowercaseString];
//}
//
///**
// *  获取本机的唯一码
// *  @return 唯一码
// */
//+ (NSString *)makeUniqueCode {
//    
////    return @"34F73211-7B7F-49A6-B99B-7DF639F79E05";
//    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];;
//}
//
//
///**
// *  结果0状态提示
// *
// */
//+ (BOOL)daoValueStatus:(NSDictionary *)responseDictionary vc:(GFBasicController *)vc
//{
//    
//    
//    if ([[responseDictionary objectForKey:@"status"] intValue] == 0) {
//        
//        NSString *err = [responseDictionary objectForKey:@"err"];
//        // 提示错误
//        [vc showNoticeHudWithTitle:@"all_dialog_title", nil)  subtitle:err onView:vc.view inDuration:1.2];
//        return NO;
//    }
//    
//    return YES;
//}

@end
