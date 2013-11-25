//
//  CustomTextViewController.h
//  commentTest
//
//  Created by Ronnakrit Kunaviriyasiri on 10/24/2556 BE.
//  Copyright (c) 2556 Ronnakrit Kunaviriyasiri. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CustomTextViewControllerDelegate
-(void)submitTextChanges;
@end

@interface CustomTextViewController : UIViewController <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UIButton *postBtn;
- (IBAction)submitText:(id)sender;
-(NSString *)getText;
@property (strong, nonatomic) id delegate;
-(void)addView:(UIView *)targetView;
-(void)addSubView:(UIView *)targetView;
@end
