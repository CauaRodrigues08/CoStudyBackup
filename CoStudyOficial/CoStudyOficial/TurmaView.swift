//
//  TurmaView.swift
//  CoStudyOficial
//
//  Created by found on 11/02/25.
//
import SwiftUI

struct TurmaView: View {
    
    let turma: Turma
    @State var materias: [Materia] = []
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
            Text("Codigo da turma:\(turma.codigo)")
            
        
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: { dismiss() }) {
                    HStack {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(Color(hex: "00504C"))
                        Text("Turmas")
                            .tint(Color(hex: "00504C"))
                    }
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    
                }) {
                    Label("", systemImage: "plus.square.fill")
                        .font(.system(size: 48))
                        .foregroundStyle(Color(hex: "00504C"))
                }
                .tint(Color(hex: "00504C"))
            }
        }
    }
}

