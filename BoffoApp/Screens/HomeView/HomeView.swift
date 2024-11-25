//
//  HomeView.swift
//  BoffoApp
//
//  Created by MacBook Pro on 2024-11-23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack{
            ScrollView{
                maincontentView
            }
        }
        .ignoresSafeArea(.all)
    }
    
    @ObservedObject private var viewModel: HomeViewModel
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}

extension HomeView {
    private var maincontentView: some View {
        VStack{
            topView
            
            reportView
        }
    }
    
    private var topView: some View {
        VStack{
            HStack{
                BAText("Location", .heading3, AppColor.white)
                Spacer()
                BAText("Temporature", .heading3, AppColor.white)
            }
            .padding(.top, 60)
            Spacer().frame(height: 20)
            HStack{
                BAText("Colombo", .body1, AppColor.white)
                Spacer()
                BAText("28", .body1, AppColor.white)
            }
        }
        .frame(height: 180)
        .padding(.horizontal, 15)
        .background(
            LinearGradient(gradient: Gradient(colors: [AppColor.btnPrimaryTop, AppColor.btnPrimaryBottom]), startPoint: .bottomLeading, endPoint: .topTrailing)
            )
    }
    
    private var reportView: some View{
        VStack(spacing: 20){
            HStack{
                BAImage("ic_logo", 100, 100)
                Spacer()
                VStack(alignment: .trailing){
                    BAText("Bluetooth Count", .heading4, AppColor.titleGray)
                    BAText("30", .body1, AppColor.titleGray)
                }
            }
            .padding(.horizontal, 15)
            .frame(height: 150)
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(AppColor.lineGray)
            )
            
            HStack{
                BAImage("ic_logo", 100, 100)
                Spacer()
                VStack(alignment: .trailing){
                    BAText("Number of Wifi Count", .heading4, AppColor.titleGray)
                    BAText("10", .body1, AppColor.titleGray)
                }
            }
            .padding(.horizontal, 15)
            .frame(height: 150)
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(AppColor.lineGray)
            )
            
            HStack{
                BAImage("ic_logo", 100, 100)
                Spacer()
                VStack(alignment: .trailing){
                    BAText("TCP Server Count", .heading4, AppColor.titleGray)
                    BAText("20", .body1, AppColor.titleGray)
                }
            }
            .padding(.horizontal, 15)
            .frame(height: 150)
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(AppColor.lineGray)
            )
        }
        .padding(.top, 20)
        .padding(.horizontal, 15)
    }
}
