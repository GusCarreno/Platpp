//
//  VideoDetailView.swift
//  Platpp
//
//  Created by Gustavo on 26/7/23.
//

import SwiftUI
import AVKit

struct VideoDetailView: View {
    @ObservedObject var viewModel: VideoDetailViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(viewModel.selectedVideo?.title ?? "")
                    .font(.title)
                // Aquí irían otros detalles completos del video

                // Reproductor de video o audio
                if let videoURL = viewModel.selectedVideo?.videoURL, let url = URL(string: videoURL) {
                    VideoPlayer(player: AVPlayer(url: url))
                        .frame(height: 300)
                }
            }
            .padding()
        }
        .navigationBarTitle(Text(viewModel.selectedVideo?.title ?? ""), displayMode: .inline)
    }
}

