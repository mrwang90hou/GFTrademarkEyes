//
//  LeftView.m
//  GFSlide
//
//  Created by 王宁 on 2018/3/23.
//  Copyright © 2018年 王宁. All rights reserved.
//

#import "LeftView.h"
@interface LeftView()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UIImageView *backIcon;
@end
@implementation LeftView

-(void)awakeFromNib{
    [super awakeFromNib];
    
    [UIImage GF_ClipCircleImageWithImage:[UIImage imageNamed:@"icon"] circleRect:self.icon.bounds borderWidth:2 borderColor:[UIColor whiteColor]];
    self.backIcon.layer.masksToBounds = YES;
}
+(LeftView *)showView{
    return [[NSBundle mainBundle]loadNibNamed:@"LeftView" owner:self options:nil].firstObject;
}
@end
