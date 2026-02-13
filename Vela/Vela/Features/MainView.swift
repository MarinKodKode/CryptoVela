//
//  MainView.swift
//  Vela
//
//  Created by Manuel Alejandro Hernandez Marín on 19/01/26.
//

import Foundation
import SwiftUI

struct ContentMainView : View {
    
    @State private var searchText  : String = ""
    @State private var expandMiniPlayer : Bool = false
    
    var body: some View {
        Group {
            if #available(iOS 26, *){
                NativeTabView()
                    
            }else{
                NativeTabView()
            }
        }
        .fullScreenCover(isPresented: $expandMiniPlayer){
            ScrollView {
                
            }
            .safeAreaInset(edge: .top, spacing : 0){
                
                VStack(spacing : 10 ){
                    
                    Capsule()
                        .fill()
                        .frame(width: 35, height: 3)
                    
                    HStack(spacing : 15){
                        
                        Spacer(minLength: 0)
                        
                        Group {
                            Button("" , systemImage: "star.circle.fill") {
                                
                            }
                            
                            Button("", systemImage: "ellipsis.circle.fill"){
                                
                            }
                        }
                        .font(.title)
                        .foregroundStyle(Color.primary, Color.primary.opacity(0.1))
                    }
                    .padding(.horizontal, 15)
                }
            }
        }
    }
    
    
    @ViewBuilder
    func NativeTabView() -> some View {
        TabView {
            Tab.init("Market", systemImage: "ring.dashed"){
                NavigationStack {
                    MarketView()
                }
            }
            Tab.init("Saved", systemImage: "bookmark.fill"){
                NavigationStack {
                    TradingView()
                }
            }
            Tab.init("Learning", systemImage: "graduationcap.fill"){
                NavigationStack {
                    LearningView()
                }
            }
            Tab.init("Account", systemImage: "person.fill"){
                NavigationStack {
                    AccountView()
                }
            }
            Tab.init("Search", systemImage: "magnifyingglass", role: .search){
                NavigationStack {
                    SearchView()
                    .searchable(
                        text: $searchText,
                        placement: .toolbar,
                        prompt: Text("Search...")
                    )
                }
            }
        }
    }
    
    @ViewBuilder
    func PlayerInfo(_ size : CGSize) -> some View {
        HStack(spacing : 12){
            RoundedRectangle(cornerRadius: size.height / 4)
                .fill(.blue.gradient)
                .frame(width : size.width, height: size.height)
            
            VStack(alignment: .leading, spacing : 6) {
                Text("Some apple music title")
                    .font(.callout)
                Text("Some Artist Name")
                    .font(.caption2)
                    .foregroundStyle(.gray)
            }
            .lineLimit(1)
        }
    }
    
    @ViewBuilder
    func MiniPlayerView() -> some View {
        HStack(spacing : 15){
            PlayerInfo(.init(width: 30, height: 30))
            
            Spacer(minLength: 0)
            
            Button {
                
            }label : {
                Image(systemName: "play.fill")
                    .contentShape(.rect)
            }
            .padding(.trailing, 10)
            
            Button{
                
            } label : {
                Image(systemName: "forward.fill")
                    .contentShape(.rect)
            }
        }
        .padding(.horizontal, 15)
    }
}

#Preview {
    ContentMainView()
}
