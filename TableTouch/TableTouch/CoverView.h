//
//  CoverView.h
//  TableTouch
//
//  Created by Jerod on 2020/10/18.
//

#import <UIKit/UIKit.h>


@interface CoverView : UIView<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

