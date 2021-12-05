//
//  SchoolSatViewObjc.m
//  schools
//
//  Created by Emmanuel Oche on 12/4/21.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SchoolsSatViewObjc.h"
#import "schools-Swift.h"

@interface SchoolsSatDetailsViewController()
@property (nonatomic, strong, nonnull) NSString *schoolName;
@property SatData *satData;
@end

NS_ASSUME_NONNULL_BEGIN
@implementation SchoolsSatDetailsViewController


- (id) initWithSatDataAndSchoolName: (SatData *) satData : (NSString *) schoolName {
    if(self = [super init]){
        self.satData = satData;
        self.schoolName = schoolName;
    }
    return self;
}

- (void) viewDidLoad {
    self.navigationItem.title = @"SAT Details";
    self.navigationController.navigationBar.prefersLargeTitles = NO;
    [super viewDidLoad];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //return UITableViewAutomaticDimension;
    if (indexPath.row == 0){
        return 100;
    }
    else if (indexPath.row == 1){
        return 150;
    }
    else if (indexPath.row == 6){
        return 300;
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"SatTableId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSString *stringForCell;
    UILabel *detaiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 100, 20)];
    
    if (indexPath.row == 0) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
        label.text = self.schoolName;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont preferredFontForTextStyle: UIFontTextStyleTitle1];
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.numberOfLines = 3;
        [cell.contentView addSubview:label];
        return cell;
    }
    else if (indexPath.row == 1){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, view.frame.size.height - 80, self.view.frame.size.width, 80)];
        label.text = @"Number of Test Takers";
        label.textAlignment = NSTextAlignmentCenter;
        
        UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 80)];
        countLabel.text = self.satData.num_of_sat_test_takers;
        countLabel.font = [UIFont systemFontOfSize: 70];
        countLabel.textAlignment = NSTextAlignmentCenter;
        
        [view addSubview:label];
        [view addSubview:countLabel];
        
        [cell.contentView addSubview:view];
        return cell;
        
    }
    else if (indexPath.row == 2){
        stringForCell= @"Average Scores";
    }
    else if (indexPath.row == 3){
        
        detaiLabel.text = self.satData.sat_critical_reading_avg_score;
        stringForCell= @"SAT Critical Reading Avg. Score";

    }
    else if (indexPath.row == 4){
        stringForCell= @"SAT Math Avg. Score";
        detaiLabel.text = self.satData.sat_math_avg_score;
    }
    else if (indexPath.row == 5){
        stringForCell= @"SAT Writing Avg. Score";
        detaiLabel.text = self.satData.sat_writing_avg_score;
    }
    else if (indexPath.row == 6){
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
        detaiLabel.frame = CGRectMake(0, 10, view.frame.size.width, 50);
        detaiLabel.text = @"Proposed SAT Distribution Chart";
        detaiLabel.textAlignment = NSTextAlignmentCenter;
        
        [view addSubview:detaiLabel];
        
        UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 30, 400, 320)];
        imv.image=[UIImage imageNamed:@"chart.png"];
        [view addSubview:imv];
        
        [cell.contentView addSubview:view];
        return cell;
    }
    
    [cell.textLabel setText:stringForCell];
    detaiLabel.textAlignment = NSTextAlignmentRight;
    cell.accessoryView = detaiLabel;
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}
@end
NS_ASSUME_NONNULL_END
