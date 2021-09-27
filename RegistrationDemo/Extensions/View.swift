//
//  View.swift
//  RegistrationDemo
//
//  Created by Ulmasbek on 2021/09/27.
//

import UIKit
import UIKit

extension UIView {
    
    public func addContsraintsWithFormat(format: String, views: UIView...)
    {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated()
        {
            let key = "v\(index)";
            view.translatesAutoresizingMaskIntoConstraints = false;
            viewsDictionary[key] = view
        }
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
    public func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero){
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top{
            self.topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading{
            self.leftAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom{
            self.bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if let trailing = trailing{
            self.rightAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if size.width != 0{
            self.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0{
            self.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    public func fillSuperView(padding: UIEdgeInsets = .zero){
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewTopAnchor = superview?.topAnchor{
            topAnchor.constraint(equalTo: superviewTopAnchor, constant: padding.top).isActive = true
        }
        if let superviewLeftAnchor = superview?.leftAnchor{
            leftAnchor.constraint(equalTo: superviewLeftAnchor, constant: padding.left).isActive = true
        }
        if let superviewBottomAnchor = superview?.bottomAnchor{
            bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -padding.bottom).isActive = true
        }
        if let superviewRightAnchor = superview?.rightAnchor{
            rightAnchor.constraint(equalTo: superviewRightAnchor, constant: -padding.right).isActive = true
        }
        
    }
    
    public func centerToSuperview(padding: UIEdgeInsets = .zero, size: CGSize = .zero){
        translatesAutoresizingMaskIntoConstraints = false
        
        if let centerX = superview?.centerXAnchor{
            centerXAnchor.constraint(equalTo: centerX, constant: padding.left).isActive = true
        }
        
        if let centerY = superview?.centerYAnchor{
            centerYAnchor.constraint(equalTo: centerY, constant: padding.top).isActive = true
        }
        
        if size.width != 0{
            self.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0{
            self.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    /// Adds constraints to this `UIView` instances `superview` object to make sure this always has the same size as the superview.
    /// Please note that this has no effect if its `superview` is `nil` – add this `UIView` instance as a subview before calling this.
    func bindFrameToSuperviewBounds() {
        guard let superview = self.superview else {
//            Log.output("Error! `superview` was nil – call `addSubview(view: UIView)` before calling `bindFrameToSuperviewBounds()` to fix this.")
            return
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: 0).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: 0).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 0).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: 0).isActive = true
        
        
    }
    
    func roundCornersWithLayerMask(cornerRadii: CGFloat, corners: UIRectCorner) {
        let path = UIBezierPath(roundedRect:self.bounds,
                                byRoundingCorners:corners,
                                cornerRadii: CGSize(width: cornerRadii, height:  cornerRadii))
        
        let maskLayer = CAShapeLayer()
        
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
    
    func setShadowsToView(color: UIColor, offset: CGSize? = .zero, radiusShadow: CGFloat, cornerRadius: CGFloat? = 0, shadowOpacity: Float? = 0.5) {
        self.layer.cornerRadius = cornerRadius ?? self.layer.cornerRadius
        self.layer.shadowRadius = radiusShadow
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset ?? .zero
        self.layer.shadowOpacity = shadowOpacity ?? 0.5
    }
}


extension UIView {
    func setBySafeAreaLayout(_ bottomView: UIView? = nil, bottomBar: UIView? = nil) -> CGFloat {
        var bottomOffset: CGFloat = 0.0
        if #available(iOS 11.0, *) {
            if let bottomView = bottomView, let bottomBar = bottomBar {
                if let window = UIApplication.shared.keyWindow {
                    if window.safeAreaInsets.bottom != 0 {
                        
                        bottomOffset = bottomView.frame.height + bottomBar.frame.height
                    } else {
                        bottomOffset = bottomBar.frame.height
                    }
                } else {
                    bottomOffset = bottomBar.frame.height
                }
            }
        }
        return bottomOffset
    }
}

extension UIView {
    
    public enum PeakSide: Int {
        case Top
        case Left
        case Right
        case Bottom
    }
    
    public func addPikeOnView( side: PeakSide, size: CGFloat = 20) {
        self.layoutIfNeeded()
        let peakLayer = CAShapeLayer()
        var path: CGPath?
        switch side {
        case .Top:
            path = self.makePeakPathWithRect(rect: self.bounds, topSize: size, rightSize: 0.0, bottomSize: 0.0, leftSize: 0.0)
        case .Left:
            path = self.makePeakPathWithRect(rect: self.bounds, topSize: 0.0, rightSize: 0.0, bottomSize: 0.0, leftSize: size)
        case .Right:
            path = self.makePeakPathWithRect(rect: self.bounds, topSize: 0.0, rightSize: size, bottomSize: 0.0, leftSize: 0.0)
        case .Bottom:
            path = self.makePeakPathWithRect(rect: self.bounds, topSize: 0.0, rightSize: 0.0, bottomSize: size, leftSize: 0.0)
        }
        peakLayer.path = path
        let color = (self.backgroundColor?.cgColor)
        peakLayer.fillColor = color
        peakLayer.strokeColor = color
        peakLayer.lineWidth = 1
        peakLayer.position = CGPoint.zero
        peakLayer.cornerRadius = 3
        self.layer.cornerRadius = 16
        self.layer.insertSublayer(peakLayer, at: 0)
    }
    
    
    fileprivate func makePeakPathWithRect(rect: CGRect, topSize ts: CGFloat, rightSize rs: CGFloat, bottomSize bs: CGFloat, leftSize ls: CGFloat) -> CGPath {
        //                      P3
        //                    /    \
        //      P1 -------- P2     P4 -------- P5
        //      |                               |
        //      |                               |
        //      P16                            P6
        //     /                                 \
        //  P15                                   P7
        //     \                                 /
        //      P14                            P8
        //      |                               |
        //      |                               |
        //      P13 ------ P12    P10 -------- P9
        //                    \   /
        //                     P11
        
        let centerX = rect.width / 2
        let centerY = rect.height / 2
        var h: CGFloat = 0
        let path = CGMutablePath()
        var points: [CGPoint] = []
        // P1
        points.append(CGPoint(x:rect.origin.x,y: rect.origin.y))
        // Points for top side
        if ts > 0 {
            h = ts * sqrt(3.0) / 2
            let x = rect.origin.x + centerX
            let y = rect.origin.y
            points.append(CGPoint(x:x - ts,y: y))
            points.append(CGPoint(x:x,y: y - h))
            points.append(CGPoint(x:x + ts,y: y))
        }
        
        // P5
        points.append(CGPoint(x:rect.origin.x + rect.width,y: rect.origin.y))
        // Points for right side
        if rs > 0 {
            h = rs * sqrt(3.0) / 2
            let x = rect.origin.x + rect.width
            let y = rect.origin.y + centerY
            points.append(CGPoint(x:x,y: y - rs))
            points.append(CGPoint(x:x + h,y: y))
            points.append(CGPoint(x:x,y: y + rs))
        }
        
        // P9
        points.append(CGPoint(x:rect.origin.x + rect.width,y: rect.origin.y + rect.height))
        // Point for bottom side
        if bs > 0 {
            h = bs * sqrt(3.0) / 2
            let x = rect.origin.x + centerX
            let y = rect.origin.y + rect.height
            points.append(CGPoint(x:x + bs,y: y))
            points.append(CGPoint(x:x,y: y + h))
            points.append(CGPoint(x:x - bs,y: y))
        }
        
        // P13
        points.append(CGPoint(x:rect.origin.x, y: rect.origin.y + rect.height))
        // Point for left sidey:
        if ls > 0 {
            h = ls * sqrt(3.0) / 2
            let x = rect.origin.x
            let y = rect.origin.y + centerY
            points.append(CGPoint(x:x,y: y + ls))
            points.append(CGPoint(x:x - h,y: y))
            points.append(CGPoint(x:x,y: y - ls))
        }
        
        let startPoint = points.removeFirst()
        self.startPath(path: path, onPoint: startPoint)
        for point in points {
            self.addPoint(point: point, toPath: path)
        }
        self.addPoint(point: startPoint, toPath: path)
        return path
    }
    
    private func startPath( path: CGMutablePath, onPoint point: CGPoint) {
        path.move(to: CGPoint(x: point.x, y: point.y))
    }
    
    private func addPoint(point: CGPoint, toPath path: CGMutablePath) {
        path.addLine(to: CGPoint(x: point.x, y: point.y))
    }
}


extension UIView {

    var asImage: UIImage? {
       let renderer = UIGraphicsImageRenderer(size: self.bounds.size)
        let image = renderer.image { ctx in
            self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        }
        return image
    }

    
    func createGradients(firstColor: UIColor, secondColor: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.3)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.7)
        gradientLayer.shadowColor = UIColor(hexString: "#EE6114")?.withAlphaComponent(0.3).cgColor
        gradientLayer.shadowOffset = CGSize(width: 0, height: 15)
        gradientLayer.shadowRadius = 30
        gradientLayer.shadowOpacity = 1
        gradientLayer.cornerRadius = 16
        gradientLayer.masksToBounds = true
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    @discardableResult
    func setDynamicGradient(firstColor: UIColor, secondColor: UIColor, startsAt: CGFloat = 0.5, endsAt: CGFloat = 0.5) -> CAGradientLayer{
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: startsAt)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: endsAt)
        gradientLayer.cornerRadius = 16
        
        return gradientLayer
    }
    
    func viewShadow(color: UIColor? = nil) {
        self.layer.shadowColor = color != nil ? color!.cgColor : UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 3.0
        self.layer.shadowOffset = CGSize(width: 0.1, height: 4)
        self.layer.shouldRasterize = true
        self.layer.masksToBounds = true
        self.clipsToBounds = false
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    func removeShadow() {
        self.layer.shadowOffset = .zero
        self.layer.shadowColor = UIColor.clear.cgColor
        self.clipsToBounds = true
    }
    
    func selfColorShadow(offSet: CGSize? = nil) {
        self.layer.shadowColor = self.backgroundColor?.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 12
        self.layer.shadowOffset = offSet != nil ? offSet! : CGSize(width: 0.1, height: 4) // CGSize(width: 0.1, height: -4)
        self.layer.shouldRasterize = true
        self.layer.masksToBounds = true
        self.clipsToBounds = false
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}

extension UIView {
    
    var igLeftAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.leftAnchor
        }
        return self.leftAnchor
    }
    var igRightAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.rightAnchor
        }
        return self.rightAnchor
    }
    var igTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.topAnchor
        }
        return self.topAnchor
    }
    var igBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.bottomAnchor
        }
        return self.bottomAnchor
    }
    var igCenterXAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.centerXAnchor
        }
        return self.centerXAnchor
    }
    var igCenterYAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.centerYAnchor
        }
        return self.centerYAnchor
    }
    var width: CGFloat {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.layoutFrame.width
        }
        return frame.width
    }
    var height: CGFloat {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.layoutFrame.height
        }
        return frame.height
    }
}

