//
//  SilverTableView.m
//  Silver
//
//  Created by Kai on 16/5/29.
//  Copyright © 2016年 Kai. All rights reserved.
//

#import "SilverView.h"
#import "MJRefresh.h"
#import "ProductCell.h"


@interface SilverView ()

@property (nonatomic, strong) NSArray *dataArray;



@end
@implementation SilverView


-(instancetype)initWithFrame:(CGRect)frame
{
    
    self=[super initWithFrame:frame];
    if (self)
    {
        self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:UITableViewStylePlain];
        
        
        UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 160)];
        imageView.image=[UIImage imageNamed:@"header.jpeg"];
        self.tableView.tableHeaderView=imageView;
        
        self.tableView.delegate=self;
        self.tableView.dataSource=self;
        [self.tableView reloadData];
        
        [self addSubview:self.tableView];
        
        __unsafe_unretained __typeof(self) weakSelf = self;
        
        MJRefreshNormalHeader* refreshHeader=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            SilverManager*manager=[SilverManager sharedManager];
            
            NSString*URLString=@"http://api.siyinjia.com//1.0/product/choiceness?type=3&page=1&customer_id=0&city_id=0&platform=iphone&platform_version=9.3.2&device_id=fb83d5ce4fea33f51a7de80da79cd2341fa2a343&network_type=Wifi&channel=appstore&app_version=4.1.0&id_customer=0&customer_id=0&type_member=0&md5=040dc9";
            NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:URLString parameters:nil error:nil];
            
            
            NSURLSessionDataTask*task=[manager.netManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                
                if (error) {
                    NSLog(@"Error: %@", error);
                } else {
                    NSLog(@"%@ %@", response, responseObject);
                    if ([responseObject isKindOfClass:[NSDictionary class]])
                    {
                        NSDictionary*dic=(NSDictionary*)responseObject;
                        NSArray*result=dic[@"result"];
                        
                        self.dataArray=result;
                        
                        [weakSelf.tableView reloadData];
                        
                        
                        
                        
                        
                    }
                }

                
                
                
                [weakSelf.tableView.mj_header  endRefreshing];
                
            }];
            
            [task resume];
            
            
            
            
            
            
            
        }];
        
        
        MJRefreshAutoNormalFooter* refreshFooter=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
           
            
            NSLog(@"加载更多") ;
            
            [weakSelf.tableView.mj_footer performSelector:@selector(endRefreshing) withObject:nil afterDelay:0.5];
        }];
        
        self.tableView.mj_header=refreshHeader;
       // self.tableView.mj_footer=refreshFooter;
        
        [self.tableView.mj_header beginRefreshing];
        
    }
    return self;
}




#pragma ----TableViewDelegate------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary*dic=self.dataArray[section];
    NSArray*product_list=dic[@"product_list"];
    
    return product_list.count;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 128;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary*dic=self.dataArray[indexPath.section];
    NSArray*product_list=dic[@"product_list"];
    NSDictionary*model=product_list[indexPath.row];
    static NSString* identy=@"cell";
    ProductCell*cell=[tableView dequeueReusableCellWithIdentifier:identy];
    if (cell==nil)
    {
        cell=[[ProductCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
        //cell.selectionStyle=UITableViewCellSelectionStyleNone;
        //cell =(ProductCell*) [[[NSBundle mainBundle]loadNibNamed:@"ProductCell" owner:nil options:nil] firstObject];
    }
    
       [cell fillData:model];
    
    
   // cell.textLabel.text=[NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel*label=[[UILabel alloc ]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
    
    
    label.backgroundColor=[UIColor colorWithRed:0.94f green:0.94f blue:0.96f alpha:1.00f];
    NSDictionary*dic=self.dataArray[section];
    NSString*name=dic[@"name"];
    
    label.font=BoldFont(16);
    
    label.text=[NSString stringWithFormat:@"    %@",name];
    label.textAlignment=NSTextAlignmentLeft;
    return label;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
@end
