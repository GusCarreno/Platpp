//
//  VideosViewModelTests.swift
//  PlatppTests
//
//  Created by Gustavo on 28/7/23.
//

import Foundation
import XCTest
import Combine
@testable import Platpp // Importa el módulo de tu aplicación

class VideosViewModelTests: XCTestCase {
    var cancellables: Set<AnyCancellable> = []
    
    func testFetchVideos() {
        // Crear el MockVideoRepository con datos ficticios
        let mockVideos: [VideoModel] = [
            VideoModel(title: "Video 1", thumbnailURL: "thumbnail1.jpg", subtitle: "Subtítulo 1", duration: "2:30", descriptionText: "Descripción del video 1", videoURL: "video1.mp4"),
            VideoModel(title: "Video 2", thumbnailURL: "thumbnail2.jpg", subtitle: "Subtítulo 2", duration: "3:45", descriptionText: "Descripción del video 2", videoURL: "video2.mp4")
        ]
        let mockRepository = MockVideoRepository(mockVideos: mockVideos)
        
        // Crear el ViewModel con el MockVideoRepository inyectado
        let videosViewModel = VideosViewModel(repository: mockRepository)
        
        // Utilizar XCTestExpectation para esperar a que se completen las operaciones asíncronas.
        let expectation = XCTestExpectation(description: "Fetch Videos")
        
        // Simular la carga de videos
        videosViewModel.$videos
            .dropFirst() // Ignorar el valor inicial cuando se inicia la suscripción.
            .sink { videos in
                // Verificar que los videos devueltos coincidan con los datos ficticios del MockVideoRepository.
                XCTAssertEqual(videos.count, mockVideos.count)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // Iniciar la carga de videos.
        videosViewModel.loadVideos()
        
        // Esperar a que se complete la operación asíncrona.
        wait(for: [expectation], timeout: 5.0)
    }
}
