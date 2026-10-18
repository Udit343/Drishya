//  UpcomingView.swift
//  Drishya
//  Created by UDIT PANDEY on 08/10/26.

import SwiftUI

struct UpcomingView: View {
    let viewModel = ViewModel()
    var body: some View {
        NavigationStack{
            GeometryReader{ geo in
                
                switch viewModel.upcomingStatus{
                case .notStarted:
                    EmptyView()
                case .fecthinng:
                    ProgressView("Loading upcoming movies...")
                        .frame(width: geo.size.width, height: geo.size.height)
                case .success:
                    VerticalListView(titles: viewModel.UpcomingMovies, canDelete: false)
                case .failed(let underLyingError):
                    Text(underLyingError.localizedDescription)
                    
                }
            }
            .navigationTitle("Upcoming Video")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color(cgColor: UIColor.systemGray3.withAlphaComponent(0.5).cgColor), for: .navigationBar)
            .toolbarBackground(.automatic, for: .navigationBar)
            .task {
                await viewModel.getUpcomingMovies()
            }
        }
    }
}

#Preview {
    UpcomingView()
}
