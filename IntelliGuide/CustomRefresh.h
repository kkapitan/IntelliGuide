//
//  CustomRefresh.h
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 12.06.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 Protocol used to ensure that the refresh view's delegate implements required methods.
 */

@protocol CustomRefreshProtocol <NSObject>

/*!
 Method triggered when animation ends.
 */

-(void)didEndRefreshing;

@end

/*!
 Collection View controller that is responsible for populating collection view
 with proper objects (attraction images in this case).
 */

@interface CustomRefresh : UIView

///------
///@name Fields
///---

/*!
 Property informing if the refresh view is currently being animated.
 */
@property BOOL isAnimating;

/*!
 Property that stores delegate object, which is informed when refresh view ends animation.
 */
@property (nonatomic,weak) id<CustomRefreshProtocol> delegate;

///------
///@name Methods
///---

/*!
 This method starts animating the refresh view.
 */
-(void)animate;

@end
