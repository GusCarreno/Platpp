//
//  VideoModel.swift
//  Platpp
//
//  Created by Gustavo on 26/7/23.
//

import RealmSwift

class VideoModel: Object {
    @Persisted var title: String = ""
    @Persisted var thumbnailURL: String = ""
    @Persisted var subtitle: String = ""
    @Persisted var duration: String = ""
    @Persisted var descriptionText: String = ""
    @Persisted var videoURL: String = ""
}

struct DecodedVideoModel: Decodable {
    let title: String
    let thumbnailURL: String
    let subtitle: String
    let duration: String
    let descriptionText: String
    let videoURL: String
}
