//  VerticalListView.swift
//  Drishya
//  Created by UDIT PANDEY on 08/10/26.

import SwiftUI
import SwiftData

struct VerticalListView: View {
    let titles : [Title]
    let viewModel = ViewModel()
    let canDelete : Bool
    @Environment(\.modelContext) var modelContext
    
    var body: some View {

        GeometryReader { geo in
            
            List(titles){ title in
                
                NavigationLink{
                    TitleDetailView(title: title)
                } label: {
                    AsyncImage(url: URL(string: title.posterPath ?? "")){ image in
                        HStack {
                            image
                            
                                .resizable()
                                .scaledToFit()
                                .clipShape(.rect(cornerRadius: 12))
                                .padding(3)
                            
                            Text((title.name ?? title.title) ?? " ").font(.system(size: 14)).bold()
                        }
                    
                    }placeholder: {
                        ProgressView()
                    }
                    .frame(height: 150)
                }
                .swipeActions(edge: .trailing){
                    if canDelete {
                        Button{
                            modelContext.delete(title)
                            try? modelContext.save()
                        }label: {
                            Image(systemName: "trash")
                                .tint(.red)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    VerticalListView(titles: Title.previewTitles, canDelete: true)
}
