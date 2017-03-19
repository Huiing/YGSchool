//
//  YGDeviceInfoVC.m
//  YGSchool
//
//  Created by faith on 17/3/8.
//  Copyright © 2017年 YDK. All rights reserved.
//

#import "YGDeviceInfoVC.h"
#import "YGCommon.h"
@interface YGDeviceInfoVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation YGDeviceInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}
- (UITableView*)tableView{
    if(_tableView == nil){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger rows = 0;
    switch (section) {
        case 0:
        case 1:
            rows = 1;
            break;
            
        case 02:
            rows = 1;
            break;
    }
    return rows;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *headStr = nil;
    switch (section) {
        case 1:
            headStr = @"设备概况";
            break;
            
        case 2:
            headStr = @"设备操作";
            break;
    }
    return headStr;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = nil;
    UITableViewCell *cell = nil;
    NSInteger section = indexPath.section;
    switch (section) {
        case 0:{
            cellIdentifier = @"cell";
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if(cell == nil){
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            NSInteger imageTag = 111;
            UIImageView *imageView = (UIImageView*)[cell.contentView viewWithTag:imageTag];
            if(imageView == nil){
                imageView = [[UIImageView alloc] init];
                imageView.tag = imageTag;
                imageView.frame = CGRectMake(10, 10, 60, 60);
                [cell.contentView addSubview:imageView];
            }
            imageView.image = [UIImage imageNamed:@"defalut"];
//            [imageView sd_setImageWithURL:[NSURL URLWithString:self.viewModel.headIconUrl] placeholderImage:[UIImage imageNamed:@"defalut"]];
            
            NSInteger labelTag = 112;
            UILabel *label = (UILabel*)[cell.contentView viewWithTag:labelTag];
            if(label == nil){
                label = [[UILabel alloc] init];
                CGFloat x = CGRectGetMaxX(imageView.frame) + 5;
                label.frame = CGRectMake(x, imageView.frame.origin.y, (tableView.frame.size.width - 10 - x), 20);
                label.tag = labelTag;
                label.backgroundColor = [UIColor clearColor];
                label.textColor = [UIColor blackColor];
                label.font = [UIFont systemFontOfSize:14];
                [cell.contentView addSubview:label];
            }
            label.text = @"296179";
            
            NSInteger label1Tag = 113;
            UILabel *label1 = (UILabel*)[cell.contentView viewWithTag:label1Tag];
            if(label1 == nil){
                label1 = [[UILabel alloc] init];
                CGFloat x = CGRectGetMaxX(imageView.frame) + 5;
                CGFloat y = CGRectGetMaxY(imageView.frame) - 20;
                label1.frame = CGRectMake(x, y, label.frame.size.width, 20);
                label1.tag = label1Tag;
                label1.backgroundColor = [UIColor clearColor];
                label1.textColor = [UIColor blackColor];
                label1.font = [UIFont systemFontOfSize:13];
                [cell.contentView addSubview:label1];
            }
            label1.text = [NSString stringWithFormat:@"设备 IMEI: %@",@"353506030100030"];
            
        }
            break;
            
        case 1:{
            cellIdentifier = @"cell1";
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if(cell == nil){
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            NSInteger labelTag = 112;
            UILabel *label = (UILabel*)[cell.contentView viewWithTag:labelTag];
            if(label == nil){
                label = [[UILabel alloc] init];
                CGFloat x = 7;
                label.frame = CGRectMake(x, 0, (tableView.frame.size.width - 10 - x), 30);
                label.tag = labelTag;
                label.backgroundColor = [UIColor clearColor];
                label.textColor = [UIColor blackColor];
                label.font = [UIFont systemFontOfSize:12];
                
                [cell.contentView addSubview:label];
            }
            NSString *str1 = @"设备状态: 在线    电量:100%";
            label.text = str1;
//            label.text = [NSString stringWithFormat:@"%@: %@        %@: %@%%", localizedString(@"deviceStatus"), self.viewModel.deviceStauts,  localizedString(@"power"), self.viewModel.power];
            
            NSInteger label1Tag = 113;
            NSInteger label11Tag = 1131;
            UILabel *label1 = (UILabel*)[cell.contentView viewWithTag:label1Tag];
            UILabel *label11 = (UILabel*)[cell.contentView viewWithTag:label11Tag];
//            NSString *currentLocationTitle = [localizedString(@"currentLocation") stringByAppendingString:@":"];
            
            if(label1 == nil){
                label1 = [[UILabel alloc] init];
                CGFloat x = label.frame.origin.x;
                CGFloat y = CGRectGetMaxY(label.frame);
                label1.tag = label1Tag;
                label1.backgroundColor = [UIColor clearColor];
                label1.textColor = [UIColor blackColor];
                label1.font = [UIFont systemFontOfSize:13];
                label1.frame = CGRectMake(x, y, [label1 sizeThatFits:CGSizeMake(300, 20)].width, 20);
                [cell.contentView addSubview:label1];
                
                label11 = [[UILabel alloc] init];
                x = CGRectGetMaxX(label1.frame);
                label11.frame = CGRectMake(x, y, (tableView.frame.size.width - x - label11.frame.origin.x), 45);
                label11.tag = label11Tag;
                label11.backgroundColor = [UIColor clearColor];
                label11.textColor = [UIColor blackColor];
                label11.font = [UIFont systemFontOfSize:12];
                label11.lineBreakMode = NSLineBreakByWordWrapping;
                label11.numberOfLines = 0;
                [cell.contentView addSubview:label11];
            }
//            label1.text = currentLocationTitle;
//            label11.text = self.viewModel.deviceAddress;
            label.text = @"广东省";
            label11.text = @"国成工业区";
            
            NSInteger label2Tag = 114;
            UILabel *label2 = (UILabel*)[cell.contentView viewWithTag:label2Tag];
            if(label2 == nil){
                label2 = [[UILabel alloc] init];
                CGFloat x = label1.frame.origin.x;
                CGFloat y = CGRectGetMaxY(label11.frame);
                label2.frame = CGRectMake(x, y, label.frame.size.width, 30);
                label2.tag = label2Tag;
                label2.backgroundColor = [UIColor clearColor];
                label2.textColor = [UIColor blackColor];
                label2.font = [UIFont systemFontOfSize:12];
                [cell.contentView addSubview:label2];
            }
//            NSString *speedStr = [NSString stringWithFormat:@"%@: %@ km/h",localizedString(@"deviceSpeed"), self.viewModel.deviceSpeed];
//            if(self.viewModel.deviceSpeed.integerValue < 10) {
//                //speedStr = [NSString stringWithFormat:@"%@: %@",localizedString(@"deviceSpeed"), localizedString(@"static")];
//                speedStr = [NSString stringWithFormat:@"%@: %@",localizedString(@"deviceSpeed"), @"0km/h"];
//                
//            }
            
            NSString *locWayString = @"";
//            if(self.viewModel.bds.integerValue == 1) {
//                locWayString = localizedString(@"locBDS");
//            }else {
//                if(self.viewModel.locWay.integerValue == 1) {
//                    locWayString = @"GPS";
//                }else {
//                    locWayString = @"LBS";
//                }
//            }
            label2.text = @"设备速度: 0km/h    定位方式:GPS";
//            label2.text = [NSString stringWithFormat:@"%@       %@:%@", speedStr, localizedString(@"locWay"), locWayString];
            
            NSInteger label3Tag = 115;
            UILabel *label3 = (UILabel*)[cell.contentView viewWithTag:label3Tag];
            if(label3 == nil){
                label3 = [[UILabel alloc] init];
                CGFloat x = label2.frame.origin.x;
                CGFloat y = CGRectGetMaxY(label2.frame);
                label3.frame = CGRectMake(x, y, label2.frame.size.width, 30);
                label3.tag = label3Tag;
                label3.backgroundColor = [UIColor clearColor];
                label3.textColor = [UIColor blackColor];
                label3.font = [UIFont systemFontOfSize:12];
                [cell.contentView addSubview:label3];
            }
            label3.text = @"经纬度:114.069763,22.626666";
//            label3.text = [NSString stringWithFormat:@"%@: %@",localizedString(@"coordinate"),self.viewModel.deviceLocation];
            
        }
            break;
            
        case 02:
            cellIdentifier = @"cell2";
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if(cell == nil){
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                cell.textLabel.font = [UIFont systemFontOfSize:14];
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
                cell.backgroundColor = [UIColor whiteColor];
            }
            
            cell.accessoryView = nil;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        cell.textLabel.text = @"电子围栏";
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark  UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YGFenceVC *fenceVC = [[YGFenceVC alloc] init];
    [self presentViewController:fenceVC animated:YES completion:nil];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 0;
    NSInteger section = indexPath.section;
    switch (section) {
        case 0:
            height= 80;
            break;
            
        case 1:
            height= 135;
            break;
            
        case 2:
            height= 60;
            break;
            
        default:
            break;
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height = 0.1;
    if(section != 0){
        height = 35;
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

@end
