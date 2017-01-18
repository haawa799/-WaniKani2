//
//  DoubleProgressBar.swift
//  WaniKani
//
//  Created by Andriy K. on 9/29/15.
//  Copyright © 2015 Andriy K. All rights reserved.
//

import UIKit

protocol DoubleProgressBarProgressDataSource: ViewModel {
  var topTitle: String { get }
  var botTitle: String { get }
  var topProgressPercentage: CGFloat { get }
  var botProgressPercentage: CGFloat { get }
  var levelString: String { get }
}

@IBDesignable
class DoubleProgressBar: UIControl {
  
  // MARK: Inspectable
  @IBInspectable var topColor: UIColor {
    didSet {
      setNeedsDisplay()
    }
  }
  @IBInspectable var botColor: UIColor {
    didSet {
      setNeedsDisplay()
    }
  }
  @IBInspectable var grayColor: UIColor {
    didSet {
      setNeedsDisplay()
    }
  }
  @IBInspectable var textColor: UIColor {
    didSet {
      setNeedsDisplay()
    }
  }
  
  
  // MARK: Private
  
  fileprivate var topProgress: CGFloat = 0.0 {
    didSet {
      oldTopProgress = oldValue
      setNeedsDisplay()
    }
  }
  fileprivate var botProgress: CGFloat = 0.0 {
    didSet {
      oldBotProgress = oldValue
      setNeedsDisplay()
    }
  }
  
  // Subviews
  fileprivate var inCircleLabel: LabelWithAdaptiveTextHeight!
  fileprivate var topLabel: LabelWithAdaptiveTextHeight!
  fileprivate var botLabel: LabelWithAdaptiveTextHeight!
  
  // Colors
  fileprivate struct DefaultColor {
    static let defaultGrayColor = UIColor(red:0.7, green:0.7, blue:0.7, alpha:0.15)
    static let defaultTopColor = UIColor(red:0.92, green:0.12, blue:0.39, alpha:1)
    static let defaultBotColor = UIColor(red:0, green:0.64, blue:0.96, alpha:1)
  }
  
  // Drawing related
  fileprivate var oldBotProgress: CGFloat = 0.0
  fileprivate var oldTopProgress: CGFloat = 0.0
  fileprivate var bottomPath: UIBezierPath!
  fileprivate var topPath: UIBezierPath!
  fileprivate var topLayer: CAShapeLayer?
  fileprivate var botLayer: CAShapeLayer?
  
  
  // MARK: Initialization
  override init(frame: CGRect) {
    textColor = DefaultColor.defaultGrayColor
    grayColor = DefaultColor.defaultGrayColor
    topColor = DefaultColor.defaultTopColor
    botColor = DefaultColor.defaultBotColor
    super.init(frame: frame)
    recalculatePathes()
  }
  
  required init?(coder aDecoder: NSCoder) {
    textColor = DefaultColor.defaultGrayColor
    grayColor = DefaultColor.defaultGrayColor
    topColor = DefaultColor.defaultTopColor
    botColor = DefaultColor.defaultBotColor
    super.init(coder: aDecoder)
    recalculatePathes()
  }
  
}

// MARK: - UIView
extension DoubleProgressBar {
  
  override func draw(_ rect: CGRect) {
    grayColor.setStroke()
    bottomPath.lineWidth = 2.0
    bottomPath.stroke()
    topPath.lineWidth = 2.0
    topPath.stroke()
    topPath.drawInView(topLayer!, view: self, strokeColor: topColor, lineWidth: 2.0, oldProgress: oldTopProgress, progress: topProgress,animated: true)
    oldTopProgress = topProgress
    bottomPath.drawInView(botLayer!, view: self, strokeColor: botColor, lineWidth: 2.0, oldProgress: oldBotProgress, progress: botProgress, animated: true)
    oldBotProgress = botProgress
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    update()
  }
}


// MARK: - Public API
extension DoubleProgressBar {
  
  func update() {
    recalculatePathes()
    setNeedsDisplay()
  }
  
  func setup(_ datasource: DoubleProgressBarProgressDataSource?) {
    guard let datasource = datasource else { return }
    topLabel.text = datasource.topTitle
    botLabel.text = datasource.botTitle
    topProgress = datasource.topProgressPercentage
    botProgress = datasource.botProgressPercentage
    inCircleLabel.text = datasource.levelString
  }
}


// MARK: - Private
extension DoubleProgressBar {
  