protocol UIViewLoading {}
extension UIView : UIViewLoading {}

extension UIViewLoading where Self : UIView {

  // note that this method returns an instance of type `Self`, rather than UIView
  static func loadFromNib() -> Self {
    let nibName = "\(self)".split{$0 == "."}.map(String.init).last!
    let nib = UINib(nibName: nibName, bundle: nil)
    return nib.instantiate(withOwner: self, options: nil).first as! Self
  }

}

extension CGRect {
    func zoom(by zoomFactor: CGFloat) -> CGRect {
        let zoomedWidth = size.width * zoomFactor
        let zoomedHeight = size.height * zoomFactor
        let originX = origin.x + (size.width - zoomedWidth) / 2
        let originY = origin.y + (size.height - zoomedHeight) / 2
        return CGRect(origin: CGPoint(x: originX,y: originY) , size: CGSize(width: zoomedWidth, height: zoomedHeight))
    }
    
    var leftHalf: CGRect {
        let width = size.width / 2
        return CGRect(origin: origin, size: CGSize(width: width, height: size.height))
    }
    
    var rightHalf: CGRect {
        let width = size.width / 2
        return CGRect(origin: CGPoint(x: origin.x + width, y: origin.y), size: CGSize(width: width, height: size.height))
    }
}

extension CALayer {
    
