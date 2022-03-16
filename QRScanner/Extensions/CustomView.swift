import UIKit

class CustomView: UIView {
    
    override func draw(_ rect: CGRect) {
        self.createCorners()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createCorners() -> Void {
        //Calculate the length of corner to be shown
            let cornerLengthToShow = self.bounds.size.height * 0.10
            print(cornerLengthToShow)

            // Create Paths Using BeizerPath for all four corners
            let topLeftCorner = UIBezierPath()
            topLeftCorner.move(to: CGPoint(x: self.bounds.minX, y: self.bounds.minY + cornerLengthToShow))
            topLeftCorner.addLine(to: CGPoint(x: self.bounds.minX, y: self.bounds.minY))
            topLeftCorner.addLine(to: CGPoint(x: self.bounds.minX + cornerLengthToShow, y: self.bounds.minY))

            let topRightCorner = UIBezierPath()
            topRightCorner.move(to: CGPoint(x: self.bounds.maxX - cornerLengthToShow, y: self.bounds.minY))
            topRightCorner.addLine(to: CGPoint(x: self.bounds.maxX, y: self.bounds.minY))
            topRightCorner.addLine(to: CGPoint(x: self.bounds.maxX, y: self.bounds.minY + cornerLengthToShow))

            let bottomRightCorner = UIBezierPath()
            bottomRightCorner.move(to: CGPoint(x: self.bounds.maxX, y: self.bounds.maxY - cornerLengthToShow))
            bottomRightCorner.addLine(to: CGPoint(x: self.bounds.maxX, y: self.bounds.maxY))
            bottomRightCorner.addLine(to: CGPoint(x: self.bounds.maxX - cornerLengthToShow, y: self.bounds.maxY ))

            let bottomLeftCorner = UIBezierPath()
            bottomLeftCorner.move(to: CGPoint(x: self.bounds.minX, y: self.bounds.maxY - cornerLengthToShow))
            bottomLeftCorner.addLine(to: CGPoint(x: self.bounds.minX, y: self.bounds.maxY))
            bottomLeftCorner.addLine(to: CGPoint(x: self.bounds.minX + cornerLengthToShow, y: self.bounds.maxY))

            let combinedPath = CGMutablePath()
            combinedPath.addPath(topLeftCorner.cgPath)
            combinedPath.addPath(topRightCorner.cgPath)
            combinedPath.addPath(bottomRightCorner.cgPath)
            combinedPath.addPath(bottomLeftCorner.cgPath)

            let shapeLayer = CAShapeLayer()
            shapeLayer.path = combinedPath
            shapeLayer.strokeColor = UIColor.black.cgColor
            shapeLayer.fillColor = UIColor.clear.cgColor
            shapeLayer.lineWidth = 3

            layer.addSublayer(shapeLayer)
        }
}
