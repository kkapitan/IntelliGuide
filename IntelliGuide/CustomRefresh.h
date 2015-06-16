//
//  CustomRefresh.h
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 12.06.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomRefreshProtocol <NSObject>

-(void)didEndRefreshing;

@end


@interface CustomRefresh : UIView

-(void)animate;
@property BOOL isAnimating;
@property (nonatomic,weak) id<CustomRefreshProtocol> delegate;
@end
