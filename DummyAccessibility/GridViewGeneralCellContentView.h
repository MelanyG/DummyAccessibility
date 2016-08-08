
//


#import <UIKit/UIKit.h>
#import "WTURLImageView/WTURLImageView.h"

@class StationLayout;
@class URLImageView;

typedef NS_ENUM(NSInteger, GridViewCellStyle)
{
    GridViewCellStyleNews,
    GridViewCellStyleOnDemand,
    GridViewCellStyleOnDemandCove,
    GridViewCellStyleFavorite,
    GridViewCellStyleAddFavoriteItem
};

@interface GridViewGeneralCellContentView : UICollectionViewCell

@property (nonatomic) GridViewCellStyle cellStyle;
@property (nonatomic, strong) WTURLImageView *imageView;
@property (nonatomic, strong) UIView *overlayView;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UILabel *categoryLabel;
@property (nonatomic, strong) WTURLImageView *transparentImageView;
//@property (nonatomic, strong) NSMutableArray *accessibilityElements;

- (instancetype)initWithFrame:(CGRect)frame style:(GridViewCellStyle)style;
- (void)configureNewsStyle;
//- (void) _recalculateAccessibilityElements;
@end
