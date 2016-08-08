//

//


#import "GridViewGeneralCellContentView.h"
#import "GMGridView.h"

#define kAspectRatioThreshold 1.22

NSInteger const kLiveCategoryHeight = 13;
@interface GridViewGeneralCellContentView()


@property (nonatomic, assign) CGRect imageViewRect;
@property (nonatomic, assign) CGRect overlayRect;

- (void)configureNewsStyle;


@end


@implementation GridViewGeneralCellContentView

- (void)awakeFromNib {
    [super awakeFromNib];
    if (self)
    {
//        _accessibilityElements = nil;
        
       
                [self configureNewsStyle];
    }
}

- (id)initWithCoder:(NSCoder*)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if(self)
    {
//        _accessibilityElements = nil;
        
        
        [self configureNewsStyle];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(GridViewCellStyle)style
{
    self = [super initWithFrame:frame];
    if (self)
    {
//         _accessibilityElements = nil;

        switch (style)
        {
            case GridViewCellStyleNews:
                [self configureNewsStyle];
                break;
              default:
                break;
        }
    }
    
  //  [self setIsAccessibilityElement:NO];
    return self;
}

- (void)prepareForReuse {
//    _accessibilityElements = nil;
    _textLabel = nil;
    _imageView = nil;
    NSLog(@"prepare for reuse");

}

- (void)configureNewsStyle
{
    self.backgroundColor = [UIColor clearColor];
       int padding = 2;
    NSInteger categoryTitleDelta =kLiveCategoryHeight;
        CGRect labelFrame = CGRectMake(padding, -2, self.bounds.size.width, categoryTitleDelta);
        UILabel *labelTitle = [[UILabel alloc] initWithFrame:labelFrame];
        labelTitle.backgroundColor = [UIColor clearColor];
        labelTitle.textColor = [UIColor redColor];
        labelTitle.numberOfLines = 1;
        self.categoryLabel = labelTitle;
        [self addSubview:labelTitle];

    
    CGRect rectInset = CGRectMake(padding, padding + categoryTitleDelta, self.bounds.size.width - 2*padding, self.bounds.size.height - 2*padding - categoryTitleDelta);

        rectInset.origin.x -= padding / 2;
        rectInset.origin.y -= padding;
        rectInset.size.height -= 2*padding;

    
    UIView *viewInset = [[UIView alloc] initWithFrame:rectInset];
    viewInset.backgroundColor = [UIColor clearColor];
    [self addSubview:viewInset];
    
    WTURLImageView *imageView = [[WTURLImageView alloc] initWithFrame:viewInset.frame];
  
    self.imageViewRect = imageView.frame;
    imageView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:imageView];
    self.imageView = imageView;
   // self.imageView.isAccessibilityElement = NO;

    UIView *overlay = nil;
    
 
            overlay = [[UIView alloc] initWithFrame:CGRectMake(viewInset.frame.origin.x, viewInset.frame.size.height / 2 + padding + 0.75/3.0 * viewInset.frame.size.height / 2 + categoryTitleDelta, viewInset.frame.size.width, 2.25/3.0 * viewInset.frame.size.height / 2)];
     if (overlay != nil)
    {
        self.overlayRect = overlay.frame;
        overlay.backgroundColor = [UIColor blackColor];
        [self addSubview:overlay];
        
        padding = 10;
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(overlay.frame.origin.x + padding, overlay.frame.origin.y, overlay.frame.size.width - 2*padding, overlay.frame.size.height)];
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.clipsToBounds = NO;
        self.textLabel.textColor = [UIColor whiteColor];
        self.textLabel.textAlignment = NSTextAlignmentLeft;
       // int size = 15;

        self.textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        
       //[self.textLabel setIsAccessibilityElement:NO];
        [self addSubview:self.textLabel];
        self.overlayView = overlay;
    }
//    _accessibilityElements = [[NSMutableArray alloc] initWithCapacity:1];
//    UIAccessibilityElement *ae = [[UIAccessibilityElement alloc] initWithAccessibilityContainer:self];
//    ae.accessibilityFrame = [self convertRect:self.frame toView:nil];
//    //ae.accessibilityLabel = self.textLabel.text;
//    [_accessibilityElements addObject:ae];

}
-(void)dealloc
{
    
//    _accessibilityElements = nil;
}


#pragma mark - Accessibility methods

// method 1 - cell is container

//- (void) _recalculateAccessibilityElements
//{
//    if (_accessibilityElements)
//    {
//        for (int i=0; i<_accessibilityElements.count; i++)
//        {
//            UIAccessibilityElement *ae = _accessibilityElements[i];
//                       ae.accessibilityFrame = [self convertRect:self.frame toView:nil];
//        }
//    }
//}
//
//- (void) _recalculateAccessibilityElementByIndex: (NSInteger) index
//{
//    UIAccessibilityElement *ae = _accessibilityElements[index];
//   // PKLabel *theLabel = _labels[index];
//    CGRect theFrame = self.frame;
//    ae.accessibilityFrame = [self.window convertRect:theFrame fromView:self];
//    
//}
//
//- (NSInteger) accessibilityElementCount
//{
//    //NSLog (@"Accessibility Count: %i", [_labels count] + [self.subviews count]);
//    if (_accessibilityElements)
//        return [_accessibilityElements count];
//    else
//        return nil;
//}
//
//- (id) accessibilityElementAtIndex:(NSInteger)index
//{
//    //NSLog (@"accessibilityElementAtIndex: %i", index);
//    NSInteger aCount = 0;
//    if (_accessibilityElements)
//        aCount = _accessibilityElements.count;
//    
//    if (index < aCount)
//    {
//        if (_accessibilityElements)
//        {
//            UIAccessibilityElement *ae = _accessibilityElements[index];
//            [self _recalculateAccessibilityElementByIndex:index];
//            return ae;
//        }
//        else
//        {
//            return nil;
//        }
//    }
//    else
//    {
//        return nil;
//    }
//}
//
//- (NSInteger) indexOfAccessibilityElement:(id)element
//{
//    //NSLog ( @"indexOfAccessibilityElement: %@", [((UIView *)element) description]);
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
//    return anIndex;
//    
//}

//- (BOOL)isAccessibilityElement
//{
//    return YES;
//}

//method 2 cell is initial Accessible

//- (NSString *)accessibilityLabel {
//    return [NSString stringWithFormat:@"%p, %@", self, self.textLabel.text];
//}
//
//- (UIAccessibilityTraits)accessibilityTraits {
//    return UIAccessibilityTraitStaticText;  // Or some other trait that fits better
//}

//- (void)accessibilityElementDidBecomeFocused
//{
//    UICollectionView *collectionView = (UICollectionView *)self.superview;
////    [collectionView scrollToItemAtIndexPath:[collectionView indexPathForCell:self] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally|UICollectionViewScrollPositionCenteredVertically animated:NO];
//    UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, self);
//}

@end
