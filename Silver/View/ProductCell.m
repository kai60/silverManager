//
//  ProductCell.m
//  Silver
//
//  Created by Kai on 16/6/17.
//  Copyright © 2016年 Kai. All rights reserved.
//

#import "ProductCell.h"

@implementation ProductCell

{
    UILabel*_nameLabel;
    UILabel*_comment_rate;
    UILabel*_yield;
    UILabel*_continued_existence_period;
    UILabel*_commission;
    UILabel*_decritionLabel;
    UILabel*_raise_fake;
    UIProgressView*_progress;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self uiconfig];
    }
    return self;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)uiconfig
{
    UILabel*nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 0, 200, 30)];
    nameLabel.font=Font(14);
    nameLabel.backgroundColor=[UIColor clearColor];
    nameLabel.textColor=[UIColor darkGrayColor];
    
    [self.contentView addSubview:nameLabel];
    _nameLabel=nameLabel;
    
    
    UILabel*comment_rate=[[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width-60, 0, 60, 30)];
    comment_rate.font=Font(14);
    comment_rate.backgroundColor=[UIColor clearColor];
    comment_rate.textColor=[UIColor redColor];
    
    [self.contentView addSubview:comment_rate];
    _comment_rate=comment_rate;
    
    
    
    
    UILabel*yield=[[UILabel alloc]initWithFrame:CGRectMake(5, 35, 100, 30)];
    yield.font=BoldFont(15);
    yield.backgroundColor=[UIColor clearColor];
    yield.textColor=[UIColor blackColor];
    
    [self.contentView addSubview:yield];
    _yield=yield;
    
    UILabel*continued_existence_period=[[UILabel alloc]initWithFrame:CGRectMake(110, 35, 100, 30)];
    continued_existence_period.font=BoldFont(15);
    continued_existence_period.backgroundColor=[UIColor clearColor];
    continued_existence_period.textColor=[UIColor blackColor];
    
    [self.contentView addSubview:continued_existence_period];
    _continued_existence_period=continued_existence_period;
    
    
    
    UILabel*commission=[[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width-60, 35, 100, 30)];
    commission.font=BoldFont(15);
    commission.backgroundColor=[UIColor clearColor];
    commission.textColor=[UIColor redColor];
    
    [self.contentView addSubview:commission];
    _commission=commission;
    
    
    UILabel*decritionLabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 70, self.frame.size.width, 30)];
    decritionLabel.font=Font(12);
    decritionLabel.backgroundColor=[UIColor clearColor];
    decritionLabel.textColor=[UIColor lightGrayColor];
    
    decritionLabel.text=[NSString stringWithFormat:@"预期收益                   期限                     佣金比例"];
    [self.contentView addSubview:decritionLabel];
    _decritionLabel=decritionLabel;
    
    UIProgressView*progress=[[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
    progress.frame=CGRectMake(5, 115, 195, 5);
    progress.progressTintColor=[UIColor greenColor];
    //progress.progress=0.8;
    //progress.backgroundColor=[UIColor orangeColor];
    progress.trackTintColor=[UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f];;
    _progress=progress;
    [self.contentView addSubview:progress];
    
    
    UILabel*raise_fake=[[UILabel alloc]initWithFrame:CGRectMake(210, 105, 110, 23)];
    raise_fake.font=Font(12);
    raise_fake.backgroundColor=[UIColor clearColor];
    raise_fake.textColor=[UIColor blackColor];
    raise_fake.textAlignment=NSTextAlignmentCenter;
    
    [self.contentView addSubview:raise_fake];
    _raise_fake=raise_fake;

    
}
/**
 *
 *{
 UILabel*_nameLabel;
 UILabel*_comment_rate;
 UILabel*_yield;
 UILabel*_continued_existence_period;
 UILabel*_commission;
 UILabel*_decritionLabel;
 UILabel*_raise_fake;
 UIProgressView*_progress;
 }
 *  @param model <#model description#>
 */
-(void)fillData:(NSDictionary*)model
{
    
    
    _nameLabel.text=model[@"name"];
    _comment_rate.text=model[@"comment_rate"];
    _yield.text=model[@"yield"];
    _continued_existence_period.text=model[@"continued_existence_period"];
    _commission.text=[NSString stringWithFormat:@"%@",model[@"commission"]];
    float rake=[model[@"raise_fake"] floatValue];
    _progress.progress=rake/100;
    _raise_fake.text=[NSString stringWithFormat:@"已募集%.1f %%",rake];
}
@end
