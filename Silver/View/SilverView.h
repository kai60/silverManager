//
//  SilverTableView.h
//  Silver
//
//  Created by Kai on 16/5/29.
//  Copyright © 2016年 Kai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SilverView : UIView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong)NSDictionary*congfigDic;//id name 配置数据
@property(nonatomic,strong)NSArray*headerArray;//header
@end
