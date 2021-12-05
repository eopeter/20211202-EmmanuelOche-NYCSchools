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
@property NSString *schoolName;
@property SatData *satData;
@end

@implementation SchoolsSatDetailsViewController


- (id) initWithParams: (SatData *) param : (NSString *) schoolName {
    if(self = [super init]){
        self.satData = param;
        self.schoolName = schoolName;
    }
    return self;
}

- (void) viewDidLoad {
    self.navigationItem.title = @"SAT Details";
    [super viewDidLoad];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"SatTableId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    NSString *stringForCell;
    NSString *detailForCell = @"";
    
    if (indexPath.row == 0) {
        stringForCell= self.schoolName;
        
    }
    else if (indexPath.row == 1){
        stringForCell= @"Number of Test Takers";
        
    }
    else if (indexPath.row == 2){
        stringForCell= @"Average Scores";
    }
    else if (indexPath.row == 3){
        stringForCell= @"SAT Critical Reading Avg. Score";
        detailForCell = self.satData.sat_critical_reading_avg_score;
    }
    else if (indexPath.row == 4){
        stringForCell= @"SAT Math Avg. Score";
        detailForCell = self.satData.sat_math_avg_score;
    }
    else if (indexPath.row == 5){
        stringForCell= @"SAT Writing Avg. Score";
        detailForCell = self.satData.sat_writing_avg_score;
    }
    else if (indexPath.row == 6){
        stringForCell= @"Proposed SAT Distribution Chart";
    }
    
    [cell.textLabel setText:stringForCell];
    [cell.detailTextLabel setText:detailForCell];
    
    return cell;
}
@end
