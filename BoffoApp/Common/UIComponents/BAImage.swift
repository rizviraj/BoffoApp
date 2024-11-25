//
//  BAImage.swift
//  BoffoApp
//
//  Created by MacBook Pro on 2024-11-23.
//

import SwiftUI

struct BAImage: View {
    var body: some View {
        Image(name)
            .renderingMode(renderingMode)
            .resizable()
            .scaledToFit()
            .frame(width: width, height: height)
            
    }
    
    var name: String
    var width: CGFloat = 15
    var height: CGFloat = 15
    var renderingMode: Image.TemplateRenderingMode = .template
    
    init(_ name: String, _ width: CGFloat = 15, _ height: CGFloat = 15, _ renderingMode: Image.TemplateRenderingMode = .template) {
        self.name = name
        self.width = width
        self.height = height
        self.renderingMode = renderingMode
    }
}