    enum BorderSide {
        case top
        case right
        case bottom
        case left
        case notRight
        case notLeft
        case topAndBottom
        case all
    }
    
    enum Corner {
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight
    }
    
    func addBorder(side: BorderSide, thickness: CGFloat, color: CGColor, maskedCorners: CACornerMask? = nil) {
        var topWidth = frame.size.width; var bottomWidth = topWidth
        var leftHeight = frame.size.height; var rightHeight = leftHeight
        
        var topXOffset: CGFloat = 0; var bottomXOffset: CGFloat = 0
        var leftYOffset: CGFloat = 0; var rightYOffset: CGFloat = 0
        
        // Draw the corners and set side offsets
        switch maskedCorners {
        case [.layerMinXMinYCorner, .layerMaxXMinYCorner]: // Top only
            addCorner(.topLeft, thickness: thickness, color: color)
            addCorner(.topRight, thickness: thickness, color: color)
            topWidth -= cornerRadius*2
            leftHeight -= cornerRadius; rightHeight -= cornerRadius
            topXOffset = cornerRadius; leftYOffset = cornerRadius; rightYOffset = cornerRadius
            
        case [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]: // Bottom only
            addCorner(.bottomLeft, thickness: thickness, color: color)
            addCorner(.bottomRight, thickness: thickness, color: color)
            bottomWidth -= cornerRadius*2
            leftHeight -= cornerRadius; rightHeight -= cornerRadius
            bottomXOffset = cornerRadius
            
        case [.layerMinXMinYCorner, .layerMinXMaxYCorner]: // Left only
            addCorner(.topLeft, thickness: thickness, color: color)
            addCorner(.bottomLeft, thickness: thickness, color: color)
            topWidth -= cornerRadius; bottomWidth -= cornerRadius
            leftHeight -= cornerRadius*2
            leftYOffset = cornerRadius; topXOffset = cornerRadius; bottomXOffset = cornerRadius;
            
        case [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]: // Right only
            addCorner(.topRight, thickness: thickness, color: color)
            addCorner(.bottomRight, thickness: thickness, color: color)
            topWidth -= cornerRadius; bottomWidth -= cornerRadius
            rightHeight -= cornerRadius*2
            rightYOffset = cornerRadius
            
        case [.layerMaxXMinYCorner, .layerMaxXMaxYCorner,  // All
              .layerMinXMaxYCorner, .layerMinXMinYCorner]:
            addCorner(.topLeft, thickness: thickness, color: color)
            addCorner(.topRight, thickness: thickness, color: color)
            addCorner(.bottomLeft, thickness: thickness, color: color)
            addCorner(.bottomRight, thickness: thickness, color: color)
            topWidth -= cornerRadius*2; bottomWidth -= cornerRadius*2
            topXOffset = cornerRadius; bottomXOffset = cornerRadius
            leftHeight -= cornerRadius*2; rightHeight -= cornerRadius*2
            leftYOffset = cornerRadius; rightYOffset = cornerRadius
            
        default: break
        }
        
        // Draw the sides
        switch side {
        case .top:
            addLine(x: topXOffset, y: 0, width: topWidth, height: thickness, color: color)
            
        case .right:
            addLine(x: frame.size.width - thickness, y: rightYOffset, width: thickness, height: rightHeight, color: color)
            
        case .bottom:
            addLine(x: bottomXOffset, y: frame.size.height - thickness, width: bottomWidth, height: thickness, color: color)
            
        case .left:
            addLine(x: 0, y: leftYOffset, width: thickness, height: leftHeight, color: color)

        // Multiple Sides
        case .notRight:
            addLine(x: topXOffset, y: 0, width: topWidth, height: thickness, color: color)
            addLine(x: 0, y: leftYOffset, width: thickness, height: leftHeight, color: color)
            addLine(x: bottomXOffset, y: frame.size.height - thickness, width: bottomWidth, height: thickness, color: color)

        case .notLeft:
            addLine(x: topXOffset, y: 0, width: topWidth, height: thickness, color: color)
            addLine(x: frame.size.width - thickness, y: rightYOffset, width: thickness, height: rightHeight, color: color)
            addLine(x: bottomXOffset, y: frame.size.height - thickness, width: bottomWidth, height: thickness, color: color)

        case .topAndBottom:
            addLine(x: topXOffset, y: 0, width: topWidth, height: thickness, color: color)
            addLine(x: bottomXOffset, y: frame.size.height - thickness, width: bottomWidth, height: thickness, color: color)

        case .all:
            addLine(x: topXOffset, y: 0, width: topWidth, height: thickness, color: color)
            addLine(x: frame.size.width - thickness, y: rightYOffset, width: thickness, height: rightHeight, color: color)
            addLine(x: bottomXOffset, y: frame.size.height - thickness, width: bottomWidth, height: thickness, color: color)
            addLine(x: 0, y: leftYOffset, width: thickness, height: leftHeight, color: color)
        }
    }
    
