//
//  FirstViewController.m
//  Silver
//
//  Created by Kai on 16/5/28.
//  Copyright © 2016年 Kai. All rights reserved.
//

#import "HomeViewController.h"
#import "TitleScrollView.h"
#import "SilverView.h"
#import "SilverManager.h"
#import "SDCycleScrollView.h"

@interface HomeViewController ()<TitleScrollDelegate>

@property(nonatomic,strong)TitleScrollView*titleScrollView;
@property(nonatomic,strong)NSArray*titleArray;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) SilverView *silerView;
@property (nonatomic, strong) AFURLSessionManager* manager;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareData];
    
    
    
    
    

}

-(void)prepareData
{
    
    

    
    
    
    SilverManager* silver=[SilverManager sharedManager];
    
    
    NSString*URLString=@"http://api.siyinjia.com//1.0/other/config/info1?city_id=0&platform=iphone&platform_version=9.3.2&device_id=fb83d5ce4fea33f51a7de80da79cd2341fa2a343&network_type=Wifi&channel=appstore&app_version=4.1.0&id_customer=0&customer_id=0&type_member=0&md5=1286fe";
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:URLString parameters:nil error:nil];;
    
    
    
    
    NSURLSessionDataTask *dataTask = [silver.netManager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"%@ %@", response, responseObject);
            if ([responseObject isKindOfClass:[NSDictionary class]])
            {
                NSDictionary*dic=(NSDictionary*)responseObject;
                NSDictionary*result=dic[@"result"];
                NSArray*titleArray=result[@"category"];
                self.titleArray=titleArray;
                [self initTitleView];
                [self initScrollViewAndTableView];
                
            }
        }
    }];
    [dataTask resume];


}
-(void)initTitleView
{
    UIView*titleView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    titleView.backgroundColor=[UIColor colorWithRed:0.12f green:0.70f blue:0.55f alpha:1.00f];
    TitleScrollView*scrollTitle=[[TitleScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-64, 64) titleArray:self.titleArray Index:0];
    scrollTitle.titleDelegate=self;
    self.titleScrollView=scrollTitle;
    
    
    UIButton*searchButton=[UIButton buttonWithType:UIButtonTypeCustom];
    

    searchButton.frame=CGRectMake(self.view.frame.size.width-64, 0, 64, 64);
    
    

   
    [searchButton setImage:[UIImage imageNamed:@"icon_search"] forState:UIControlStateNormal];
    searchButton.imageEdgeInsets=UIEdgeInsetsMake(20, 20, 20, 20);
    [searchButton addTarget:self action:@selector(searchClick:) forControlEvents:UIControlEventTouchUpInside];
    searchButton.backgroundColor=[UIColor clearColor];
    
    
    [titleView addSubview:searchButton];
    
    [titleView addSubview:scrollTitle];
    [self.view addSubview:titleView];
}

-(void)initScrollViewAndTableView
{
    
    
    SilverManager* silver=[SilverManager sharedManager];
    
    
    NSString*URLString=@"http://api.siyinjia.com//1.0/other/banner/list?city_id=0&platform=iphone&platform_version=9.3.2&device_id=fb83d5ce4fea33f51a7de80da79cd2341fa2a343&network_type=Wifi&channel=appstore&app_version=4.1.0&id_customer=0&customer_id=0&type_member=0&md5=e22632";
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:URLString parameters:nil error:nil];;
    
    
    
    
    NSURLSessionDataTask *dataTask = [silver.netManager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"%@ %@", response, responseObject);
            if ([responseObject isKindOfClass:[NSDictionary class]])
            {
                NSDictionary*dic=(NSDictionary*)responseObject;
                NSArray*result=dic[@"result"];
                
                
                
                UIScrollView*scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
                scrollView.delegate=self;
                [self.titleArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    SilverView*silerView=[[SilverView alloc]initWithFrame:CGRectMake(idx*scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height)];
                    silerView.congfigDic=obj;
                    
                    
                    [scrollView addSubview:silerView];
                    if (idx==0)
                    {
                        self.silerView=silerView;
                        
                        silerView.headerArray=result;
                        
                        
                        SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 280, silerView.frame.size.width, 160) delegate:nil placeholderImage:[UIImage imageNamed:@"header.jpeg"]];
                        
                        cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
                       // cycleScrollView2.titlesGroup = titles;
                        
                        NSMutableArray*imagesURLStrings=[[NSMutableArray alloc]init];
                        for (NSDictionary*dic in result)
                        {
                            [imagesURLStrings addObject:dic[@"image"]];
                        }
                        
                        
                        cycleScrollView2.currentPageDotColor = [UIColor whiteColor];
                        cycleScrollView2.imageURLStringsGroup = imagesURLStrings;

                        
                        silerView.tableView.tableHeaderView=cycleScrollView2;

                    }
                    
                    
                    
                }];
                scrollView.pagingEnabled=YES;
                
                self.scrollView=scrollView;
                scrollView.contentSize=CGSizeMake(self.titleArray.count*scrollView.frame.size.width, 0);
                
                [self.view addSubview:scrollView];

                
                
                
                

                
            }
        }
    }];
    [dataTask resume];
    
    
}
#pragma ----Action-----
-(void)searchClick:(UIButton*)button
{
    
}
#pragma ----TitleScrollDelegate----

-(void)titleSelectedIndex:(NSInteger)index
{
    NSLog(@"index=%d",index);
    
    [self.scrollView setContentOffset:CGPointMake(index*self.silerView.frame.size.width, 0) animated:YES];
}
#pragma mark----UIScrollViewDelegate-----
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat offsetx=scrollView.contentOffset.x;
    
    NSInteger index=(offsetx/self.silerView.frame.size.width);
    [self.titleScrollView setTitleIndex:index];
}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSLog(@"end");
}
@end
