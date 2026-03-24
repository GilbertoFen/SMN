//
//  TravelCard 2.swift
//  Hackaton
//
//  Created by Annete Morado on 24/03/26.
//


import Foundation

struct TravelCard: Codable, Identifiable, Hashable
{
    let title: String
    let subtitle: String
    let imageName: String
    let psycologist: PsycologistModel?

    var id: String { title + imageName }

    enum CodingKeys: String, CodingKey
    {
        case title
        case subtitle
        case imageName
        case psycologist
    }

    init(
        title: String,
        subtitle: String,
        imageName: String,
        psycologist: PsycologistModel? = nil
    )
    {
        self.title = title
        self.subtitle = subtitle
        self.imageName = imageName
        self.psycologist = psycologist
    }

    init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.title = try container.decode(String.self, forKey: .title)
        self.subtitle = try container.decode(String.self, forKey: .subtitle)
        self.imageName = try container.decode(String.self, forKey: .imageName)
        self.psycologist = try container.decodeIfPresent(PsycologistModel.self, forKey: .psycologist)
    }
}
