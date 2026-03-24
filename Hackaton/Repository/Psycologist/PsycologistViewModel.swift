//
//  PsycologistViewModel.swift
//  Hackaton
//
//  Created by Annete Morado on 24/03/26.
//

import Foundation
import Combine

final class PsycologistViewModel: ObservableObject{
    @Published var psycologists: [PsycologistModel] = []
    @Published var messageError: String?
    
    private let psycologistRepository: PsycologistRepository
    
    init(psycologistRepository: PsycologistRepository = PsycologistRepository()) {
        self.psycologistRepository = psycologistRepository
    }
    
    func getAllPsycologists() {
        psycologistRepository.getAllPsycologists{
            [weak self] result in
            switch result {
            case .success(let PsycologistModels):
                self?.psycologists = PsycologistModels
            case .failure(let error):
                self?.messageError = error.localizedDescription          // <-- y aquí
            }
        }
    }
}
