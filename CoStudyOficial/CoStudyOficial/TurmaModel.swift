//
//  TurmaModel.swift
//  CoStudyOficial
//
//  Created by found on 11/02/25.
//
import SwiftUI
import Foundation

struct Turma: Identifiable {
    let id = UUID()
    let codigo : String
    var nome: String
    var descricao: String
    var materias: [Materia] = []
    var eventos: [String] = []
    
    static func gerarCodigo() -> String {
        let length : Int = 6
        let caracteres = "abcdefghijkmnpqrstuvwxyz23456789"
        return String((0..<length).map { _ in caracteres.randomElement()! })
    }
}