    private func addLine(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, color: CGColor) {
        let border = CALayer()
        border.frame = CGRect(x: x, y: y, width: width, height: height)
        border.backgroundColor = color
        addSublayer(border)
    }
    
    private func addCorner(_ corner: Corner, thickness: CGFloat, color: CGColor) {
        // Set default to top left
        let width = frame.size.width; let height = frame.size.height
        var x = cornerRadius
        var startAngle: CGFloat = .pi; var endAngle: CGFloat = .pi*3/2
        
        switch corner {
        case .bottomLeft: startAngle = .pi/2; endAngle = .pi
            
        case .bottomRight:
            x = width - cornerRadius
            startAngle = 0; endAngle = .pi/2
            
        case .topRight:
            x = width - cornerRadius
            startAngle = .pi*3/2; endAngle = 0
            
        default: break
        }
        
        let cornerPath = UIBezierPath(arcCenter: CGPoint(x: x, y: height / 2),
                                      radius: cornerRadius - thickness,
                                      startAngle: startAngle,
                                      endAngle: endAngle,
                                      clockwise: true)

        let cornerShape = CAShapeLayer()
        cornerShape.path = cornerPath.cgPath
        cornerShape.lineWidth = thickness
        cornerShape.strokeColor = color
        cornerShape.fillColor = nil
        addSublayer(cornerShape)
    }
}

extension UIView{
    
    func curvedCorners(radius: CGFloat){
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}

public protocol Bluring {
    func addBlur(_ alpha: CGFloat)
}

extension Bluring where Self: UIView {
    public func addBlur(_ alpha: CGFloat = 0.5) {
        // create effect
        let effect = UIBlurEffect(style: .dark)
        let effectView = UIVisualEffectView(effect: effect)
        
        // set boundry and alpha
        effectView.frame = self.bounds
        effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        effectView.alpha = alpha
        
        self.addSubview(effectView)
    }
}

// Conformance@objc
extension UIView: Bluring {}

// use

extension UIView {
    
    ///
    public convenience init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        self.init(frame: CGRect(x: x, y: y, width: w, height: h))
    }
    
    /// puts padding around the view
    public convenience init(superView: UIView, padding: CGFloat) {
        self.init(frame: CGRect(x: superView.x + padding, y: superView.y + padding, width: superView.width - padding * 2, height: superView.height - padding * 2))
    }
    
    /// Copies size of superview
    public convenience init(superView: UIView) {
        self.init(frame: CGRect(origin: CGPoint.zero, size: superView.size))
    }
}

//frame
extension UIView {
    //TODO: Multipe addsubview
    /// EZSwiftExtensions, resizes this view so it fits the largest subview
    open func resizeToFitSubviews() {
        var width: CGFloat = 0
        var height: CGFloat = 0
        for someView in self.subviews {
            let aView = someView
            let newWidth = aView.x + aView.width
            let newHeight = aView.y + aView.height
            width = max(width, newWidth)
            height = max(height, newHeight)
        }
        frame = CGRect(x: x, y: y, width: width, height: height)
    }
    
    /// EZSwiftExtensions, resizes this view so it fits the largest subview
    open func resizeToFitSubviews(_ tagsToIgnore: [Int]) {
        var width: CGFloat = 0
        var height: CGFloat = 0
        for someView in self.subviews {
            let aView = someView
            if !tagsToIgnore.contains(someView.tag) {
                let newWidth = aView.x + aView.width
                let newHeight = aView.y + aView.height
                width = max(width, newWidth)
                height = max(height, newHeight)
            }
        }
        frame = CGRect(x: x, y: y, width: width, height: height)
    }
    
    /// EZSwiftExtensions
//    open func resizeToFitWidth() {
//        let currentHeight = self.height
//        self.sizeToFit()
//        self.height = currentHeight
//    }
//
//    /// EZSwiftExtensions
//    open func resizeToFitHeight() {
//        let currentWidth = self.width
//        self.sizeToFit()
//        self.width = currentWidth
//    }
    
    public var x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set(newX) {
            var newFrame = self.frame
            newFrame.origin.x = newX
            self.frame = newFrame
        }
    }
    
    public var y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set(newY) {
            var newFrame = self.frame
            newFrame.origin.y = newY
            self.frame = newFrame
        }
    }
    
