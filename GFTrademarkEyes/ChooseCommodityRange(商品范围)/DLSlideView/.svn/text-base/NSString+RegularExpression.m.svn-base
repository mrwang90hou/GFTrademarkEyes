//
//  NSString+RegularExpression.m
//  RegularExpression
//
//  Created by Jniying on 15/9/22.
//  Copyright (c) 2015年 Jniying. All rights reserved.
//

#import "NSString+RegularExpression.h"

@implementation NSString (RegularExpression)

/**
 *  非空判断
 *
 *  @return yes -> 为非空  No -> 为空
 */
-(BOOL)textToKeyBord:(NSString *)text
{
    NSString *myMark = @" ";
    NSRange range = NSMakeRange(0, 1);
    if (text.length != 0)
    {
        for (int i = 0; i < text.length; ++i)
        {
            range.location = i;
            NSString *str = [text substringWithRange:range];
            
            if (![myMark isEqualToString:str])
            {
                return YES;
                break;
            }
            else
            {
                if (i == text.length-1)
                {
                    return NO;
                }
            }
            
        }
        
    }
    
    return NO;
}



- (BOOL)isRegexWithPattern:(NSString *)pattern {
    return [self regexWithPattern:pattern success:nil failure:nil];
}
- (BOOL)regexAtOneWithPattern:(NSString *)pattern success:(void (^)(NSString *, NSRange))success failure:(void (^)())failure {
    if (self.length <= 0) {
        return NO;
    }
    NSRegularExpression * regex = [NSRegularExpression regularExpressionWithPattern:pattern options:(NSRegularExpressionCaseInsensitive/*大小写敏感*/) error:nil];
    //开始匹配
    NSArray *matches = [regex matchesInString:self options:(NSMatchingReportCompletion/*完整匹配*/) range:NSMakeRange(0, self.length)];
    if (matches.count) {
        for (NSTextCheckingResult *result in matches) {
            success([self substringWithRange:result.range], result.range);
        }
        return YES;
    }else {
//        failure();
        return NO;
    }
}
- (BOOL)regexSubStringWithPattern:(NSString *)pattern success:(void (^)(NSString *, NSRange))success failure:(void (^)())failure {
    if (self.length <= 0) {
        return NO;
    }
    NSRegularExpression * regex = [NSRegularExpression regularExpressionWithPattern:pattern options:(NSRegularExpressionCaseInsensitive/*大小写敏感*/) error:nil];
    //开始匹配
    NSArray *matches = [regex matchesInString:self options:(NSMatchingReportCompletion/*完整匹配*/) range:NSMakeRange(0, self.length)];
    if (matches.count) {
        NSTextCheckingResult *result = matches.firstObject;
        NSString *str = [self substringWithRange:result.range];
        NSMutableString *resultString = [[NSMutableString alloc]initWithString:self];
        for (NSTextCheckingResult *result in matches) {
            [resultString replaceCharactersInRange:result.range withString:str];
        }
        NSArray *arr = [resultString componentsSeparatedByString:str];
        for (NSString *str1 in arr) {
            if ([str1 isEqualToString:@""]) continue;
            success(str1, [self rangeOfString:str1]);
        }
        return YES;
    }else {
//        failure();
        return NO;
    }
}

- (BOOL)regexWithPattern:(NSString *)pattern success:(void (^)(NSDictionary *))success failure:(void (^)())failure {
    if (self.length <= 0) {
        return NO;
    }
    NSRegularExpression * regex = [NSRegularExpression regularExpressionWithPattern:pattern options:(NSRegularExpressionCaseInsensitive/*大小写敏感*/) error:nil];
    //开始匹配
    NSArray *matches = [regex matchesInString:self options:(NSMatchingReportCompletion/*完整匹配*/) range:NSMakeRange(0, self.length)];
    if (matches.count) {
        NSMutableDictionary *resultDic = [NSMutableDictionary new];
        for (NSTextCheckingResult *result in matches) {
            [resultDic setObject:[NSValue valueWithRange:result.range] forKey: [self substringWithRange:result.range]];
        }
//        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:resultDic];
//        success(dic);
        return YES;
    }else {
//        failure();
        return NO;
    }
}

//中文匹配
- (BOOL)regexWithChineseSuccess:(void (^)(NSDictionary *))success failure:(void (^)())failure {
    return [self regexWithPattern:@"^[\u4e00-\u9fa5]+$" success:nil failure:nil];
}

//英文匹配
- (BOOL)regexWithEnglishSuccess:(void (^)(NSDictionary *))success failure:(void (^)())failure {
    return [self regexWithPattern:@"^[a-zA-Z]+$" success:nil failure:nil];
}

//数字匹配
- (BOOL)regexWithNumberSuccess:(void (^)(NSDictionary *))success failure:(void (^)())failure {
    return [self regexWithPattern:@"^[0-9]$" success:success failure:failure];
}

//数字匹配 个数 可设置
- (BOOL)regexWithNumber:(NSInteger)number
                Success:(void (^)(NSDictionary *))success
                failure:(void (^)())failure
{
    return [self regexWithPattern:[NSString stringWithFormat:@"^[0-9]{%ld}$",(long)number] success:success failure:failure];
}

- (BOOL)regexWithQQSuccess:(void (^)(NSDictionary *))success failure:(void (^)())failure {
    return [self regexWithPattern:@"^[0-9]{5,12}$" success:success failure:failure];
}
- (BOOL)regexWithPhoneSuccess:(void (^)(NSDictionary *))success failure:(void (^)())failure {
    return [self regexWithPattern:@"1[3578][0-9]{9}$" success:success failure:failure];
}
- (BOOL)regexWithMailSuccess:(void (^)(NSDictionary *))success failure:(void (^)())failure {
    return [self regexWithPattern:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}" success:success failure:failure];
}
- (BOOL)regexWithCardIDSuccess:(void (^)(NSDictionary *))success failure:(void (^)())failure {
    return [self regexWithPattern:@"^(\\d{14}|\\d{17})(\\d|[xX])$" success:success failure:failure];
}
//- (BOOL)regularExpressionWithCarNoSuccess:(void (^)(NSDictionary *))success failure:(void (^)())failure {
//    return [self regularExpressionWithPattern:@"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$" success:success failure:failure];
//}

- (BOOL)validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

//邮箱
- (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//小数点
- (BOOL) validatePoint:(NSString *)point
{
    NSString *pointRegex = @"[0-9.]{1,6}\\.[0-9]{1,2}";
    NSPredicate *pointTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pointRegex];
    return [pointTest evaluateWithObject:point];
}

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
- (CGSize)sizeWithString:(NSString*)string font:(CGFloat)font width:(CGFloat)width height:(CGFloat)height
{
    CGSize size = CGSizeMake(width ,height);
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};
    CGSize nameSize = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return nameSize;
}

@end
