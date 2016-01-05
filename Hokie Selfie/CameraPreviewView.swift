//
//  CameraPreviewView.swift
//  Hokie Selfie
//
//  Created by Douglas Mead on 8/10/15.
//  Copyright (c) 2015 Ok Doug. All rights reserved.
//

import UIKit
import AVFoundation

class CameraPreviewView: UIView {
    
    //MARK: Properties
    //delegate
    var delegate: CameraPreviewViewDelegate? //TODO: make weak?
    
    //MARK: Methods
    //starts camera
    //get current
    //change front and back
    //take picture
    //init with frame
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCamera(AVCaptureDevicePosition.Front)
    }
    
    init(frame: CGRect, delegate: CameraPreviewViewDelegate) {
        super.init(frame: frame)
        self.delegate = delegate
        setUpCamera(AVCaptureDevicePosition.Front)
    }
    
    //MARK: Camera Position
    private var activeCameraPosition: AVCaptureDevicePosition?
    func toggleFrontBack() {
        
        if (activeCameraPosition == AVCaptureDevicePosition.Back) {
            captureSession.removeOutput(output)
            captureSession.removeInput(input)
            previewLayer?.removeFromSuperlayer()
            
            captureSession.stopRunning()
            
            setUpCamera(AVCaptureDevicePosition.Front)
        } else {
            captureSession.removeOutput(output)
            captureSession.removeInput(input)
            previewLayer?.removeFromSuperlayer()
            
            captureSession.stopRunning()
            
            setUpCamera(AVCaptureDevicePosition.Back)
        }
        
        start()
    }
    
    //MARK: Camera setup
    private var captureSession = AVCaptureSession()
    private var captureDevice: AVCaptureDevice?
    private var output: AVCaptureStillImageOutput?
    private var previewLayer: AVCaptureVideoPreviewLayer?
    private var input: AVCaptureInput?
    
    func setUpCamera(position: AVCaptureDevicePosition) {
        let devices = AVCaptureDevice.devices()
        
        for device in devices {
            if (device.hasMediaType(AVMediaTypeVideo)) {
                if(device.position == position) {
                    captureDevice = device as? AVCaptureDevice
                }
            }
        }
        
        var error: NSError?
        do {
            input = try AVCaptureDeviceInput(device: captureDevice)
        } catch let error1 as NSError {
            error = error1
            input = nil
        }
        
        if error == nil && captureSession.canAddInput(input) {
            captureSession.addInput(input)
        }
        
        
        output = AVCaptureStillImageOutput()
        output!.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
        
        captureSession.addOutput(output)
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer?.frame = self.frame
        previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        self.layer.insertSublayer(previewLayer!, atIndex: 0)
        
        activeCameraPosition = position
    }
    
    
    //MARK: start stop
    func start() {
        captureSession.startRunning()
    }
    func suspend() {
        captureSession.stopRunning()
    }
    
    //MARK: Capture image
    //camera output variables
    private var outputImageContainerView: UIView?
    var completeImage: UIImage?
    
    func captureImage() {
        var image: UIImage?
        
        //println("CameraPreviewView.captureImage")
        
        if let videoConnection = output!.connectionWithMediaType(AVMediaTypeVideo) {
            
            output!.captureStillImageAsynchronouslyFromConnection(videoConnection, completionHandler: {
                (sampleBuffer, error) in
                
                //println("Captured asynchronously")
                
                let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
                let dataProvider = CGDataProviderCreateWithCFData(imageData)
                let cgImageRef = CGImageCreateWithJPEGDataProvider(dataProvider, nil, true, CGColorRenderingIntent.RenderingIntentDefault)
                
                //mirror only if it's the rear camera
                if self.activeCameraPosition == AVCaptureDevicePosition.Front {
                    image = UIImage(CGImage: cgImageRef!, scale: 1.0, orientation: UIImageOrientation.LeftMirrored)
                } else if self.activeCameraPosition == AVCaptureDevicePosition.Back {
                    image = UIImage(CGImage: cgImageRef!, scale: 1.0, orientation: UIImageOrientation.Right)
                } else {
                    //println("using a camera not defined")
                    image = UIImage(named: "hokie")
                }
                
                //pass image to delegate for handling
                if self.delegate != nil {
                    self.delegate?.imageDidCapture(image!)
                } else {
                    //println("Error in CameraPreviewView.captureImage(). Did not set delegate")
                }
            })
            
        } else {
            //for simulating without camera in iOS simulator
            //println("returning the hokie bird default image in CameraPreviewView.captureImage()")
            image = UIImage(named: "hokie")
            
            //pass image to delegate for handling
            if self.delegate != nil {
                self.delegate?.imageDidCapture(image!)
            } else {
                //println("Error in CameraPreviewView.captureImage(). Did not set delegate")
            }
        }
        
        //return image!
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
