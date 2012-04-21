//
//  CameraView.m
//  Splitsy
//
//  Created by Daniel Shein on 2/12/12.
//  Copyright (c) 2012 LoFT. All rights reserved.
//

#import "CameraView.h"


@interface CameraView (Internals)
-(void)loadView;

-(BOOL)initVideoCaptureSession;
-(void)initPreviewView;
@end

@implementation CameraView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadView];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self loadView];
    }
    
    return self;
}


-(void)loadView
{
    // Create Camera Object
    if ([self initVideoCaptureSession]) {
		[captureSession startRunning];	
        [self initPreviewView];
    } else {
        //TODO: Handle Error of loading camea
    }

}


-(BOOL)initVideoCaptureSession
{
    captureSession = [[AVCaptureSession alloc] init];
    captureSession.sessionPreset = AVCaptureSessionPresetHigh;

    NSError *error;
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    
    //TODO:check for and handle error
    
    [captureSession addInput:input];
    
    captureVideoDataOutput = [[AVCaptureVideoDataOutput alloc] init];
    [captureSession addOutput:captureVideoDataOutput];
    
    dispatch_queue_t queue = dispatch_queue_create("videoThread", NULL);
    [captureVideoDataOutput setSampleBufferDelegate:self queue:queue];
    
    [captureSession startRunning];

    return YES;
}


-(void)initPreviewView
{
    videoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:captureSession];
    videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    videoPreviewLayer.frame = self.bounds;
    [self.layer addSublayer:videoPreviewLayer];
}


#pragma mark - Video Frame Delegate

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    
}

@end
