//
//  LoadingView.swift
//  BoffoApp
//
//  Created by MacBook Pro on 2024-11-24.
//

import SwiftUI

struct LoadingView: View {
    @State var isAnimating = false
    @State private var isCircleRotating = true
    @State private var animateStart = false
    @State private var animateEnd = true
    
    var body: some View {
        ZStack {
            dismissSearchView
            Circle()
                .stroke(lineWidth: 2)
                .fill(AppColor.white)
                .frame(width: 80, height: 80)
            
            Circle()
                .trim(from: animateStart ? 1/3 : 1/9, to: animateEnd ? 2/5 : 1)
                .stroke(lineWidth: 2)
                .rotationEffect(.degrees(isCircleRotating ? 360 : 0))
                .frame(width: 80, height: 80)
                .foregroundColor(AppColor.primaryTop)
                .onAppear() {
                    withAnimation(Animation
                                    .linear(duration: 1)
                                    .repeatForever(autoreverses: false)) {
                        self.isCircleRotating.toggle()
                    }
                    withAnimation(Animation
                                    .linear(duration: 1)
                                    .delay(0.5)
                                    .repeatForever(autoreverses: true)) {
                        self.animateStart.toggle()
                    }
                    withAnimation(Animation
                                    .linear(duration: 1)
                                    .delay(1)
                                    .repeatForever(autoreverses: true)) {
                        self.animateEnd.toggle()
                    }
                }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}

extension LoadingView {
    private var dismissSearchView: some View {
        Color(.black)
            .opacity(0.2)
            .ignoresSafeArea(.all)
            .onTapGesture {
                //isShowSearch = false
            }
    }
}
