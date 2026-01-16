//
//  SearchOverlay.swift
//  Vela
//
//  Created by Manuel Alejandro Hernandez Marín on 14/01/26.
//

import Foundation
import SwiftUI

struct SearchOverlay : View {
    
    @Binding var searchText : String
    @Binding var isPresented : Bool
    
    var body : some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.spring(response : 0.3)){
                        isPresented = false
                        searchText = ""
                    }
                }
            
            VStack {
                HStack(spacing : 12){
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.white.opacity(0.6))
                    
                    TextField("Buscar divisa...", text: $searchText)
                        .foregroundStyle(.white)
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                    
                    if !searchText.isEmpty {
                        Button {
                            searchText = ""
                        } label : {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(.white.opacity(0.6))
                        }
                    }
                    
                    Button {
                        withAnimation(.spring(response : 0.3)){
                            isPresented = false
                            searchText = ""
                        }
                    } label: {
                        Text("Cancelar")
                            .foregroundStyle(Color(hex : "a78bfa"))
                            .fontWeight(.semibold)
                    }
                }
                .padding(16)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.white.opacity(0.2), lineWidth: 1)
                )
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                Spacer()
            }
        }
        .transition(.opacity)
    }
}


#Preview {
    SearchOverlay(
        searchText: .constant("bitcoin"),
        isPresented: .constant(false)
    )
}
