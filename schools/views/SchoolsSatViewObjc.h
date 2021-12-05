//
//  SchoolsSatViewObjc.h
//  schools
//
//  Created by Emmanuel Oche on 12/4/21.
//

#ifndef SchoolsSatViewObjc_h
#define SchoolsSatViewObjc_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class SatData;

@interface SchoolsSatDetailsViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UITableView *satTableView;
    IBOutlet UIImageView *chartImageView;
}

- (id) initWithSatDataAndSchoolName: (SatData *) satData : (NSString *) schoolName;

@end

#endif /* SchoolsSatViewObjc_h */
