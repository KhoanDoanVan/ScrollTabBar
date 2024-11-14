//
//  Home.swift
//  Scrollable Tab Bar
//
//  Created by Đoàn Văn Khoan on 14/11/24.
//

import SwiftUI

struct Home: View {
    
    @State private var tabs: [TabModel] = [
        .init(id: TabModel.Tab.research),
        .init(id: TabModel.Tab.deployment),
        .init(id: TabModel.Tab.analytics),
        .init(id: TabModel.Tab.audience),
        .init(id: TabModel.Tab.privacy)
    ]
    
    @State private var activeTab: TabModel.Tab = .research
    @State private var tabBarScrollState: TabModel.Tab?
    @State private var mainViewScrollState: TabModel.Tab?
    
    var body: some View {
        VStack {
            CustomTabBar()
            
            GeometryReader {
                let size = $0.size
                
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 0) {
                        
                        ForEach(tabs) { tab in
                            Text(tab.id.rawValue)
                                .frame(width: size.width, height: size.height)
                                .contentShape(.rect)
                        }
                        
                    }
                    .scrollTargetLayout()
                }
                .scrollPosition(id: $mainViewScrollState)
                .scrollIndicators(.hidden)
                .scrollTargetBehavior(.paging)
                .onChange(of: mainViewScrollState) { oldValue, newValue in
                    if let newValue {
                        withAnimation(.snappy) {
                            tabBarScrollState = newValue
                            activeTab = newValue
                        }
                    }
                }
            }
        }
    }
    
    /// Dynamic Scrollable Tab Bar
    @ViewBuilder
    func CustomTabBar() -> some View {
        ScrollView(.horizontal) {
            HStack(spacing: 20) {
                ForEach(tabs) { tab in
                    Button {
                        withAnimation(.snappy) {
                            activeTab = tab.id
                            tabBarScrollState = tab.id
                            mainViewScrollState = tab.id
                        }
                    } label: {
                        Text(tab.id.rawValue)
                            .padding(.vertical, 22)
                            .foregroundStyle(activeTab == tab.id ? Color.primary : .gray)
                            .contentShape(.rect)
                    }
                }
            }
            .scrollTargetLayout() /// To center the tabbar whenever the maintab is current tabbar
        }
        .safeAreaPadding(.horizontal, 15)
        .scrollIndicators(.hidden)
        /// To center the tabbar whenever the maintab is current tabbar
        .scrollPosition(id: .init(get: {
            return tabBarScrollState
        }, set: { _ in
            
        }), anchor: .center)
    }
}

#Preview {
    ContentView()
}
