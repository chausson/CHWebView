//
//  CHWebProgressView.h
//  FrameWorkPractice
//
//  Created by Chausson on 16/7/20.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHWebProgressView : UIView
@property (assign , nonatomic)float springVelocity;
@property (assign , nonatomic)float springSpeed;
@property (strong , nonatomic)NSProgress *progress; // change Progress  
@property (assign , nonatomic)float duration;
@property (strong , nonatomic)UIColor *color;
@end
