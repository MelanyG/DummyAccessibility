
//


#import <UIKit/UIKit.h>

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

@interface GridViewGeneralCellContentView : UIView

@property (nonatomic) GridViewCellStyle cellStyle;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *overlayView;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UILabel *categoryLabel;
@property (nonatomic, strong) UIImageView *transparentImageView;
@property (nonatomic, strong) NSMutableArray *accessibilityElements;

- (instancetype)initWithFrame:(CGRect)frame style:(GridViewCellStyle)style;
- (NSInteger)calculateNumberOfLineBasedOn:(StationLayout *)stationLayout;
//- (void)configureImageViewFrameForImage:(UIImage *)image;
- (void) _recalculateAccessibilityElements;
@end