  fileprivate func recalculatePathes() {
    
    self.insertSublayersIfNeeded()
    self.insertSubviewsIfNeeded()
    
    let kof: CGFloat = 0.9
    
    let usualHeight = bounds.height * 0.75
    let maxDelta: CGFloat = 15.0
    
    let height = usualHeight
    let radius = height * 0.5
    
    let angle: CGFloat = CGFloat(M_PI) * kof
    
    let k = radius * cos(angle)
    let q = radius * sin(angle)
    
    let delta: CGFloat = min(maxDelta, (bounds.height - usualHeight) * 0.5)
    let lHeight = 0.5 * bounds.height - q - (delta)
    self.updateSubviewsFrames(delta, labelHeight: lHeight, progresBarHeight: height)
    
    
    let rightSquare = CGRect(x: bounds.width - height - delta, y: delta, width: height, height: height)
    inCircleLabel.frame = rightSquare
    do {
      let endpoint = CGPoint(x: rightSquare.center.x - k, y: rightSquare.center.y + q)
      let farLeftPoint = CGPoint(x: delta, y: endpoint.y)
      bottomPath = UIBezierPath(arcCenter: rightSquare.center, radius: radius, startAngle: 0.0, endAngle: angle, clockwise: true)
      bottomPath.addLine(to: farLeftPoint)
    }
    
    do {
      let a = CGFloat(M_PI) * (2 - kof)
      let endpoint = CGPoint(x: rightSquare.center.x - k, y: rightSquare.center.y - q)
      let farLeftPoint = CGPoint(x: delta, y: endpoint.y)
      topPath = UIBezierPath(arcCenter: rightSquare.center, radius: radius, startAngle: 0.0, endAngle: a, clockwise: false)
      topPath.addLine(to: farLeftPoint)
      topPath = UIBezierPath.reversing(topPath)()
    }
  }
  
  fileprivate func insertSubviewsIfNeeded() {
    if inCircleLabel == nil {
      inCircleLabel = LabelWithAdaptiveTextHeight(frame: CGRect.zero)
      inCircleLabel.heightKoefitient = 0.4
      inCircleLabel.text = "17"
      inCircleLabel.textAlignment = NSTextAlignment.center
      inCircleLabel.backgroundColor = UIColor.clear
      addSubview(inCircleLabel)
    }
    if topLabel == nil {
      topLabel = LabelWithAdaptiveTextHeight(frame: CGRect.zero)
      topLabel.heightKoefitient = 0.6
      topLabel.backgroundColor = UIColor.clear
      addSubview(topLabel)
    }
    if botLabel == nil {
      botLabel = LabelWithAdaptiveTextHeight(frame: CGRect.zero)
      botLabel.heightKoefitient = 0.6
      botLabel.backgroundColor = UIColor.clear
      addSubview(botLabel)
    }
  }
  
  fileprivate func insertSublayersIfNeeded() {
    if topLayer == nil {
      topLayer = CAShapeLayer()
      layer.addSublayer(topLayer!)
    }
    if botLayer == nil {
      botLayer = CAShapeLayer()
      layer.addSublayer(botLayer!)
    }
  }
  
  fileprivate func updateSubviewsFrames(_ margin: CGFloat, labelHeight: CGFloat, progresBarHeight: CGFloat) {
    let topLabelFrame = CGRect(x: margin, y: 0.5 * margin, width: 0.5 * bounds.width, height: labelHeight)
    topLabel.frame = topLabelFrame
    topLabel.textColor = textColor
    
    let botLabelFrame = CGRect(x: margin, y: bounds.height - 0.5 * margin - labelHeight, width: 0.5 * bounds.width, height: labelHeight)
    botLabel.frame = botLabelFrame
    botLabel.textColor = textColor
    
    let rightSquare = CGRect(x: bounds.width - progresBarHeight - margin, y: margin, width: progresBarHeight, height: margin)
    inCircleLabel.frame = rightSquare
  }
}

extension UIBezierPath {
  
  fileprivate func drawInView(_ bezier: CAShapeLayer, view: UIView, strokeColor: UIColor, lineWidth: CGFloat, oldProgress: CGFloat, progress: CGFloat, animated: Bool) {
    
    bezier.removeAllAnimations()
    
    bezier.path = self.cgPath
    bezier.strokeColor = strokeColor.cgColor
    bezier.lineWidth = lineWidth
    bezier.strokeStart = 0.0
    bezier.strokeEnd = progress
    bezier.fillColor = nil
    bezier.lineJoin = kCALineJoinBevel
    
    if animated {
      let animateStrokeEnd = CABasicAnimation(keyPath: "strokeEnd")
      animateStrokeEnd.duration = 0
      animateStrokeEnd.fromValue = progress
      animateStrokeEnd.toValue = progress
      bezier.add(animateStrokeEnd, forKey: "strokeEndAnimation")
    }
  }
}
