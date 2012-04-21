//
//  CameraView.h
//  Splitsy
//
//  Created by Daniel Shein on 2/12/12.
//  Copyright (c) 2012 LoFT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


@interface CameraView : UIView <AVCaptureVideoDataOutputSampleBufferDelegate>
{
    AVCaptureVideoPreviewLayer *videoPreviewLayer;
    
    // Camera Variables
    AVCaptureSession *captureSession;
	AVCaptureVideoDataOutput *captureVideoDataOutput;

}

@end
