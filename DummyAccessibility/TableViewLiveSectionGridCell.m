
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
@property (nonatomic, strong) NSMutableArray *accessibilityElements;

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
       _accessibilityElements = [NSMutableArray array];
        //[self initAndConfigureGridView];
        [self initAndConfigureCollectionView];
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
    NSLog(@"GridView %p", gmGridView);
    gmGridView.dataSource = self;
    gmGridView.actionDelegate = self;
    gmGridView.mainSuperView = self;
    gmGridView.delegate = self;

//    [self setIsAccessibilityElement:NO];
//    [self.contentView setIsAccessibilityElement:NO];
//    [self.gridView setIsAccessibilityElement:NO];
}

- (void)initAndConfigureCollectionView
{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    //layout.collectionViewContentSize = CGSizeMake(196, 196 * 40);
    //CGRect size = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.height, 196 * 40);
    _collectionView=[[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    _collectionView.contentSize = CGSizeMake(196, 196 * [_collectionView numberOfItemsInSection:0]);
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    UICollectionViewFlowLayout *yourFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    [yourFlowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    _collectionView.collectionViewLayout = yourFlowLayout;
   // _collectionView.frame.size = CGSizeMake(196 *19, 196);
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    
    [_collectionView registerClass:[GridViewGeneralCellContentView class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [_collectionView setBackgroundColor:[UIColor yellowColor]];
    [self.contentView addSubview:_collectionView];

}

#pragma mark - CollectionView Delegates

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 19;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GridViewGeneralCellContentView *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
   // [NSString stringWithFormat:@"%p",cell];
    BOOL present = NO;
    NSInteger index= 0;
   
    for(int i=0; i<[_accessibilityElements count]; i++)
        if([[NSString stringWithFormat:@"%p",cell]isEqualToString:((UIAccessibilityElement *)_accessibilityElements[i]).accessibilityIdentifier] ) {
        present = YES;
            
           UIAccessibilityElement *ae; ae =_accessibilityElements[i];
            [_accessibilityElements removeObject:ae];
            index = i;
            break;
        }
  
    
    [cell configureNewsStyle];
   // CGSize size = [self UICollectionView:_collectionView layout:nil sizeForItemAtIndexPath:indexPath];
    
   // GMGridViewCell *cell = [gridView dequeueReusableCell];
    
  
       // cell = [[UICollectionViewCell alloc] init];
        cell.layer.masksToBounds = NO;
        int shadowBias = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 3 : 5;
        cell.layer.shadowOffset = CGSizeMake(shadowBias, shadowBias);
        cell.layer.shadowRadius = 5;
        cell.layer.shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 196, 196)].CGPath;
        //cell.contentView = [[GridViewGeneralCellContentView alloc] initWithFrame:cell.frame style:GridViewCellStyleNews ];
    
    

    
    Item *feedItem = _contentArray[indexPath.item];
// GridViewGeneralCellContentView *contentView = [[GridViewGeneralCellContentView alloc] initWithFrame:cell.frame style:GridViewCellStyleNews ];;
    cell.layer.shadowOpacity = 0;
    
   cell.textLabel.text = [NSString stringWithFormat:@"index- %d, %@", indexPath.item,feedItem.textLabel];
    [cell.imageView setURL:[NSURL URLWithString:feedItem.imageLink] withPreset:self.preset];
   // ((UIAccessibilityElement *)cell.accessibilityElements[0]).accessibilityLabel =[NSString stringWithFormat:@"%p, %@", cell, feedItem.textLabel];
 //   if(!present) {
     UIAccessibilityElement *ae = [[UIAccessibilityElement alloc] initWithAccessibilityContainer:collectionView];
    ae.accessibilityFrame = [self convertRect:cell.frame toView:nil];
    ae.accessibilityIdentifier = [NSString stringWithFormat: @"%p", cell];
    ae.accessibilityLabel = [NSString stringWithFormat:@"%p, %@", cell, feedItem.textLabel];
    ae.accessibilityTraits = UIAccessibilityTraitStaticText;
                  [_accessibilityElements addObject:ae];
//    } else {
       //ae = _accessibilityElements[indexPath.item];
//        ((UIAccessibilityElement *)_accessibilityElements[index]).accessibilityFrame = [self convertRect:cell.frame toView:nil];
//         ((UIAccessibilityElement *)_accessibilityElements[index]).accessibilityIdentifier = [NSString stringWithFormat: @"%p", cell];
//        ((UIAccessibilityElement *)_accessibilityElements[index]).accessibilityLabel = [NSString stringWithFormat:@"%p, %@", cell, feedItem.textLabel];
       // [_accessibilityElements replaceObjectAtIndex:index withObject:ae];
//    }
    // [cell.contentView addSubview:contentView];
    NSLog(@"Address index %d - %p: %@ acc: %p, %@", indexPath.item, cell, cell.textLabel.text, ae, NSStringFromCGRect(ae.accessibilityFrame));
    return cell;

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(190, 190);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
   
    GridViewGeneralCellContentView *cell = (GridViewGeneralCellContentView *)[collectionView cellForItemAtIndexPath:indexPath];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat: @"SELECTED %@", cell.textLabel.text]
                                                    message:@"Dee dee doo doo."
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];

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
        
    }

    Item *feedItem = _contentArray[index];
       GridViewGeneralCellContentView *contentView = (GridViewGeneralCellContentView *)cell.contentView;
    cell.layer.shadowOpacity = 0;
    
        contentView.textLabel.text = feedItem.textLabel;
    [contentView.imageView setURL:[NSURL URLWithString:feedItem.imageLink] withPreset:self.preset];
    cell.contentView = contentView;
    NSLog(@"Address index %d - %p:", index, cell);
        return cell;
}

