//
//  VideosListView.swift
//  Platpp
//
//  Created by Gustavo on 26/7/23.
//

import SwiftUI

struct VideosListView: View {
    @ObservedObject var viewModel: VideosViewModel
    @State private var showingDetail = false
    @State private var selectedVideo: VideoModel?

    var body: some View {
        NavigationView {
            List(viewModel.videos, id: \.self) { video in
                VStack(alignment: .leading) {
                    Text(video.title)
                    // Aquí irían otros detalles esenciales del video
                }
                .onTapGesture {
                    selectedVideo = video
                    showingDetail = true
                }
            }
            .navigationBarTitle("Lista de Videos")
        }
        .sheet(isPresented: $showingDetail) {
            if let video = selectedVideo {
                VideoDetailView(viewModel: VideoDetailViewModel(selectedVideo: video))
            }
        }
        .onAppear {
            viewModel.loadVideos()
        }
    }
}

