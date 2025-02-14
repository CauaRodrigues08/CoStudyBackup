//
//  Modais.swift
//  CoStudyOficial
//
//  Created by found on 11/02/25.
//
import SwiftUI


//Modal do botão de criar e entrar em turmas
struct ModalCriarEntrarView: View {
    
    @State var ModalCriarTurma = false
    @State var ModalEntrarTurma = false
    @State var codigo = ""
    @Binding var turmas : [Turma]
    @Binding var turmasTeste : [Turma]
    
    var onCreate: (Turma) -> Void
    
    var body: some View {
        Section{
            Button(action: {
                ModalCriarTurma = true
            }, label: {
                ZStack{
                    Rectangle()
                        .foregroundColor(Color(hex:"298B87"))
                        .cornerRadius(15)
                        .foregroundStyle(.white)
                        .frame(width: 337 , height: 44)
                    HStack {
                        Text("Criar turma")
                            .foregroundStyle(.white)
                            .font(.headline)
                        
                        Spacer()
                        
                        Image(systemName: "plus.square")
                            .foregroundStyle(.white)
                            .font(.system(size: 20))
                    }
                    .padding(.horizontal, 20)
                }

            })
            .padding()
            
            Button(action: {
                ModalEntrarTurma = true
            }, label: {
                ZStack{
                    Rectangle()
                        .foregroundColor(Color(hex:"298B87"))
                        .cornerRadius(15)
                        .foregroundStyle(.white)
                        .frame(width: 337 , height: 44)
                    
                    HStack{
                        Text("Entrar em turma")
                            .foregroundStyle(.white)
                            .font(.headline)
                            .padding(.leading, 10)
                        
                        Spacer()
                        
                        Image(systemName: "person.3.fill")
                            .foregroundStyle(.white)
                            .font(.system(size: 20))
                        
                    }
                    .padding(.horizontal, 27)
                }
                    
            })
            
        }
        .padding()
        .listStyle(.plain)
        .sheet(isPresented: $ModalEntrarTurma) {
            ModalEntrarTurmaView(turmas: $turmas, turmasTeste: $turmasTeste)
                .presentationDetents([.fraction(0.205)])
                .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $ModalCriarTurma) {
            ModalCriarTurmaView(onCreate: onCreate)
                .presentationDetents([.fraction(0.4)])
                .presentationDragIndicator(.visible)
        
        }
    }
}

//Modal do botão entrar em turma
struct ModalEntrarTurmaView: View {
    
    @State private var codigoDigitado: String = ""
    @Binding var turmas: [Turma]
    @Binding var turmasTeste: [Turma]
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        TextField("Digite aqui", text: $codigoDigitado)
                            .textInputAutocapitalization(.never)
                    } header: {
                        Text("Código da turma")
                    }
                }
                
                .toolbar {
                    ToolbarItem(placement: .navigation) {
                        Button("Cancelar") { dismiss() }
                    }
                    
                    ToolbarItem(placement: .confirmationAction) {
                        Button(action: {
                            if let turmaEncontrada = turmasTeste.first(where: { $0.codigo == codigoDigitado }) {
                                if !turmas.contains(where: { $0.codigo == turmaEncontrada.codigo }) {
                                    turmas.append(turmaEncontrada)
                                }
                                presentationMode.wrappedValue.dismiss()
                            }
                            
                        }, label: {
                                Text("Entrar")
                        })
                    }
                }
            }
        }
    }
    
}
    


//Modal do botão "Criar turma"
struct ModalCriarTurmaView: View {
    
    @State var nome: String = ""
    @State var descricao: String = ""
    @State var codigo: String = Turma.gerarCodigo()
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    
    var onCreate: (Turma) -> Void
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        TextField("Digite aqui", text: $nome)
                    } header: {
                        Text("Nome")
                    }
                    Section {
                        TextField("Digite aqui", text: $descricao)
                    } header: {
                        Text("Descrição")
                    }
                    
                    .toolbar {
                        ToolbarItem(placement: .navigation) {
                            Button("Cancelar") { dismiss()}
                        }
                        
                        ToolbarItem(placement: .confirmationAction) {
                            Button(action: {
                                let novaTurma = Turma(codigo: codigo, nome: nome, descricao: descricao)
                                onCreate(novaTurma)
                                presentationMode.wrappedValue.dismiss()
                            }, label: {
                                    Text("Criar")
                            })
                        }
                    }
                    
                   
                }
            }
        }
        
    }
}

//Modal do botão de configurar turma
struct ModalConfigurarView: View {
    
    @Binding var mostrarPopup: Bool
    @State var ModalEditarTurma = false
    
    var body: some View {
        VStack {
            Button(action: {
                ModalEditarTurma = true
            }, label: {
                ZStack {
                    Rectangle()
                        .foregroundColor(Color(hex: "298B87"))
                        .cornerRadius(15)
                        .frame(width: 337, height: 44)
                    Text("Editar turma")
                        .foregroundStyle(.white)
                        .font(.headline)
                }
            })
            .padding()
            
            Button(action: {
                mostrarPopup = true
            }, label: {
                ZStack {
                    Rectangle()
                        .foregroundColor(Color(hex: "298B87"))
                        .cornerRadius(15)
                        .frame(width: 337, height: 44)
                    Text("Excluir turma")
                        .foregroundStyle(.white)
                        .font(.headline)
                }
            })
        }
        .presentationDragIndicator(.visible)
        .sheet(isPresented: $ModalEditarTurma) {
            ModalEditarTurmaView()
                .presentationDetents([.fraction(0.4)])
        }
    }
}

//Modal de edição de turma
struct ModalEditarTurmaView: View {
    @State private var nome: String = ""
    @State private var descricao: String = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("Digite aqui", text: $nome)
                } header: {
                    Text("Nome")
                }
                Section {
                    TextField("Digite aqui", text: $descricao)
                } header: {
                    Text("Descrição")
                }
                
                //Ver como tirar fundo branco
                Button(action: {
                    
                }, label: {
                    ZStack{
                        Rectangle()
                            .foregroundColor(Color(hex:"298B87"))
                            .cornerRadius(15)
                            .foregroundStyle(.white)
                            .frame(width: 337 , height: 44)
                        Text("Atualizar")
                            .foregroundStyle(.white)
                        
                    }
                    
                })
            }
            .presentationDragIndicator(.visible)
        }
        
    }
        
}

//Popup de confirmação de exclusão
struct PopupExcluirTurmaView: View {
    
    @Binding var mostrarPopup: Bool
    
    var body: some View {
        ZStack {
            
            Color.black.opacity(0.5)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture { mostrarPopup = false }

           
            VStack(spacing: 20) {
                Text("Deseja excluir a turma?")
                    .font(.system(size: 17))
                    .padding()

                HStack {
                    Button("Cancelar") {
                        mostrarPopup = false
                    }
                    .padding()
                    .background(Color.blue.opacity(0.9))
                    .cornerRadius(8)
                    .foregroundStyle(.white)

                    Button("Excluir") {
                        
                        mostrarPopup = false
                    }
                    .padding()
                    .background(Color.red.opacity(1.0))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
            }
            .frame(width: 300, height: 200)
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 10)
        }
    }
}
