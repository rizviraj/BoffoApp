//
//  BAButtonConfiguration.swift
//  BoffoApp
//
//  Created by MacBook Pro on 2024-11-23.
//

import SwiftUI

struct BAButtonConfiguration {

    let textColor: Color
    let backgroundColor: Color
    let backgroundColorTwo: Color
    let strokeColor: Color
}

extension BAButtonConfiguration {

    /// white text, primary background, primary stroke
    static let primary = BAButtonConfiguration(textColor: .white,
                                               backgroundColor: AppColor.primaryGreen,
                                               backgroundColorTwo: AppColor.primaryGreen,
                                               strokeColor: .primary)
    
    static let none = BAButtonConfiguration(textColor: .clear,
                                            backgroundColor: .white,
                                            backgroundColorTwo: .white,
                                               strokeColor: .clear)
    
    static let desable = BAButtonConfiguration(textColor: AppColor.white,
                                               backgroundColor: AppColor.darkGray,
                                               backgroundColorTwo: AppColor.darkGray,
                                               strokeColor: .clear)
    
    static let blueButton = BAButtonConfiguration(textColor: .white,
                                            backgroundColor: AppColor.primaryTop,
                                            backgroundColorTwo: AppColor.primaryBottom,
                                                strokeColor: .primary)
}
