//
//  PsycologistRepository.swift
//  Hackaton
//
//  Created by Annete Morado on 23/03/26.
//

import Foundation

final class PsycologistRepository {
    private let psycologistDataSource: PsychologistDataSource
    
    init(psycologistDataSource: PsychologistDataSource = PsychologistDataSource()){
        self.psycologistDataSource = psycologistDataSource
    }
    
    func getAllPsycologists(completitionBlock: @escaping (Result<[PsycologistModel], Error>) -> Void) {
        psycologistDataSource.getAllPsycologists(completitionBlock: completitionBlock)
    }
}