//    public var width: CGFloat {
//        get {
//            return self.frame.size.width
//        }
//        set(newWidth) {
//            var newFrame = self.frame
//            newFrame.size.width = newWidth
//            self.frame = newFrame
//        }
//    }
//
//    public var height: CGFloat {
//        get {
//            return self.frame.size.height
//        }
//        set(newHeight) {
//            var newFrame = self.frame
//            newFrame.size.height = newHeight
//            self.frame = newFrame
//        }
//    }
    public var minX: CGFloat {
        get {
            return self.frame.minX
        }
    }
    public var midX: CGFloat {
        get {
            return self.frame.midX
        }
    }
    public var maxX: CGFloat {
        get {
            return self.frame.maxX
        }
    }
    
    public var minY: CGFloat {
        get {
            return self.frame.minY
        }
    }
    public var midY: CGFloat {
        get {
            return self.frame.midY
        }
    }
    public var maxY: CGFloat {
        get {
            return self.frame.maxY
        }
    }
    
    public var size: CGSize {
        get {
            return self.frame.size
        } set {
            self.frame.size = newValue
        }
    }
    
    public var origin: CGPoint {
        get {
            return self.frame.origin
        } set {
            self.frame.origin = newValue
        }
    }
    
    /// EZSwiftExtensions
    public var left: CGFloat {
        get {
            return self.x
        } set(value) {
            self.x = value
        }
    }
    
    ///
    public var right: CGFloat {
        get {
            return self.x + self.width
        } set(value) {
            self.x = value - self.width
        }
    }
    
    ///
    public var top: CGFloat {
        get {
            return self.y
        } set(value) {
            self.y = value
        }
    }
    
    ///
    public var bottom: CGFloat {
        get {
            return self.y + self.height
        } set(value) {
            self.y = value - self.height
        }
    }
    
    ///
    public var centerX: CGFloat {
        get {
            return self.center.x
        } set(value) {
            self.center.x = value
        }
    }
    
    ///
    public var centerY: CGFloat {
        get {
            return self.center.y
        } set(value) {
            self.center.y = value
        }
    }
    ///
    open func leftOffset(_ offset: CGFloat) -> CGFloat {
        return self.left - offset
    }
    
    ///
    open func rightOffset(_ offset: CGFloat) -> CGFloat {
        return self.right + offset
    }
    
    ///
    open func topOffset(_ offset: CGFloat) -> CGFloat {
        return self.top - offset
    }
    
    ///
    open func bottomOffset(_ offset: CGFloat) -> CGFloat {
        return self.bottom + offset
    }
    
    //TODO: Add to readme
    open func alignRight(_ offset: CGFloat) -> CGFloat {
        return self.width - offset
    }
    
    ///
    open func reorderSubViews(_ reorder: Bool = false, tagsToIgnore: [Int] = []) -> CGFloat {
        var currentHeight: CGFloat = 0
        for someView in subviews {
            if !tagsToIgnore.contains(someView.tag) && !(someView ).isHidden {
                if reorder {
                    let aView = someView
                    aView.frame = CGRect(x: aView.frame.origin.x, y: currentHeight, width: aView.frame.width, height: aView.frame.height)
                }
                currentHeight += someView.frame.height
            }
        }
        return currentHeight
    }
    
    open func scaleFrameTo(_ scale: CGFloat) {
        var fr = self.frame
        fr.origin.x = self.x + scale
        fr.origin.y = self.y + scale
        fr.size.width = self.width - 2 * scale
        fr.size.height = self.height - 2 * scale
        self.frame = fr
    }
    
//    open func changeFrameCenterView(_ forOrientation: UIInterfaceOrientation)
//    {
//        let w = Global.screenWidthForOrientation(forOrientation) - 2 * self.x
////        let h = Global.screenHeightForOrientation(forOrientation)
//        self.width = w
//    }
}

//bounds
extension UIView {
    public var boundsX: CGFloat {
        get {
            return self.bounds.origin.x
        }
        set {
            var newBounds = self.bounds
            newBounds.origin.x = newValue
            self.bounds = newBounds
        }
    }
    public var boundsY: CGFloat {
        get {
            
            return self.bounds.origin.y
        }
        set {
            var newBounds = self.bounds
            newBounds.origin.y = newValue
            self.bounds = newBounds
        }
    }
    
    public var boundsWidth: CGFloat {
        get {
            return self.bounds.size.width
        }
        set {
            var newBounds = self.bounds
            newBounds.size.width = newValue
            self.bounds = newBounds
        }
    }
    
    public var boundsHeight: CGFloat {
        get {
            return self.bounds.size.height
        }
        set {
            var newBounds = self.bounds
            newBounds.size.height = newValue
            self.bounds = newBounds
        }
    }
    
