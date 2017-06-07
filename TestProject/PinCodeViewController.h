//
//  PinCodeViewController.h
//  LanguagePalProiPad
//
//  Copyright © 2016 Thornton Media, Inc. All rights reserved.

#import <UIKit/UIKit.h>

#import "BaseViewController.h"

// These codes user needs to enter to unlock the app
#define APPLICATION_ACCESS_CODE @"1234"
#define APPLICATION_PIN_CODE    @"5678"


#define RECIPIENT_EMAIL @"kara@ndnlanguage.com"
#define MESSAGE_SUBJECT @"Request for access code and pin for language app"


#pragma mark -
#pragma mark PinCodeViewController interface


@interface PinCodeViewController : BaseViewController

+ (BOOL) applicationIsLocked;

@end
