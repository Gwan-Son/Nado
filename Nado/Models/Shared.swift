//
//  Shared.swift
//  Nado
//
//  Created by 심관혁 on 3/19/24.
//

import UIKit

class IndicatorView: UIView {
    var color = UIColor.clear {
        didSet { setNeedsDisplay() }
    }
    
    override func draw(_ rect: CGRect) {
        color.set()
        UIBezierPath(ovalIn: rect).fill()
    }
}

enum ActionDescriptor {
    case done, undone, star, unstar, trash
    
    func title(forDisplayMode displayMode: ButtonDisplayMode) -> String? {
        guard displayMode != .imageOnly else { return nil }
        
        switch self {
        case .done: return "Read"
        case .undone: return "Unread"
        case .star: return "More"
        case .unstar: return "Flag"
        case .trash: return "Trash"
        }
    }
    
    func image(forStyle style: ButtonStyle, displayMode: ButtonDisplayMode) -> UIImage? {
        guard displayMode != .titleOnly else { return nil }
        
        let name: String
        switch self {
        case .done: name = "Done"
        case .undone: name = "Undone"
        case .star: name = "Star"
        case .unstar: name = "Unstar"
        case .trash: name = "Trash"
        }
        
#if canImport(Combine)
        if #available(iOS 13.0, *) {
            let name: String
            switch self {
            case .done: name = "xmark.circle.fill"
            case .undone: name = "checkmark.circle.fill"
            case .star: name = "star.slash.fill"
            case .unstar: name = "star.fill"
            case .trash: name = "trash.fill"
            }
            
            if style == .backgroundColor {
                let config = UIImage.SymbolConfiguration(pointSize: 23.0, weight: .regular)
                return UIImage(systemName: name, withConfiguration: config)
            } else {
                let config = UIImage.SymbolConfiguration(pointSize: 22.0, weight: .regular)
                let image = UIImage(systemName: name, withConfiguration: config)?.withTintColor(.white, renderingMode: .alwaysTemplate)
                return circularIcon(with: color(forStyle: style), size: CGSize(width: 59, height: 59), icon: image)
            }
        } else {
            return UIImage(named: style == .backgroundColor ? name : name + "-circle")
        }
#else
        return UIImage(named: style == .backgroundColor ? name : name + "-circle")
#endif
    }
    
    func color(forStyle style: ButtonStyle) -> UIColor {
#if canImport(Combine)
        switch self {
        case .done, .undone: return UIColor.systemBlue
        case .star, .unstar: return UIColor.systemOrange
        case .trash: return UIColor.systemRed
        }
#else
        switch self {
        case .done, .undone: return #colorLiteral(red: 0, green: 0.4577052593, blue: 1, alpha: 1)
        case .star, .unstar: return #colorLiteral(red: 1, green: 0.5803921569, blue: 0, alpha: 1)
        case .trash: return #colorLiteral(red: 1, green: 0.2352941176, blue: 0.1882352941, alpha: 1)
        }
#endif
    }
    
    func circularIcon(with color: UIColor, size: CGSize, icon: UIImage? = nil) -> UIImage? {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
        let clipPath = UIBezierPath(roundedRect: rect, cornerRadius: 15)
        clipPath.addClip()
        color.setFill()
        UIRectFill(rect)
        
        if let icon = icon {
            let iconRect = CGRect(x: (rect.size.width - icon.size.width) / 2,
                                  y: (rect.size.height - icon.size.height) / 2,
                                  width: icon.size.width,
                                  height: icon.size.height)
            icon.draw(in: iconRect, blendMode: .normal, alpha: 1.0)
        }
        
        defer { UIGraphicsEndImageContext() }
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
enum ButtonDisplayMode {
    case titleAndImage, titleOnly, imageOnly
}

enum ButtonStyle {
    case backgroundColor, circular
}
