//
//  Color+Extentsions.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 11/24/20.
//

import Foundation
#if canImport(UIKit)

import UIKit
extension UIColor {
    static var random: UIColor {
        return UIColor(
            red: .random(in: 0.4...1),
            green: .random(in: 0.4...1),
            blue: .random(in: 0.4...1),
            alpha: .random(in: 0.4...1)
        )
    }
}

#elseif canImport(SwiftUI)
import SwiftUI

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
  
#else
// all other platforms – use a custom color object
#endif
