import UIKit
import CoreGraphics

class CustomCornverView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.draw(self.frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let startPoint = CGPoint(x: 0, y: 0)
        let endPoint = CGPoint(x: 100, y: 100)
        
        context.move(to: startPoint)
        context.addLine(to: endPoint)
        
        context.strokePath()
    }

}
