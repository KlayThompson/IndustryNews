//
//  AdvertisementScrollerView.h
//  InfiniteScrollAdColumnDemo
//
//  Created by he on 14-10-29.
//  Copyright (c) 2014年 Anslink. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImageCycleScrollView;

@protocol ImageCycleScrollViewDelegate <NSObject>

@optional
-(void)ImageCycleScrollViewDidClicked:(NSUInteger)index;
- (BOOL)neeReCycleWith:(ImageCycleScrollView *)aImageCycleScrollView;

@end

@interface ImageCycleScrollView : UIView<UIScrollViewDelegate> {
	CGRect viewSize;
	NSArray *imageArray;
    NSArray *titleArray;
    UIPageControl *pageControl;
//    id<ImageCycleScrollViewDelegate> delegate;
    int currentPageIndex;
    UILabel *noteTitle;
    BOOL isShowPageControl;
}
@property(nonatomic,strong) NSTimer *timerOne;
@property(nonatomic,strong) NSTimer *timerTwo;
@property(nonatomic,strong) NSTimer *timerStop;
@property(nonatomic,strong) UIScrollView *MyScrollView;
@property(nonatomic, assign) NSInteger contentOffset;

@property(nonatomic,weak)id<ImageCycleScrollViewDelegate> delegate;

-(id)initWithFrameRect:(CGRect)rect ImageArray:(NSArray *)imgArr TitleArray:(NSArray *)titArr IsShowPageControl:(BOOL)isShow;

- (void)scrollToIndex:(NSInteger)index;

@end
