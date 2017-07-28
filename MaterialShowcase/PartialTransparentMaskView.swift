import Foundation
import UIKit

class PartialTransparentMaskView: UIView {
    var cutoutRect: CGRect?

    init(frame: CGRect, backgroundColor: UIColor?, cutout: CGRect?) {
        super.init(frame: frame)

        if((backgroundColor) != nil){
            self.backgroundColor = backgroundColor
        }

        cutoutRect = cutout
        self.isOpaque = false
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        backgroundColor?.setFill()
        UIRectFill(rect)

        if let circle = cutoutRect {
            if let context = UIGraphicsGetCurrentContext() {
                if( rect.intersects( circle ) ) {
                    context.addEllipse(in: circle);
                    context.clip();
                    context.clear(circle);
                    context.SetFillColor(UIColor.clear.CGColor)
                    contextFill(circle);
                }
            }
        }
    }
}
