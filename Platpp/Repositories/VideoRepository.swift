//
//  VideoRepository.swift
//  Platpp
//
//  Created by Gustavo on 26/7/23.
//
import RealmSwift
import Combine
import Foundation

class VideoRepository {
    private var realm: Realm {
        do {
            return try Realm()
        } catch {
            fatalError("Error initializing Realm: \(error)")
        }
    }

    func fetchVideos() -> AnyPublisher<[VideoModel], Error> {
        // Si se está en modo offline, cargar los videos almacenados en Realm
        if !ConnectivityMonitor.isOnline {
            let videos = Array(realm.objects(VideoModel.self))
            return Just(videos)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }

        // En caso contrario, obtener los videos de una fuente remota (por ejemplo, una API)
        // y guardarlos en Realm para el modo offline
        guard let url = URL(string: "https://example.com/api/videos") else {
            return Fail(error: NSError(domain: "Invalid URL", code: 0)).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [DecodedVideoModel].self, decoder: JSONDecoder())
            .map { decodedVideos in
                // Copiar los datos decodificados en objetos de VideoModel de Realm
                let realm = try! Realm()
                let videos = decodedVideos.compactMap { decodedVideo in
                    let videoModel = VideoModel()
                    videoModel.title = decodedVideo.title
                    videoModel.thumbnailURL = decodedVideo.thumbnailURL
                    videoModel.subtitle = decodedVideo.subtitle
                    videoModel.duration = decodedVideo.duration
                    videoModel.descriptionText = decodedVideo.descriptionText
                    videoModel.videoURL = decodedVideo.videoURL
                    return videoModel
                }
                try! realm.write {
                    realm.add(videos, update: .modified)
                }
                return videos
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
