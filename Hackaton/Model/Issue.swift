//
//  Issue.swift
//  Hackaton
//
//  Created by Annete Morado on 23/03/26.
//

import Foundation

struct Issue: Codable, Hashable, Identifiable {
    var id: Int
    var issue: String
    var imageIssue: String
}
