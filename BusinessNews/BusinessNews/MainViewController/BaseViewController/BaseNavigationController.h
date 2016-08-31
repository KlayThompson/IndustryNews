//
//  BaseNavigationController.h
//  YouPlay
//
//  Created by 小白 on 13-8-21.
//  Copyright (c) 2013年 邱新鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Orientations)
-(BOOL)shouldAutorotate;
-(NSUInteger)supportedInterfaceOrientations;
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation;

@end

@implementation UINavigationController (Orientations)
-(BOOL)shouldAutorotate
{
    return [[self topViewController] shouldAutorotate];
}
-(NSUInteger)supportedInterfaceOrientations

{
    return [[self topViewController] supportedInterfaceOrientations];
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation

{
    return [[self topViewController] preferredInterfaceOrientationForPresentation];
}
@end





@interface BaseNavigationController : UINavigationController

@end



