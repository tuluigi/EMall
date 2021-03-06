//
//  OCPageLoadViewHeader.h
//  OpenCourse
//
//  Created by Luigi on 15/8/31.
//
//

#ifndef OpenCourse_OCPageLoadViewHeader_h
#define OpenCourse_OCPageLoadViewHeader_h

@class OCPageLoadView;
@protocol OCPageLoadViewDelegate <NSObject>
@optional
-(void)ocPageLoadView:(OCPageLoadView *)loadView  willMoveToSuperView:(UIView *)aSuperView;
-(void)ocPageLoadView:(OCPageLoadView *)loadView  didMoveToSuperView:(UIView *)aSuperView;
-(void)ocPageLoadView:(OCPageLoadView *)loadView  willDismisFromSuperView:(UIView *)aSuperView;
-(void)ocPageLoadView:(OCPageLoadView *)loadView  didDismissFormSuperView:(UIView *)aSuperView;
- (void)ocPageLoadDidTapLoadView:(OCPageLoadView *)loadView;//点击了页面

/**
 *  屏幕被点击的
 */
-(void)ocPageLoadedViewOnTouced;

@end

#endif
