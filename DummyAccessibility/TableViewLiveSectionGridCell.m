
//


#import <QuartzCore/QuartzCore.h>
#import "TableViewLiveSectionGridCell.h"
#import "Item.h"
#import "GridViewGeneralCellContentView.h"

typedef NS_ENUM(NSUInteger, AutoSctollDirection)
{
    AutoSctollDirectionLeft,
    AutoSctollDirectionRight
};

@interface TableViewLiveSectionGridCell ()
{

}
@property (strong, nonatomic) WTURLImageViewPreset *preset;
@property (nonatomic) NSInteger indexOfAutoScroll;
@property (nonatomic) BOOL userScrollAction;
@property (nonatomic) AutoSctollDirection autoSctollDirection;
@property (nonatomic, strong) UIImage *stationLayoutImageOverlay;
@property (nonatomic) BOOL isAddOneUnderwritingItem;
//@property (nonatomic, strong) NSMutableArray *accessibilityElements;

- (void)initAndConfigureGridView;



@end


@implementation TableViewLiveSectionGridCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withArray:(NSArray*)array
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _contentArray = [NSMutableArray array];
        _contentArray = (NSMutableArray *)array;
//        _accessibilityElements = [NSMutableArray array];
        [self initAndConfigureGridView];
    }
     return self;
}

- (void)initAndConfigureGridView
{
    GMGridView *gmGridView = [[GMGridView alloc] initWithFrame:self.bounds];
    gmGridView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    gmGridView.style = GMGridViewStylePush;
    gmGridView.minEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    gmGridView.centerGrid = YES;
    gmGridView.showsVerticalScrollIndicator = NO;
    gmGridView.showsHorizontalScrollIndicator = YES;
    gmGridView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, -2, 0);
    
        gmGridView.itemSpacing = 15;
        gmGridView.layoutStrategy = [GMGridViewLayoutStrategyFactory strategyFromType:GMGridViewLayoutHorizontal];

//[gmGridView setIsAccessibilityElement:NO];
    [self.gridView removeFromSuperview];
    self.gridView = gmGridView;
    [self.contentView addSubview:gmGridView];
    
    gmGridView.dataSource = self;
    gmGridView.actionDelegate = self;
    gmGridView.mainSuperView = self;
    gmGridView.delegate = self;

//    [self setIsAccessibilityElement:NO];
//    [self.contentView setIsAccessibilityElement:NO];
//    [self.gridView setIsAccessibilityElement:NO];
}


#pragma mark - GMGridView Delegates

- (NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    return  19;
}

- (CGSize)GMGridView:(GMGridView *)gridView sizeForItemsInInterfaceOrientation:(UIInterfaceOrientation)orientation
{


    return CGSizeMake(196, 196);
}

