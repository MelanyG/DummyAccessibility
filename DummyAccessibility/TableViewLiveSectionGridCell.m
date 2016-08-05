
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
//    NSMutableArray *_contentArray;
//    NSArray * _rssThumbnailUnderwritesOfStationLayout;
//    NSInteger _numberOfItemsToFitWidth;
//    UIActivityIndicatorView *_loadingIndicator;
//    
//    NSTimer *_autoscrollTimer;
//    NSInteger _indexOfUnderwriting;
    NSDate *pauseStart;
    NSDate *previousFireDate;
    CGRect _visibleRect;
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

//- (void)setStationLayout:(StationLayout *)stationLayout
//{
//    if (stationLayout.identificator != _stationLayout.identificator || self.forceToUpdate)
//    {
//        self.userScrollAction = NO;
//        if (stationLayout.underwritingAdFrequency > 0 && stationLayout.underwritingAdInitial > 0) {
//            UnderwritingManager *underwriteManager = [UnderwritingManager sharedManager];
//            _rssThumbnailUnderwritesOfStationLayout = underwriteManager.rssThumbnailUnderwrites;
//            _indexOfUnderwriting = stationLayout.underwritingAdInitial - 1;
//            self.isAddOneUnderwritingItem = NO;
//        } else if (stationLayout.underwritingAdFrequency == 0 && stationLayout.underwritingAdInitial > 0) {
//            UnderwritingManager *underwriteManager = [UnderwritingManager sharedManager];
//            _rssThumbnailUnderwritesOfStationLayout = underwriteManager.rssThumbnailUnderwrites;
//            _indexOfUnderwriting = stationLayout.underwritingAdInitial - 1;
//            self.isAddOneUnderwritingItem = YES;
//        }
//        else{
//            _rssThumbnailUnderwritesOfStationLayout = nil;
//            _indexOfUnderwriting = NSNotFound;
//            self.isAddOneUnderwritingItem = NO;
//        }
//        
//        [_loadingIndicator stopAnimating];
//        _stationLayout = stationLayout;
//        
//        NSInteger delta = 10;
//        if (_loadingIndicator == nil)
//        {
//            _loadingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//            _loadingIndicator.hidesWhenStopped = YES;
//            _loadingIndicator.autoresizingMask = UIViewAutoresizingNone;
//            if ([RBMConfig sharedConfiguration].activityIndicatorColor) {
//                [_loadingIndicator setColor:[RBMConfig sharedConfiguration].activityIndicatorColor];
//            }
//        }
//        
//        UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
//        if (orientation == UIInterfaceOrientationPortrait)
//        {
//            _loadingIndicator.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, self.stationLayout.displayStyleSize.height * self.stationLayout.verticalCount / 2 + delta);
//        }
//        else
//        {
//            _loadingIndicator.center = CGPointMake([UIScreen mainScreen].bounds.size.height / 2, self.stationLayout.displayStyleSize.height * self.stationLayout.verticalCount / 2 + delta);
//        }
//        
//        [_autoscrollTimer invalidate];
//        
//        [self addSubview:_loadingIndicator];
//        [_loadingIndicator startAnimating];
//        
//        NSInteger count = _contentArray.count;
//        for (NSInteger i = (count - 1); i >= 0; i--)
//        {
//            [self.gridView removeObjectAtIndex:i animated:NO];
//        }
//
//        [_contentArray removeAllObjects];
//        
//        [self initAndConfigureGridView];
//        _numberOfItemsToFitWidth = [self calculateNumberOfItemsToFitWidth];
//        
//        if (self.stationLayout.fitWidth)
//        {
//            NSInteger screenWidth = [UIScreen mainScreen].bounds.size.width;
//            NSInteger itemsWidthForOneRow = (_numberOfItemsToFitWidth % 2) == 0 ? (_numberOfItemsToFitWidth / self.stationLayout.verticalCount) : (_numberOfItemsToFitWidth / self.stationLayout.verticalCount + 1);
//            NSInteger itemsWidth = itemsWidthForOneRow * self.stationLayout.displayStyleSize.width;
//            NSInteger spacingToUse = (screenWidth - itemsWidth) / (itemsWidthForOneRow - 1 + 2); // 2 paddings: left and right
//            self.gridView.itemSpacing = spacingToUse;
//        }
//        
//        self.stationLayoutImageOverlay = nil;
//        __weak TableViewLiveSectionGridCell *weakSelf = self;
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//            NSArray *elementOverlays = [ElementOverlay elementsOfType:ElementOverlayTypeThumbnail inArray:weakSelf.stationLayout.elementOverlays];
//            NSString *overlayImageURL = nil;
//            
//            if (elementOverlays.count > 0)
//            {
//                ElementOverlay *elementOverlay = elementOverlays[0];
//                overlayImageURL = elementOverlay.value;
//                if (overlayImageURL != nil && overlayImageURL.length > 0)
//                {
//                    CGSize size = [weakSelf GMGridView:nil sizeForItemsInInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
//                    CGSize desiredSize = weakSelf.stationLayout.displayStyleSizeForThumbnail;
//                    if (weakSelf.stationLayout.showCategoryName)
//                    {
//                        desiredSize.height -= kLiveCategoryHeight;
//                        desiredSize.width = (kLiveCategoryHeight % 2 == 0) ? desiredSize.width : desiredSize.width + 1;
//                    }
//                    TextOverlayPosition textOverlayPosition = weakSelf.stationLayout.textOverlayPosition;
//                    NSString *overlayPositionAsString = [StationLayout getStringRepresentationOfTextOverlayPosition:textOverlayPosition];
//                    NSInteger heightCheck = [StationLayout getCorrectHeightCheckRegardingTextOverlayPosition:textOverlayPosition];
//                    if (textOverlayPosition == TextOverlayPositionBelow)
//                    {
//                        desiredSize.height -= (size.height);
//                        desiredSize.width += (1.75*size.height);
//                    }
//                    
//                    NSString *finalImageURL = nil;
//                    NSMutableString *postXML = nil;
//                    postXML = [NSMutableString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"UTF-8\"?><resize>"];
//                    [postXML appendFormat:@"<width type=\"integer\">%ld</width>", (long)desiredSize.width];
//                    [postXML appendFormat:@"<height type=\"integer\">%ld</height>", (long)desiredSize.height];
//                    [postXML appendFormat:@"<heightcheck type=\"integer\">%ld</heightcheck>", (long)heightCheck];
//                    [postXML appendFormat:@"<justify>%@</justify>", overlayPositionAsString];
//                    [postXML appendFormat:@"<url>%@</url>", [NSString stringWithFormat:@"<![CDATA[%@]]>", overlayImageURL]];
//                    [postXML appendFormat:@"</resize>"];
//                    finalImageURL = [NSString stringWithFormat:@"%@resizer/%@", [RBMConfig sharedConfiguration].resizerURL, [postXML stringFromMD5]];
//                    NSURL *urlToSend = [NSURL URLWithString:finalImageURL];
//                    
//                    //Response data object
//                    NSData *returnData = [[NSData alloc]init];
//                    //Build the Request
//                    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:urlToSend];
//                    [request setHTTPMethod:@"POST"];
//                    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[postXML length]] forHTTPHeaderField:@"Content-length"];
//                    [request setHTTPBody:[postXML dataUsingEncoding:NSUTF8StringEncoding]];
//                    
//                    //Send the Request
//                    NSHTTPURLResponse* response = nil;
//                    NSError *error = nil;
//                    returnData = [NSURLConnection sendSynchronousRequest: request returningResponse:&response error:&error];
//                    if (error == nil && response.statusCode == 200) {
//                        weakSelf.stationLayoutImageOverlay = [UIImage imageWithData:returnData];
//                    }
//                }
//            }
//            
//            NSUserDefaults *userSetting = [NSUserDefaults standardUserDefaults];
//            NSDictionary * authorizationSettings = [userSetting objectForKey:kAuthorizationSettingsKey];
//            MWFeedParser *parser;
//            if (authorizationSettings && weakSelf.stationLayout.authenticateMode == DisplayModeAuthenticated)
//            {
//                NSString *base64EncodedCredentials = [weakSelf prepareAuthorizationStringForUser:[authorizationSettings objectForKey:kAuthorizationKeyEmail] andPassword:[authorizationSettings objectForKey:kAuthorizationKeyPassword]];
//                parser = [[MWFeedParser alloc] initWithFeedURL:[NSURL URLWithString:weakSelf.stationLayout.feedURL] andAuthorizationString:base64EncodedCredentials];
//            } else if ([Utility isAllowToShowAuthenticatedLayout] && weakSelf.stationLayout.authenticateMode == DisplayModeAuthenticated) {
//                NSString *base64EncodedCredentials = [weakSelf prepareAuthorizationStringForUser:[RBMConfig sharedConfiguration].accountAuthenticatedLayout andPassword:[RBMConfig sharedConfiguration].passwordAuthenticatedLayout];
//                parser = [[MWFeedParser alloc] initWithFeedURL:[NSURL URLWithString:weakSelf.stationLayout.feedURL] andAuthorizationString:base64EncodedCredentials];
//            } else {
//                parser = [[MWFeedParser alloc] initWithFeedURL:[NSURL URLWithString:weakSelf.stationLayout.feedURL]];
//            }
//            parser.delegate = weakSelf;
//            parser.feedParseType = ParseTypeFull;
//            parser.connectionType = ConnectionTypeSynchronously;
//            [parser parse];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                weakSelf.forceToUpdate = NO;
//                [_loadingIndicator stopAnimating];
//            	[_loadingIndicator removeFromSuperview];
//                
//                if (stationLayout.autoscrollDelay)
//                {
//                    weakSelf.indexOfAutoScroll = 0;
//                    weakSelf.autoSctollDirection = AutoSctollDirectionRight;
//                    [weakSelf startTimer];
//                }
//            });
//        });
//    }
//}

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

