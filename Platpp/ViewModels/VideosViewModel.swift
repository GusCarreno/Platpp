//
//  VideosViewModel.swift
//  Platpp
//
//  Created by Gustavo on 26/7/23.
//

import Foundation
import RealmSwift
import Combine

class VideosViewModel: ObservableObject {
    @Published var videos: [VideoModel] = []
    private let repository = VideoRepository()

    private var cancellables = Set<AnyCancellable>()

    func loadVideos() {
        repository.fetchVideos()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                // Handle any completion events, if needed
            } receiveValue: { [weak self] videos in
                self?.videos = videos
            }
            .store(in: &cancellables)
    }
}

class VideoDetailViewModel: ObservableObject {
    @Published var selectedVideo: VideoModel?

    init(selectedVideo: VideoModel?) {
        self.selectedVideo = selectedVideo
    }
}
