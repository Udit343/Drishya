//  ContentView.swift
//  Drishya
//  Created by UDIT PANDEY on 28/09/26.

import SwiftUI
struct ContentView: View {
    var body: some View {
        TabView{
            Tab(Constant.homeString,systemImage: Constant.homeIconString){
                HomeView()
                //Text(Constant.homeString)
            }
            Tab(Constant.UpComingString, systemImage: Constant.UpComingIconString){
                UpcomingView()
            }
            Tab(Constant.searchString, systemImage: Constant.searchIconString){
                SearchView()
            }
            Tab(Constant.downloadString, systemImage: Constant.downloadIcondString){
                DownloadView()
            }
        }
        
    }
}

#Preview{
    ContentView()
}
