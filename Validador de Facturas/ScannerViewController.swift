//
//  ScannerViewController.swift
//  Validador de Facturas
//
//  Created by Juan Rodriguez Reyes on 23/01/20.
//  Copyright © 2020 Juan Rodriguez Reyes. All rights reserved.
//

import UIKit
import AVFoundation

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    @IBOutlet weak var permissionsView: UIView!
    @IBOutlet weak var permissionButton: UIButton!
    @IBOutlet weak var scannerView: UIView!
    
    
    // QR reader variables
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
       if AVCaptureDevice.authorizationStatus(for: .video) == .authorized
       {
           self.permissionsView.isHidden = true
           self.scannerView.isHidden = false
                   
           self.configureScanner()
           self.setPreviewView()
           self.startScanning()
       
       }
       else {
           self.permissionsView.isHidden = false
           self.scannerView.isHidden = true
           self.requestCameraPermissions { (granted) in
               if granted {
                   
               }
               else {
                   // Try again to get camera access
                   
               }
           }
       }
    }
    
    // Start scanning
    func startScanning() {
        if let captureSession = captureSession {
            captureSession.startRunning()
        }
    }
    
    func configureScanner() {

      guard let captureDevice = AVCaptureDevice.default(for: .video) else {
          return
      }

      var input: AVCaptureDeviceInput?
      do {
          input = try AVCaptureDeviceInput(device: captureDevice)
      } catch let error {
          print(error.localizedDescription)
      }

      guard let indeedInput = input else {
          return
      }
      captureSession = AVCaptureSession()
      captureSession!.addInput(indeedInput)

      let captureMetadataOutput = AVCaptureMetadataOutput()
      captureSession!.addOutput(captureMetadataOutput)

      captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
      captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]

      setPreviewView()
    }
    
    // Set preview layer
    func setPreviewView() {
        
        print("Setting preview layer")
        
        // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
        if let captureSession = captureSession {
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            
            DispatchQueue.main.async {
                self.videoPreviewLayer?.frame = self.scannerView.layer.bounds
                self.scannerView.layer.addSublayer(self.videoPreviewLayer!)
            }
        }
        
        
    }
    
    // Request camera access
    func requestCameraPermissions(completionHandler: @escaping(Bool)->Void) {
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
               if response {
                   //access granted
                completionHandler(true)
               } else {
                completionHandler(false)
               }
        }
    }
    
    @IBAction func onClickPermissionButton(_ sender: Any) {
        // Stop capture session
        captureSession?.stopRunning()
        
        // Close scanner view
        self.dismiss(animated: true, completion: {})
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
    // Check if the metadataObjects array is not nil and it contains at least one object.
    if metadataObjects.count == 0 {
        qrCodeFrameView?.frame = CGRect.zero
        print("No QR code is detected")
        return
    }
    
    // Get the metadata object.
    let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
    
    if metadataObj.type == AVMetadataObject.ObjectType.qr {
        // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
        let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
        qrCodeFrameView?.frame = barCodeObject!.bounds
        
        if metadataObj.stringValue != nil {
            print(metadataObj.stringValue)
        }
    }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
