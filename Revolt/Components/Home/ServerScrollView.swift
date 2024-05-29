//
//  ServerScrollView.swift
//  Revolt
//
//  Created by Angelo Manca on 2023-11-25.
//

import SwiftUI

struct ServerScrollView: View {
    let buttonSize = 44.0
    let viewWidth = 60.0
    
    @EnvironmentObject var viewState: ViewState
    @Binding var showJoinServerSheet: Bool
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                Spacer()
                    .frame(height: buttonSize + 12 + 8)
                Section {
                    ForEach(viewState.servers.elements, id: \.key) { elem in
                        Button(action: {
                            viewState.currentServer = .server(elem.value.id)
                        }) {
                            ZStack(alignment: .topTrailing) {
                                ServerListIcon(server: elem.value, height: buttonSize, width: buttonSize, currentSelection: $viewState.currentServer)
                                if let unread = viewState.getUnreadCountFor(server: elem.value) {
                                    UnreadCounter(unread: unread, mentionSize: buttonSize / 2.5, unreadSize: buttonSize / 3)
                                        .background(viewState.theme.background)
                                        .containerShape(Circle())
                                }
                            }
                        }
                        .padding(.vertical, 2)
                    }
                }
                
                Divider()
                    .frame(height: 12)
                
                Section {
                    NavigationLink(value: NavigationDestination.add_server) {
                        Image(systemName: "plus.circle.fill")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(viewState.theme.accent.color, viewState.theme.background2.color)
                            .frame(width: buttonSize, height: buttonSize)
                            .font(.system(size: buttonSize))
                    }
                    
                    NavigationLink(value: NavigationDestination.discover) {
                        Image(systemName: "safari.fill")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(viewState.theme.accent.color, viewState.theme.background2.color)
                            .frame(width: buttonSize, height: buttonSize)
                            .font(.system(size: buttonSize))
                    }
                    
                    NavigationLink(value: NavigationDestination.settings) {
                        Image(systemName: "gearshape.circle.fill")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(viewState.theme.accent.color, viewState.theme.background2.color)
                            .frame(width: buttonSize, height: buttonSize)
                            .font(.system(size: buttonSize))
                    }
                }
                
                
            }
            .scrollContentBackground(.hidden)
            .scrollIndicators(.hidden)
            
            VStack {
                Button(action: {
                    viewState.currentServer = .dms
                }) {
                    Avatar(user: viewState.currentUser!, width: buttonSize, height: buttonSize, withPresence: true)
                        .frame(width: buttonSize, height: buttonSize)
                }
                
                Divider()
            }
            .background(viewState.theme.background)
        }
        .padding(.horizontal, viewWidth - buttonSize)
        .background(viewState.theme.background.color)
    }
}

#Preview(traits: .fixedLayout(width: 60, height: 500)) {
    ServerScrollView()
        .applyPreviewModifiers(withState: ViewState.preview().applySystemScheme(theme: .light))
}
