//  TaskWrap.swift
//  Drishya
//  Created by UDIT PANDEY on 15/10/26.


import Foundation
import SwiftUI

struct FlowLayout: Layout {
    var Hspacing : CGFloat = 8
    var VSpacing : CGFloat = 8
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        
        let maxWidth = proposal.width ?? .infinity
        
        var x : CGFloat = 0
        var y : CGFloat = 0
        var rowHeight : CGFloat = 0
        var usedWidth : CGFloat = 0
        
        for sub in subviews {
            let size = sub.sizeThatFits(.unspecified)
            if x + size.width > maxWidth && x > 0 {
                y += rowHeight + VSpacing
                x = 0
                rowHeight = 0
            }
            x += size.width + Hspacing
            usedWidth = max(usedWidth, x - Hspacing)
            rowHeight = max(rowHeight, size.height)
        }
        return CGSize(width: usedWidth, height: y + rowHeight)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var x = bounds.minX
        var y = bounds.minY
        var rowHeight : CGFloat = 0
        for sub in subviews {
                let size = sub.sizeThatFits(.unspecified)
                if x + size.width > bounds.maxX && x > bounds.minX {
                    y += rowHeight + VSpacing
                    x = bounds.minX
                    rowHeight = 0
                    
                }
                sub.place(at: CGPoint(x: x, y: y), proposal: ProposedViewSize(size))
                x += size.width + Hspacing
                rowHeight = max(rowHeight, size.height)
        }
    }
}
