//

//


#import <UIKit/UIKit.h>
#import "GMGridView.h"
#import "GMGridViewLayoutStrategies.h"
#import "WTURLImageView/WTURLImageView.h"

@interface TableViewLiveSectionGridCell : UITableViewCell <GMGridViewDataSource, GMGridViewActionDelegate, UIScrollViewDelegate>
{
   
    NSArray * _rssThumbnailUnderwritesOfStationLayout;
    NSInteger _numberOfItemsToFitWidth;
    UIActivityIndicatorView *_loadingIndicator;

    NSTimer *_autoscrollTimer;
    NSInteger _indexOfUnderwriting;
}
@property (nonatomic, strong) NSMutableArray *contentArray;
@property (nonatomic, strong) GMGridView *gridView;
@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) UIView *trickView;
@property (nonatomic, assign) BOOL forceToUpdate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withArray:(NSArray*)array;
- (void)initAndConfigureGridView;


@end
