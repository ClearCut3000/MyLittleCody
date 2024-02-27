//
//  MainView.swift
//  MyLittleCody
//
//  Created by Николай Никитин on 26.02.2024.
//

import SwiftUI

struct MainView: View {

  @State var currentTab: String = "Leetcode"
  @State var showMenu: Bool = false

  init() {
    UITabBar.appearance().isHidden = true
  }

  var body: some View {
    ZStack {
      SideMenu(tab: $currentTab)
      CustomTabView(tab: $currentTab, showMenu: $showMenu)
        .cornerRadius(showMenu ? 25 : 0)
        .rotation3DEffect(.init(degrees: showMenu ? -15 : 0),
                          axis: (x: 0.0, y: 1.0, z: 0.0),
                          anchor: .trailing)
        .offset(x: showMenu ? getRect().width / 2 : 0)
        .ignoresSafeArea()
    }
    .preferredColorScheme(.dark)
  }
}

extension View {
  func getSafeArea() -> UIEdgeInsets {
    guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
      return .zero
    }
    guard let safeArea = screen.windows.first?.safeAreaInsets else {
      return .zero
    }
    return safeArea
  }
}

#Preview {
  MainView()
}