    open func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        
        self.layer.add(animation, forKey: nil)
    }
    
}
//border
extension UIView {
    public var borderRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.clipsToBounds = true
            self.layer.cornerRadius = newValue
        }
    }
    
    public var borderColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            self.borderWidth = 1
            self.layer.borderColor = newValue?.cgColor
        }
    }
    
    public var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    /// Adding border around self frame
    open func addBorder(_ borderColor: UIColor, width: CGFloat) {
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = width
    }
    /// Adding border with argument frame
    open func addBorder(_ borderColor: UIColor, rect: CGRect) {
//        for b in self.layer.sublayers ?? [CALayer]() {
//            if b.name == "borderLayer" {
//                return
//            }
//        }
//
//        if rect.width == 0 || self.height == 0 {
//            return
//        }
        
        let border = CALayer()
        border.name = "borderLayer"
        border.backgroundColor = borderColor.cgColor
        border.frame = rect
        self.layer.addSublayer(border)
    }
    
    open func removeBorder() {
        for border in self.layer.sublayers ?? [CALayer]() {
            if border.name == "borderLayer" {
                border.removeFromSuperlayer()
            }
        }
    }
    
    open func addTopBorder(_ borderColor: UIColor, borderWidth: CGFloat) {
        addBorder(borderColor, rect: CGRect(x: 0, y: 0, width: self.width, height: borderWidth))
    }
    
    open func addBottomBorder(_ borderColor: UIColor, borderWidth: CGFloat) {
        addBorder(borderColor, rect: CGRect(x: 0, y: self.height - borderWidth, width: self.width, height: borderWidth))
    }
    
    open func addLeftBorder(_ borderColor: UIColor, borderWidth: CGFloat) {
        addBorder(borderColor, rect: CGRect(x: 0, y: 0, width: borderWidth, height: self.height))
    }
    
    open func addRightBorder(_ borderColor: UIColor, borderWidth: CGFloat) {
        addBorder(borderColor, rect: CGRect(x: self.width - borderWidth, y: 0, width: borderWidth, height: self.height))
    }
}

public struct PositionSubView: OptionSet {
    fileprivate enum Position: Int, CustomStringConvertible {
        case left = 1, right = 2, top = 4, bottom = 8, center = 16, centerHorizontal = 32, centerVertical = 64
        var description : String {
            var shift = 0
            while (rawValue >> shift != 1){ shift += 1 }
            return ["Left","Right","Top","Bottom", "Center"][shift]
        }
        
    }
    
    public let rawValue : Int
    public init(rawValue:Int) {
        self.rawValue = rawValue
    }
    fileprivate init(_ position:Position) {
        self.rawValue = position.rawValue
    }
    
    public static let Left: PositionSubView = PositionSubView(Position.left)
    public static let Right: PositionSubView = PositionSubView(Position.right)
    public static let Top: PositionSubView = PositionSubView(Position.top)
    public static let Bottom: PositionSubView = PositionSubView(Position.bottom)
    public static let Center: PositionSubView = PositionSubView(Position.center)
    public static let LeftTop: PositionSubView = [Left, Top]
    public static let LeftBottom: PositionSubView = [Left, Bottom]
    public static let RightTop: PositionSubView = [Right, Top]
    public static let RightBottom: PositionSubView = [Right, Bottom]
    public static let CenterTop: PositionSubView = [Center, Top]
    public static let CenterBottom: PositionSubView = [Center, Bottom]
    public static let CenterHorizontal: PositionSubView = PositionSubView(Position.centerHorizontal)
    public static let CenterVertical: PositionSubView = PositionSubView(Position.centerVertical)
}

//positioning sub view
extension UIView {
//    open func addSubview(_ subView: UIView, position: PositionSubView, padding: CGFloat) {
//        let w = subView.width
//        let h = subView.height
//        var x = subView.x
//        var y = subView.y
//
//        let yPadding = padding + UIUtil.getStatusBarHeight()
//
//        func xByPosition(_ pos: PositionSubView) -> CGFloat {
//            switch pos {
//            case PositionSubView.Left:
//                return padding
//            case PositionSubView.Right:
//                return self.width - w - padding
//            case PositionSubView.Center, PositionSubView.CenterHorizontal:
//                return (self.width - w - padding) / 2
//            default:
//                return x
//            }
//        }
//
//        func yByPosition(_ pos: PositionSubView) -> CGFloat {
//            switch pos {
//            case PositionSubView.Top:
//                return yPadding
//            case PositionSubView.Bottom:
//                return self.height - h - yPadding
//            case PositionSubView.Center, PositionSubView.CenterVertical:
//                return (self.height - h - yPadding) / 2
//            default:
//                return y
//            }
//        }
//
//        switch position {
//        case PositionSubView.LeftTop://, PositionSubView.Top:
//            x = xByPosition(PositionSubView.Left)
//            y = yByPosition(PositionSubView.Top)
//        case PositionSubView.LeftBottom:
//            x = xByPosition(PositionSubView.Left)
//            y = yByPosition(PositionSubView.Bottom)
//        case PositionSubView.RightTop:
//            x = xByPosition(PositionSubView.Right)
//            y = yByPosition(PositionSubView.Top)
//        case PositionSubView.RightBottom:
//            x = xByPosition(PositionSubView.Right)
//            y = yByPosition(PositionSubView.Bottom)
//        default:
//            x = xByPosition(position)
//            y = yByPosition(position)
//        }
//
//        subView.x = x
//        subView.y = y
//        self.addSubview(subView)
//    }
    
//    open func addSubview(_ subView: UIView, position: PositionSubView) {
//        self.addSubview(subView, position: position, padding: 0)
//    }
}

