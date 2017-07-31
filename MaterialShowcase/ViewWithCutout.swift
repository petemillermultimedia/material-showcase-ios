import Foundation
import UIKit

class ViewWithCutout: UIView {

    var _cutout: CGRect?
    var cutout: CGRect? {
        get { return _cutout }
        set { _cutout = newValue }
    }

    // MARK: - Initialization

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    init(frame: CGRect, cutout: CGRect?) {
        super.init(frame: frame)
        _cutout = cutout
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        if self._cutout != nil {
            // Ensures to use the current background color to set the filling color
            self.backgroundColor?.setFill()
            UIRectFill(rect)

            let layer = CAShapeLayer()
            let path = CGMutablePath()

            // Make hole in view's overlay
            // NOTE: Here, instead of using the transparentHoleView UIView we could use a specific CFRect location instead...
            path.addEllipse(in: _cutout!)
            path.addRect(bounds)

            layer.path = path
            layer.fillRule = kCAFillRuleEvenOdd
            self.layer.mask = layer
        }
    }
}
