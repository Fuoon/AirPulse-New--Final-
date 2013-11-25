//
//  CustomTextViewController.m
//  commentTest
//
//  Created by Ronnakrit Kunaviriyasiri on 10/24/2556 BE.
//  Copyright (c) 2556 Ronnakrit Kunaviriyasiri. All rights reserved.
//

#import "CustomTextViewController.h"

@interface CustomTextViewController ()
@property (strong, nonatomic) IBOutlet UIView *backgroungView;


@end

@implementation CustomTextViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.backgroungView setBackgroundColor:[UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1]];
    [self.textField setDelegate:self];
    [self.postBtn setTitleColor:[UIColor lightTextColor] forState:UIControlStateNormal];
    [self.postBtn setEnabled:NO];
    [self.postBtn setBackgroundColor:[UIColor clearColor]];
    [self.view setOpaque:NO];
    [self.textField setBackgroundColor:[UIColor whiteColor]];
    [self.view setBackgroundColor:[UIColor clearColor]];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addView:(UIView *)targetView{
    [targetView addSubview:self.view];
}

-(void)addSubView:(UIView *)targetView{
    [self.view addSubview:targetView];
}

-(NSString *)getText{
    return self.textField.text;
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self.postBtn setTitleColor:[UIColor lightTextColor] forState:UIControlStateNormal];
    [self.postBtn setEnabled:NO];

    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    [self.postBtn setTitleColor:[UIColor lightTextColor] forState:UIControlStateNormal];
    [self.postBtn setEnabled:NO];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    [self.postBtn setTitleColor:[UIColor colorWithRed:0.121653f green:0.558395f blue:0.837748f alpha:1.0f] forState:UIControlStateNormal];
    [self.postBtn setEnabled:YES];
    
    if(self.textField.text.length <= 1 && [string isEqualToString:@""]){
        [self.postBtn setTitleColor:[UIColor lightTextColor] forState:UIControlStateNormal];
        [self.postBtn setEnabled:NO];
    }
    
    return YES;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.delegate submitTextChanges];
    [self.textField resignFirstResponder];
    return YES;
}

- (IBAction)submitText:(id)sender {
    [self.textField resignFirstResponder];
    [self.delegate submitTextChanges];
}

@end