//shadow
extension UIView {
    /// Adding shadow by creating new view
    open func addShadow(superView: UIView, radius: CGFloat, color: UIColor, opacity: Float, cornerRadius: CGFloat? = 0.1) {
        let shadowView = UIView()
        shadowView.frame = self.frame
        shadowView.layer.shadowOffset = CGSize.zero
        shadowView.layer.shadowRadius = radius
        shadowView.layer.shadowOpacity = opacity
        shadowView.layer.shadowColor = color.cgColor
        if let r = cornerRadius {
            shadowView.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: r).cgPath
        }
        superView.insertSubview(shadowView, belowSubview: self)
    }
    
    open func addShadowBorder(_ shadowBorderColor: UIColor, rect: CGRect) {
        let shadowPath = UIBezierPath(rect: rect)
        self.layer.masksToBounds = false
        self.layer.shadowColor = shadowBorderColor.cgColor
        self.layer.shadowOffset = rect.size
        self.layer.shadowOpacity = 1.0
        self.layer.shadowPath = shadowPath.cgPath
    }
    public var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }
    public var shadowColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.shadowColor!)
        }
        set {
            self.shadowOpacity = 0.31
            self.layer.shadowColor = newValue?.cgColor
            self.layer.shadowOffset = CGSize(width: 0, height: 2)
        }
    }
    
    public var shadowRadius: CGFloat {
        get {
            return self.layer.shadowRadius
        }
        set {
            self.shadowOpacity = 0.31
            self.layer.shadowRadius = newValue
        }
    }
    
    public var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.shadowOpacity = 0.31
            self.layer.shadowOffset = newValue
        }
    }
}

//subviews
extension UIView {
    open func removeAllSubviews() {
        for v in self.subviews {
            v.removeFromSuperview()
        }
    }
}

// MARK: Transform Extensions
extension UIView {
    ///
//    open func setRotationX(_ x: CGFloat) {
//        var transform = CATransform3DIdentity
//        transform.m34 = 1.0 / -1000.0
//        transform = CATransform3DRotate(transform, degreesToRadians(x), 1.0, 0.0, 0.0)
//        self.layer.transform = transform
//    }
//
//    ///
//    open func setRotationY(_ y: CGFloat) {
//        var transform = CATransform3DIdentity
//        transform.m34 = 1.0 / -1000.0
//        transform = CATransform3DRotate(transform, degreesToRadians(y), 0.0, 1.0, 0.0)
//        self.layer.transform = transform
//    }
//
//    ///
//    open func setRotationZ(_ z: CGFloat) {
//        var transform = CATransform3DIdentity
//        transform.m34 = 1.0 / -1000.0
//        transform = CATransform3DRotate(transform, degreesToRadians(z), 0.0, 0.0, 1.0)
//        self.layer.transform = transform
//    }
//
//    ///
//    open func setRotation(x: CGFloat, y: CGFloat, z: CGFloat) {
//        var transform = CATransform3DIdentity
//        transform.m34 = 1.0 / -1000.0
//        transform = CATransform3DRotate(transform, degreesToRadians(x), 1.0, 0.0, 0.0)
//        transform = CATransform3DRotate(transform, degreesToRadians(y), 0.0, 1.0, 0.0)
//        transform = CATransform3DRotate(transform, degreesToRadians(z), 0.0, 0.0, 1.0)
//        self.layer.transform = transform
//    }
    
    ///
    open func setScale(x: CGFloat, y: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DScale(transform, x, y, 1)
        self.layer.transform = transform
    }
}

//drawing
extension UIView {
    //TODO: add this to readme
    ///
    open func drawCircle(fillColor: UIColor, strokeColor: UIColor, strokeWidth: CGFloat) {
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.width, height: self.width), cornerRadius: self.width / 2)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = strokeWidth
        self.layer.addSublayer(shapeLayer)
    }
    //TODO: add this to readme
    ///
    open func drawStroke(width: CGFloat, color: UIColor) {
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.width, height: self.width), cornerRadius: self.width / 2)
        let shapeLayer = CAShapeLayer ()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width
        self.layer.addSublayer(shapeLayer)
    }
}

private let UIViewAnimationDuration: TimeInterval = 1
private let UIViewAnimationSpringDamping: CGFloat = 0.5
private let UIViewAnimationSpringVelocity: CGFloat = 0.5

//TODO: add this to readme
// MARK: Animation Extensions
extension UIView {
    
    ///
    open func spring(animations: @escaping (() -> Void), completion: ((Bool) -> Void)? = nil) {
        spring(duration: UIViewAnimationDuration, animations: animations, completion: completion)
    }
    
    ///
    open func spring(duration: TimeInterval, animations: @escaping (() -> Void), completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: UIViewAnimationDuration, delay: 0, usingSpringWithDamping: UIViewAnimationSpringDamping, initialSpringVelocity: UIViewAnimationSpringVelocity, options: UIView.AnimationOptions.allowAnimatedContent, animations: animations, completion: completion)
    }
    
    ///
    open func animate(duration: TimeInterval, animations: @escaping (() -> Void), completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, animations: animations, completion: completion)
    }
    
    ///
    open func animate(animations: @escaping (()->Void), completion: ((Bool) -> Void)? = nil) {
        animate(duration: UIViewAnimationDuration, animations: animations, completion: completion)
    }
    
    ///
    open func pop() {
        setScale(x: 1.1, y: 1.1)
        spring(duration: 0.2, animations: { [unowned self] () -> Void in
            self.setScale(x: 1, y: 1)
            })
    }
    
    ///
    open func popBig() {
        setScale(x: 1.25, y: 1.25)
        spring(duration: 0.2, animations: { [unowned self] () -> Void in
            self.setScale(x: 1, y: 1)
            })
    }
}

//TODO: add this to readme
// MARK: Render Extensions
extension UIView {
    ///
    open func toImage () -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0.0)
        drawHierarchy(in: bounds, afterScreenUpdates: false)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}

