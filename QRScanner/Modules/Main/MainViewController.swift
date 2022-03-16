import UIKit
import AVFoundation

class MainViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate, UIApplicationDelegate {
    
    var video = AVCaptureVideoPreviewLayer()
    
    var session = AVCaptureSession()
    
    let imageView: UIImageView = {
        let uiImageView = UIImageView()
        uiImageView.image = UIImage(named: "Square")
        return uiImageView
    }()
    
    let qrCodeFrameView: UIView = {
        let uiView = UIView()
        uiView.layer.borderWidth = 5
        uiView.layer.borderColor = UIColor.yellow.cgColor
        return uiView
    }()
    
    let qrCodeUrlButton: UIButton = {
        let uiButton = UIButton()
        uiButton.setBackgroundColor(color: .yellow, forState: .normal)
        uiButton.setBackgroundColor(color: .white.withAlphaComponent(0.5), forState: .highlighted)
        uiButton.setTitleColor(.black, for: .normal)
        uiButton.titleLabel?.textAlignment = .center
        uiButton.titleLabel?.adjustsFontSizeToFitWidth = true
        uiButton.titleLabel?.numberOfLines = 2
        uiButton.layer.cornerRadius = 10
        uiButton.layer.masksToBounds = true
        return uiButton
    }()
    
    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupVideo()
        self.view.addSubview(imageView)
        self.view.bringSubviewToFront(imageView)
        self.view.addSubview(qrCodeUrlButton)
        self.view.bringSubviewToFront(qrCodeUrlButton)
        self.qrCodeUrlButton.addTarget(self, action: #selector(click), for: .touchUpInside)
    }
    
    @objc func click() {
        guard let urlQrCode = self.url else { return }
        
        let uiAlertController = UIAlertController(title: "QR-code", message: urlQrCode, preferredStyle: .alert)
        let actionOpenUrl = UIAlertAction(title: "Open URL in browser", style: .default) { _ in
            guard let url = URL(string: urlQrCode) else { return }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        let actionCopyUrl = UIAlertAction(title: "Copy URL", style: .default) { _ in
            UIPasteboard.general.string = urlQrCode
            self.frameZero()
            self.session.startRunning()
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            self.frameZero()
            self.session.startRunning()
        }
        uiAlertController.addAction(actionOpenUrl)
        uiAlertController.addAction(actionCopyUrl)
        uiAlertController.addAction(actionCancel)
        present(uiAlertController, animated: true, completion: nil)
        self.frameZero()
        self.session.stopRunning()
    }
    
    private func setupVideo() {
        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else { return }
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            session.addInput(input)
        } catch {
            fatalError(error.localizedDescription)
        }
        
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        self.video = AVCaptureVideoPreviewLayer(session: session)
        self.video.frame = self.view.layer.bounds
        
        self.view.layer.addSublayer(self.video)
        self.session.startRunning()
    }
    
    func frameZero() {
        self.imageView.frame = CGRect.zero
        self.qrCodeUrlButton.frame = CGRect.zero
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count == 0 {
            self.frameZero()
            return
        }
        
        let metadataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        guard let trasformedObject = self.video.transformedMetadataObject(for: metadataObject) else { return }
        
        self.imageView.frame = trasformedObject.bounds
        self.qrCodeUrlButton.frame = CGRect(x: self.view.bounds.minX + 40, y: 40 + trasformedObject.bounds.maxY, width: self.view.bounds.width - 80, height: 50)
        self.qrCodeUrlButton.setTitle(metadataObject.stringValue, for: .normal)
        self.url = metadataObject.stringValue
    }

}
