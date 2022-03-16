import UIKit

class RectangleView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func draw(_ rect: CGRect) {

        let aPath = UIBezierPath()

        UIColor.black.set()

        aPath.move(to: CGPoint(x: rect.minX, y: 0.1*rect.maxY))
        aPath.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        aPath.addLine(to: CGPoint(x: 20, y: rect.minY))
        aPath.stroke()

        aPath.move(to: CGPoint(x: rect.maxX - 0.1*rect.maxX, y: rect.minY))
        aPath.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        aPath.addLine(to: CGPoint(x: rect.maxX, y: 0.1*rect.maxY))
        aPath.stroke()

        aPath.move(to: CGPoint(x: rect.maxX, y: rect.maxY - 0.1*rect.maxY))
        aPath.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        aPath.addLine(to: CGPoint(x: rect.maxX - 0.1*rect.maxX, y: rect.maxY))
        aPath.stroke()

        aPath.move(to: CGPoint(x: rect.minX + 0.1*rect.maxX, y: rect.maxY))
        aPath.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        aPath.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - 0.1*rect.maxY))
        aPath.stroke()

    }

}