//TODO: add to readme
extension UIView {
    /// [UIRectCorner.TopLeft, UIRectCorner.TopRight]
    open func roundCorner(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

extension UIView {
    public enum CornerPosition {
        case Top
        case Bottom
        case All
    }
    
    open func roundCorners(_ corners: CornerPosition, radius: CGFloat) {
        switch corners {
        case .Top:
            let maskPathTop = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: radius, height: radius))
            let shapeLayerTop = CAShapeLayer()
            shapeLayerTop.frame = self.bounds
            shapeLayerTop.path = maskPathTop.cgPath
            self.layer.mask = shapeLayerTop
        case .Bottom:
            let maskPathBottom = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: radius, height: radius))
            let shapeLayerBottom = CAShapeLayer()
            shapeLayerBottom.frame = self.bounds
            shapeLayerBottom.path = maskPathBottom.cgPath
            self.layer.mask = shapeLayerBottom
        case .All:
            let maskPathAll = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft, .topRight, .bottomRight, .bottomLeft], cornerRadii: CGSize(width: radius, height: radius))
            let shapeLayerAll = CAShapeLayer()
            shapeLayerAll.frame = self.bounds
            shapeLayerAll.path = maskPathAll.cgPath
            self.layer.mask = shapeLayerAll
        }
    }
}
// MARK: Gesture Extensions
extension UIView {
    
    /// http://stackoverflow.com/questions/4660371/how-to-add-a-touch-event-to-a-uiview/32182866#32182866
    ///
    open func addTapGesture(tapNumber: Int, target: AnyObject, action: Selector) {
        let tap = UITapGestureRecognizer(target: target, action: action)
        tap.numberOfTapsRequired = tapNumber
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }
    
    ///
//    @discardableResult
//    open func addTapGesture(tapNumber: Int, action: ((UITapGestureRecognizer) -> ())?) -> ClosureTap {
//        let tap = ClosureTap(tapCount: tapNumber, fingerCount: 1, action: action)
//        addGestureRecognizer(tap)
//        isUserInteractionEnabled = true
//        return tap
//    }
//
//    ///
//    open func addSwipeGesture(direction: UISwipeGestureRecognizer.Direction, numberOfTouches: Int, target: AnyObject, action: Selector) {
//        let swipe = UISwipeGestureRecognizer(target: target, action: action)
//        swipe.direction = direction
//        swipe.numberOfTouchesRequired = numberOfTouches
//        addGestureRecognizer(swipe)
//        isUserInteractionEnabled = true
//    }
//
//    ///
//    @discardableResult
//    open func addSwipeGesture(direction: UISwipeGestureRecognizer.Direction, numberOfTouches: Int, action: ((UISwipeGestureRecognizer) -> ())?) -> ClosureSwipe {
//        let swipe = ClosureSwipe(direction: direction, fingerCount: numberOfTouches, action: action)
//        addGestureRecognizer(swipe)
//        isUserInteractionEnabled = true
//        return swipe
//    }
//
//    ///
//    open func addPanGesture(target: AnyObject, action: Selector) {
//        let pan = UIPanGestureRecognizer(target: target, action: action)
//        addGestureRecognizer(pan)
//        isUserInteractionEnabled = true
//    }
//
//    ///
//    @discardableResult
//    open func addPanGesture(action: ((UIPanGestureRecognizer) -> ())?) -> ClosurePan {
//        let pan = ClosurePan(action: action)
//        addGestureRecognizer(pan)
//        isUserInteractionEnabled = true
//        return pan
//    }
    
    ///
    open func addPinchGesture(target: AnyObject, action: Selector) {
        let pinch = UIPinchGestureRecognizer(target: target, action: action)
        addGestureRecognizer(pinch)
        isUserInteractionEnabled = true
    }
    
    ///
//    @discardableResult
//    open func addPinchGesture(action: ((UIPinchGestureRecognizer) -> ())?) -> ClosurePinch {
//        let pinch = ClosurePinch(action: action)
//        addGestureRecognizer(pinch)
//        isUserInteractionEnabled = true
//        return pinch
//    }
//
//    ///
//    open func addLongPressGesture(target: AnyObject, action: Selector) {
//        let longPress = UILongPressGestureRecognizer(target: target, action: action)
//        addGestureRecognizer(longPress)
//        isUserInteractionEnabled = true
//    }
//
//    ///
//    @discardableResult
//    open func addLongPressGesture(action: ((UILongPressGestureRecognizer) -> ())?) -> ClosureLongPress {
//        let longPress = ClosureLongPress(action: action)
//        addGestureRecognizer(longPress)
//        isUserInteractionEnabled = true
//        return longPress
//    }
}

extension UIView {
    public func height(constant: CGFloat) {
        setConstraint(value: constant, attribute: .height)
    }
    
    public func width(constant: CGFloat) {
        setConstraint(value: constant, attribute: .width)
    }
    
    private func removeConstraint(attribute: NSLayoutConstraint.Attribute) {
        constraints.forEach {
            if $0.firstAttribute == attribute {
                removeConstraint($0)
            }
        }
    }
    
    private func setConstraint(value: CGFloat, attribute: NSLayoutConstraint.Attribute) {
        removeConstraint(attribute: attribute)
        let constraint =
            NSLayoutConstraint(item: self,
                               attribute: attribute,
                               relatedBy: NSLayoutConstraint.Relation.equal,
                               toItem: nil,
                               attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                               multiplier: 1,
                               constant: value)
        self.addConstraint(constraint)
    }
}
