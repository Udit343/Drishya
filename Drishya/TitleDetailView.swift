//  TitleDetailView.swift
//  Drishya
//  Created by UDIT PANDEY on 06/10/26.


import SwiftUI
import SwiftData

struct TitleDetailView: View {
    let title : Title
    var titleName: String {
            return (title.name ?? title.title) ?? ""
        }
    let viewModel = ViewModel()
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        GeometryReader{ Geometry in
            switch viewModel.videoIdStatus {
            case .notStarted:
                EmptyView()
            case .fecthinng:
                ProgressView()
                     .frame(width: Geometry.size.width, height: Geometry.size.height)
            case .success:
                ScrollView{
                    LazyVStack(alignment: .leading){
                        YoutubePlayer(videoId: viewModel.videoId).aspectRatio(1.3,contentMode: .fit)
            
                            
                        Text(titleName)
                            .font(.title2)
                            .bold()
                            .padding(6)
                            .padding(.bottom, 3)
                        Text(title.overview ?? "")
                            .padding(4)
                        
                    }
                    Button{
                        let saveTitle = title
                        saveTitle.title = titleName
                        modelContext.insert(saveTitle)
                        try? modelContext.save()
                    }label: {
                        Text(Constant.downloadString)
                            .ghostButton()
                    }
                    .padding(10)
                }
            case .failed(let underLyingError):
                Text(underLyingError.localizedDescription)
            }
        }
        .task {
            await viewModel.getVideoId(for: titleName)
        }
    }
}


#Preview {
    TitleDetailView(title: Title.previewTitles[0])
}
