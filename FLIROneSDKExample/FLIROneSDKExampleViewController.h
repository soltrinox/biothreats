//
//  FLIROneSDKExampleViewController.h
//  FLIROneSDKExample
//
//  Created by Joseph Colicchio on 5/22/14.
//  Copyright (c) 2014 novacoast. All rights reserved.
//

#import <UIKit/UIKit.h>


#import <FLIROneSDK/FLIROneSDK.h>
//#import <FlirOneFramework/FLIROne.h>

@interface FLIROneSDKExampleViewController : UIViewController <FLIROneSDKImageReceiverDelegate, FLIROneSDKStreamManagerDelegate, FLIROneSDKVideoRendererDelegate, FLIROneSDKImageEditorDelegate>
//@interface FLIROneSDKExampleViewController : UIViewController <FLIROneDeviceDelegate>

- (IBAction)findFaces:(id)sender;
@end
