//

//


#import <UIKit/UIKit.h>
#import "GMGridView.h"
#import "GMGridViewLayoutStrategies.h"
#import "WTURLImageView/WTURLImageView.h"

@interface TableViewLiveSectionGridCell : UITableViewCell <GMGridViewDataSource, GMGridViewActionDelegate, UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
{
   
    NSArray * _rssThumbnailUnderwritesOfStationLayout;
    NSInteger _numberOfItemsToFitWidth;
    UIActivityIndicatorView *_loadingIndicator;

    NSTimer *_autoscrollTimer;
    NSInteger _indexOfUnderwriting;
}
@property (nonatomic, strong) NSMutableArray *contentArray;
@property (nonatomic, strong) GMGridView *gridView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UINavigationController *navigationController;

@property (nonatomic, assign) BOOL forceToUpdate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withArray:(NSArray*)array;
- (void)initAndConfigureGridView;


@end
