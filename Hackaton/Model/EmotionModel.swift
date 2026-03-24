//
//  EmotionModel.swift
//  Hackaton
//
//  Created by Annete Morado on 24/03/26.
//
import Foundation

struct EmotionModel: Identifiable {
    let id = UUID()
    let emoji: String
    let name: String
    let description: String
}

extension EmotionModel {
    static let all: [EmotionModel] = [
        EmotionModel(emoji: "😊", name: "Feliz", description: "La felicidad es un estado emocional positivo caracterizado por sensaciones de bienestar, satisfacción y alegría."),
        EmotionModel(emoji: "😢", name: "Triste", description: "La tristeza es una emoción natural que surge ante pérdidas o situaciones difíciles. Es parte del proceso emocional humano."),
        EmotionModel(emoji: "😠", name: "Enojado", description: "El enojo es una respuesta emocional ante situaciones que percibimos como injustas o frustrantes. Manejarlo bien es clave."),
        EmotionModel(emoji: "😰", name: "Ansiedad", description: "La ansiedad es una sensación de preocupación o miedo intenso que puede afectar tu día a día y bienestar general."),
        EmotionModel(emoji: "😌", name: "Calma", description: "La calma es un estado de tranquilidad mental y emocional. Es fundamental para tomar buenas decisiones.")
    ]
}
