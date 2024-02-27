//
//  CustomTabView.swift
//  MyLittleCody
//
//  Created by Николай Никитин on 27.02.2024.
//

import SwiftUI

struct CustomTabView: View {

  @Binding var tab: String
  @Binding var showMenu: Bool

  var body: some View {
    VStack {
      HStack {
        Button {
          withAnimation(.spring) {
            showMenu =  true
          }
        } label: {
          Image(systemName: "line.3.horizontal.decrease")
            .font(.title.bold())
            .foregroundColor(.white)
        }
        .opacity(showMenu ? 0 : 1)
        Spacer()
      }
      .overlay(
        Text(tab.capitalized)
          .font(.title2.bold())
          .foregroundStyle(.white)
          .opacity(showMenu ? 0 : 1)
      )
      .padding([.horizontal, .top])
      .padding(.bottom, 8)
      .padding(.top, getSafeArea().top)
      TabView(selection: $tab) {
        TasksListView()
      }
    }
    .disabled(showMenu)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .overlay(
      Button {
        withAnimation(.spring) {
          showMenu =  false
        }
      } label: {
        Image(systemName: "xmark")
          .font(.title.bold())
          .foregroundColor(.white)
      }
        .opacity(showMenu ? 1 : 0)
        .padding()
        .padding(.top)

      ,alignment: .topLeading
    )
    .background(
      Color.black
    )
  }
}

#Preview {
  ContentView()
}
