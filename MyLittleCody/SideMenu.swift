//
//  SideMenu.swift
//  MyLittleCody
//
//  Created by Николай Никитин on 26.02.2024.
//

import SwiftUI

struct SideMenu: View {

  @Binding var tab: String
  @Namespace var animation

    var body: some View {
      VStack {
        ScrollView(getRect().height < 750 ? .horizontal : .init(), showsIndicators: false) {
          VStack(alignment: .leading, spacing: 25) {
            CustomMenuButton(icon: "l.circle",
                         title: "Leetcode")
            CustomMenuButton(icon: "y.circle",
                         title: "YContest")
            CustomMenuButton(icon: "c.circle",
                         title: "Coderun")
            
          }
          .padding()
          .padding(.top, 45)

          .frame(width: getRect().width / 2, alignment: .leading)
        .frame(maxWidth: .infinity, alignment: .leading)
        }
       }
      .padding(.leading, 10)
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
      .background(
        Color(red: 0.196, green: 0.392, blue: 0.659)
      )
    }

  @ViewBuilder
  func CustomMenuButton(icon: String, title: String) -> some View {
    Button {
      withAnimation {
        tab = title
      }
    } label: {
      HStack(spacing: 12) {
        Image(systemName: icon)
          .font(.title3)
          .frame(width: tab  == title ? 48 : nil, height: 48)
          .foregroundStyle(tab == title ? .green : .white)
          .background(
            ZStack {
              if tab == title {
                Color.white
                  .clipShape(Circle())
                  .matchedGeometryEffect(id: "TABCIRCLE", in: animation)
              }
            }
          )
        Text(title)
          .font(.callout)
          .fontWeight(.semibold)
          .foregroundStyle(.white)
      }
      .padding(.trailing, 18)
      .background(
        ZStack {
          if tab == title {
            Color.green
              .clipShape(Capsule())
              .matchedGeometryEffect(id: "TABCAPSULE", in: animation)
          }
        }
      )
    }
    .offset(x: tab == title ? 15 : 0)
  }
}

#Preview {
    ContentView()
}

extension View {
  func getRect() -> CGRect {
    return UIScreen.main.bounds
  }
}
