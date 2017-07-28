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

    override func drawRect(_ rect: CGRect) {
        backgroundColor?.setFill()
        UIRectFill(rect)

        if let circle = cutoutRect {
            let context = UIGraphicsGetCurrentContext();

            if( CGRectIntersectsRect( circle, rect ) ) {
               CGContextAddEllipseInRect(context, circle);
               context.clip();
               CGContextClearRect(context, circle);
               CGContextSetFillColorWithColor( context!, UIColor.clearColor().CGColor)
               CGContextFillRect( context, circle);
            }
        }
    }
}