- (GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
{
    CGSize size = [self GMGridView:gridView sizeForItemsInInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    
   GMGridViewCell *cell = [gridView dequeueReusableCell];
    
    if (!cell)
    {
        cell = [[GMGridViewCell alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        cell.layer.masksToBounds = NO;
        int shadowBias = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 3 : 5;
        cell.layer.shadowOffset = CGSizeMake(shadowBias, shadowBias);
        cell.layer.shadowRadius = 5;
        cell.layer.shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, size.width, size.height)].CGPath;
        cell.contentView = [[GridViewGeneralCellContentView alloc] initWithFrame:cell.frame style:GridViewCellStyleNews ];
//            UIAccessibilityElement *ae = [[UIAccessibilityElement alloc] initWithAccessibilityContainer:self];
//          [_accessibilityElements addObject:ae];
        NSLog(@"Address %p:", cell);
    }

    Item *feedItem = _contentArray[index];
       GridViewGeneralCellContentView *contentView = (GridViewGeneralCellContentView *)cell.contentView;
    cell.layer.shadowOpacity = 0;

        contentView.textLabel.text = feedItem.textLabel;
    [contentView.imageView setURL:[NSURL URLWithString:feedItem.imageLink] withPreset:self.preset];
    cell.contentView = contentView;
     return cell;
}

- (void)GMGridView:(GMGridView *)gridView didTapOnItem:(GMGridViewCell *)cell atIndex:(NSInteger)position {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"SELECTED"
                                                    message:@"Dee dee doo doo."
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

#pragma mark - SetUp WTURLImageView method

- (void)setUpWTURLImageView {
    self.preset = [WTURLImageViewPreset defaultPreset];
    WTURLImageViewOptions options = self.preset.options;
    options |= (WTURLImageViewOptionShowActivityIndicator | WTURLImageViewOptionAnimateEvenCache | WTURLImageViewOptionsLoadDiskCacheInBackground | WTURLImageViewOptionDontClearImageBeforeLoading);
    self.preset.options = options;
    self.preset.fillType = UIImageResizeFillTypeFitIn;
}

#pragma mark - UIScrollView Delegate

//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    if (self.stationLayout.autoscrollDelay)
//    {
//        [self stopTimer];
//    }
//    [[NSNotificationCenter defaultCenter] postNotificationName:kKillScrollingNotificationName object:nil];
//}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Accessibility methods
//
//- (BOOL)isAccessibilityElement {
//    return NO;
//}

//- (NSInteger)accessibilityElementCount
//{
//    return [self.accessibilityElements count];
//}
//
//- (id)accessibilityElementAtIndex:(NSInteger)index
//{
//    NSInteger aCount = 0;
//    if (_accessibilityElements)
//        aCount = _accessibilityElements.count;
//    if (index < aCount)
//    {
//        if (_accessibilityElements)
//        {
//            UIAccessibilityElement *ae = _accessibilityElements[index];
////            CGRect visibleRect = [self convertRect:_gridView.bounds toView:self.window];
////            CGPoint a = ae.accessibilityActivationPoint;
////            for (UIAccessibilityElement *acElement in self.accessibilityElements) {
////                if(CGRectIntersectsRect(acElement.accessibilityFrame, visibleRect))
//                    [self recalculateAccessibilityElementByIndex:index];
////            }
////            UIAccessibilityElement *element = _accessibilityElements[index];
////            CGRect rect = element.accessibilityFrame;
////            element.accessibilityFrame = [self.window
////                                          convertRect:rect fromView:self];
////            return element;
//            return ae;
//        }
//        else
//        {
//            return nil;
//        }
//    }
//    else
//    {
////        NSInteger subViewIndex = index - aCount;
////        if (self.subviews.count>0)
////        {
////            if (subViewIndex < self.subviews.count)
////            {
////                UIView *aView =  self.subviews[subViewIndex] ;
////                return aView;
////            }
////            else
////            {
////                return nil;
////            }
////        }
////        else
////        {
//            return nil;
//        }
////    }
//}
//
//- (NSInteger)indexOfAccessibilityElement:(id)element
//{
//    NSInteger anIndex = NSNotFound;
//    if (_accessibilityElements)
//    {
//        anIndex = [_accessibilityElements indexOfObject:element];
//    }
//    if (anIndex == NSNotFound)
//    {
//        anIndex = [self.subviews indexOfObject:element];
//        if (anIndex != NSNotFound)
//        {
//            anIndex += [self accessibilityElementCount];
//        }
//    }
//       return anIndex;
//}
//
//- (void)recalculateAccessibilityElementByIndex:(NSInteger)index {
//    UIAccessibilityElement *ae = _accessibilityElements[index];
//    CGPoint point = ae.accessibilityActivationPoint;
//    GMGridViewCell * cell =[self.gridView cellForItemAtIndex:index];
//    //PKLabel *theLabel = _labels[index];
//    if(!cell) {
//        CGRect tmp =  CGRectMake(((UIAccessibilityElement *)_accessibilityElements[index]).accessibilityFrame.origin.x * (-1),((UIAccessibilityElement *)_accessibilityElements[index]).accessibilityFrame.origin.y, ((UIAccessibilityElement *)_accessibilityElements[index]).accessibilityFrame.size.width, ((UIAccessibilityElement *)_accessibilityElements[index]).accessibilityFrame.size.height);
//        ae.accessibilityFrame = tmp;
//        ((UIAccessibilityElement *)_accessibilityElements[index]).accessibilityIdentifier = NSStringFromCGRect(tmp);
//    } else {
//    CGRect theFrame = [self convertRect:cell.frame fromView:nil];
//     CGRect newFrame =  CGRectMake(theFrame.origin.x, ae.accessibilityFrame.origin.y, ae.accessibilityFrame.size.width, ae.accessibilityFrame.size.height);
//        ae.accessibilityFrame = newFrame;
//((UIAccessibilityElement *)_accessibilityElements[index]).accessibilityIdentifier = NSStringFromCGRect(newFrame);
//    }
//    
////    if(theFrame.size.width) {
////    ae.accessibilityFrame = theFrame;
//     //   ((UIAccessibilityElement *)_accessibilityElements[index]).accessibilityIdentifier = NSStringFromCGRect(theFrame);
////    }
//    NSLog(@"%d %@ - %@", index, ae.accessibilityLabel, NSStringFromCGRect(ae.accessibilityFrame));
////    
////GMGridViewCell * cell =[self.gridView cellForItemAtIndex:index];
////    CGRect rexr = [self convertRect:cell.frame toView:nil];
////    ((UIAccessibilityElement *)_accessibilityElements[index]).accessibilityFrame = CGRectMake(cell.frame.size.width * index + 5 + 15 * index, rexr.origin.y  , cell.contentView.frame.size.width, cell.contentView.frame.size.height);
//
//}
//
//
@end