#pragma mark - MWFeedParser Delegate
//
//- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item
//{
//    if (_contentArray.count >= kMaxNewsItems || (self.stationLayout.fitWidth && _contentArray.count >= _numberOfItemsToFitWidth))
//    {
//        [self feedParserDidFinish:parser];
//        [parser stopParsing];
//    }
//    else
//    {
//        __weak TableViewLiveSectionGridCell *weakSelf = self;
//        
//        if (item.vimeoID > 0) {
//            NSString *host = [NSString stringWithFormat:@"http://vimeo.com/api/v2/video/%d.json",item.vimeoID ];
//            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:host]];
//            [request setHTTPMethod:@"GET"];
//            NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//            if (returnData != nil) {
//                NSArray *result = [NSJSONSerialization JSONObjectWithData:returnData options:0 error:nil];
//                if (result != nil) {
//                    NSDictionary *videoInfo = [result objectAtIndex:0];
//                    NSString *urlThumbnail = [videoInfo objectForKey:@"thumbnail_large"];
//                    if (urlThumbnail != nil && urlThumbnail.length > 0) {
//                        urlThumbnail = [videoInfo objectForKey:@"thumbnail_medium"];
//                    }else if (urlThumbnail != nil && urlThumbnail.length > 0) {
//                        urlThumbnail = [videoInfo objectForKey:@"thumbnail_large"];
//                    }else if (urlThumbnail != nil && urlThumbnail.length > 0) {
//                        urlThumbnail = nil;
//                    }
//                    item.thumbnailUrl = urlThumbnail;
//                }
//                
//            }
//            
//        }
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            
//            
//            if ((_stationLayout.underwritingAdFrequency > 0 || weakSelf.isAddOneUnderwritingItem) && _rssThumbnailUnderwritesOfStationLayout.count > 0) {
//                BOOL isAddUnderwriting = NO;
//                if (_indexOfUnderwriting != NSNotFound) {
//                    if (_contentArray.count > 0) {
//                        if (_contentArray.count % _indexOfUnderwriting == 0) {
//                            isAddUnderwriting = YES;
//                        }
//                    } else if (_contentArray.count == 0 && _indexOfUnderwriting == 0) {
//                        isAddUnderwriting = YES;
//                    }
//                        
//                }
//                
//                if (isAddUnderwriting)
//                {
//                    Underwriting *underwriting;
//                    if (_stationLayout.underwritingID)
//                    {
//                        underwriting = [weakSelf getUnderwritingIfExist:_stationLayout.underwritingID];
//                    }
//                    else {
//                        underwriting = [weakSelf randomUnderwrite];
//                    }
//                    
//                    if (underwriting)
//                    {
//                        VisualAd *adOfThumbnail;
//                        NSArray *arrOfVisualAd = [Underwriting getVisualAdsWithStyle:VisualAdStyleRSSThumbnail fromArray:underwriting.visualAds];
//                        if (arrOfVisualAd.count > 0) {
//                            adOfThumbnail = [arrOfVisualAd objectAtIndex:0];
//                            MWFeedUnderwritingItem * underwritingItem;
//                            
//                            if ([MWFeedDFPItem isUrlOfDFP:[adOfThumbnail.visualURL absoluteString]]) {
//                                underwritingItem = [[MWFeedDFPItem alloc] init];
//                            } else {
//                                underwritingItem = [[MWFeedUnderwritingItem alloc] init];
//                            }
//                            
//                            underwritingItem.underwritingID = underwriting.underwritingID;
//                            underwritingItem.title = nil;
//                            underwritingItem.link = [adOfThumbnail.clickURL absoluteString];
//                            underwritingItem.displayMethod = SelectDisplayMethodInBrowser;
//                            underwritingItem.imageURL = adOfThumbnail.visualURL;
//                            [_contentArray addObject:underwritingItem];
//                            [weakSelf.gridView insertObjectAtIndex:(_contentArray.count - 1) withAnimation:GMGridViewItemAnimationFade];
//                            [weakSelf.gridView scrollToObjectAtIndex:0 atScrollPosition:GMGridViewScrollPositionNone animated:NO];
//                            
//                            if (_stationLayout.underwritingID)
//                            {
//                                _indexOfUnderwriting = _contentArray.count + _stationLayout.underwritingAdFrequency;
//                            }
//                            else if (_stationLayout.underwritingID == 0 || _stationLayout.underwritingID == NSNotFound)
//                            {
//                                _indexOfUnderwriting = _contentArray.count + _stationLayout.underwritingAdFrequency;
//                            }
//                            
//                            if (weakSelf.isAddOneUnderwritingItem) {
//                                _indexOfUnderwriting = NSNotFound;
//                                weakSelf.isAddOneUnderwritingItem = NO;
//                            }
//                        }
//                    }
//                    else
//                    {
//                        _indexOfUnderwriting = NSNotFound;
//                    }
//                }
//                
//            }
//            [_contentArray addObject:[]];
//            [weakSelf.gridView insertObjectAtIndex:(_contentArray.count - 1) withAnimation:GMGridViewItemAnimationFade];
//            [weakSelf.gridView scrollToObjectAtIndex:0 atScrollPosition:GMGridViewScrollPositionNone animated:NO];
//        });
//    }
//    
//}
//
//- (void)feedParserDidFinish:(MWFeedParser *)parser
//{
//    [self reAdjustUnderwritingItems];
//    __weak TableViewLiveSectionGridCell *weakSelf = self;
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        [weakSelf.gridView reloadData];
//    });
//}
//
//- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error
//{
//    NSLog(@"Failed to parse news feed. %@ %@", error, [error userInfo]);
//}


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
    //static NSString *CellIdentifier = @"GenericCell";
    
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
    //contentView.transparentImageView.hidden = YES;


        contentView.textLabel.text = feedItem.textLabel;
    cell.contentView = contentView.imageView;
     return cell;
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