- (void)GMGridView:(GMGridView *)gridView didTapOnItem:(GMGridViewCell *)cell atIndex:(NSInteger)position {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat: @"SELECTED %@", ((GridViewGeneralCellContentView*)cell.contentView).textLabel.text]
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

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    for (id cell in self.collectionView.visibleCells)
        if ( [cell accessibilityElementCount] >0 )
            for (int f = 0; [self accessibilityElementAtIndex:f]; f++);
    UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, nil);
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//
//#pragma mark - Accessibility methods
//

- (NSInteger)accessibilityElementCount {
    return [self.accessibilityElements count];
}

//- (id)accessibilityElementAtIndex:(NSInteger)index {
//    if (index == 0) {
//        return sub1;
//    } else if (index == 1) {
//        return sub2;
//    }
//    return nil;
//}
//
//- (NSInteger)indexOfAccessibilityElement:(id)element {
//    if (element == sub1) {
//        return 0;
//    } else if (element == sub2) {
//        return 1;
//    }
//    return NSNotFound;
//}
- (BOOL)isAccessibilityElement {
    return NO;
}
//
//- (NSInteger)accessibilityElementCount
//{
//    return [self.accessibilityElements count];
//}
//
- (id)accessibilityElementAtIndex:(NSInteger)index
{
    NSInteger aCount = 0;
    if (_accessibilityElements)
        aCount = _accessibilityElements.count;
    if (index < aCount)
    {
        if (_accessibilityElements)
        {
            UIAccessibilityElement *ae = _accessibilityElements[index];
//            CGRect visibleRect = [self convertRect:_gridView.bounds toView:self.window];
//            CGPoint a = ae.accessibilityActivationPoint;
//            for (UIAccessibilityElement *acElement in self.accessibilityElements) {
//                if(CGRectIntersectsRect(acElement.accessibilityFrame, visibleRect))
//            [self _recalculateAccessibilityElementByIndex:index];
//            }
//            UIAccessibilityElement *element = _accessibilityElements[index];
//            CGRect rect = element.accessibilityFrame;
//            element.accessibilityFrame = [self.window
//                                          convertRect:rect fromView:self];
//            return element;
            return ae;
        }
        else
        {
            return nil;
        }
    }
    else
    {
//        NSInteger subViewIndex = index - aCount;
//        if (self.subviews.count>0)
//        {
//            if (subViewIndex < self.subviews.count)
//            {
//                UIView *aView =  self.subviews[subViewIndex] ;
//                return aView;
//            }
//            else
//            {
//                return nil;
//            }
//        }
//        else
//        {
            return nil;
        }
//    }
}

- (void) _recalculateAccessibilityElementByIndex: (NSInteger) index
{
    UIAccessibilityElement *ae = _accessibilityElements[index];
    NSIndexPath *one = [NSIndexPath indexPathForItem:index inSection:0];
    GridViewGeneralCellContentView *theCell = (GridViewGeneralCellContentView *)[_collectionView cellForItemAtIndexPath:one];
    CGRect theFrame = theCell.frame;
    ae.accessibilityFrame = [self.window convertRect:theFrame fromView:self.superview];
    
}


- (NSInteger)indexOfAccessibilityElement:(id)element
{
    NSInteger anIndex = NSNotFound;
    if (_accessibilityElements)
    {
        anIndex = [_accessibilityElements indexOfObject:element];
    }
    if (anIndex == NSNotFound)
    {
        anIndex = [self.subviews indexOfObject:element];
        if (anIndex != NSNotFound)
        {
            anIndex += [self accessibilityElementCount];
        }
    }
       return anIndex;
}


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


@end
