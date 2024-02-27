//
//  CodeBlockView.swift
//  MyLittleCody
//
//  Created by Николай Никитин on 25.02.2024.
//

import SwiftUI

struct CodeBlockView: View, SearchSetData {
  private let codeLines: Array<Substring>
  private let highlightRows: Set<Int>
  private let showLineNumber: Bool

  private let lineNumberColumnWidth: CGFloat

  init(code: String,
       highlightAt: [Highlight]? = nil,
       showLineNumbers: Bool = false) {

    // Collect all highlight row numbers
    var rows: Set<Int> = []
    if let lineNumbers = highlightAt {
      lineNumbers.forEach { group in
        group.values.forEach { row in
          rows.insert(row)
        }
      }
    }
    self.highlightRows = rows

    self.showLineNumber = showLineNumbers

    if !showLineNumbers && rows.count == 0 {
      // Not going to show line numbers and highlighting rows
      // Create a single element array
      self.codeLines = [Substring(code)]
    } else {
      // Split the codes into individual lines
      self.codeLines = code.split(separator: /\n/)
    }

    // This calculate the line number column width
    self.lineNumberColumnWidth = String(self.codeLines.count)
      .size(withAttributes: [.font: UIFont(name: "Menlo", size: 12)!])
      .width
      .rounded(.up)
  }

  /// Apply text color against each matching results
  /// - Parameters:
  ///   - attributedText: Source code as attributed string
  ///   - regex: Compiled regular expression
  ///   - color: Applicable text color
  private func processMatches(attributedText: inout AttributedString,
                              regex: Regex<Substring>,
                              color: Color) {

    // Get raw source code
    let originalText: String = (
      attributedText.characters.compactMap { c in
        String(c)
      } as [String]).joined()

    originalText.matches(of: regex).forEach { match in
      if let swiftRange = Range(match.range, in: attributedText) {
        attributedText[swiftRange][
          AttributeScopes
            .SwiftUIAttributes.ForegroundColorAttribute.self
        ] = color
      }
    }
  }

  /// Syntax highlight the source  code
  /// - Parameter code: Raw source code
  /// - Returns: Syntax highlighted source code
  func syntaxHighlight(_ code: String) -> AttributedString {
    var attrInText: AttributedString = AttributedString(code)

    searchSets.forEach { searchSet in
      searchSet.words?.forEach({ word in
        guard let regex = try? Regex<Substring>(searchSet.regexPattern(word)) else {
          fatalError("Failed to create regular expession")
        }
        processMatches(attributedText: &attrInText,
                       regex: regex,
                       color: searchSet.color)
      })
    }
    return attrInText
  }

  let borderColor = Color.white
  let bgColor = Color.black

  var body: some View {
    VStack(alignment: .leading) {
      HStack(spacing: 5) {
        if (self.showLineNumber) {
          VStack(alignment: .trailing, spacing: 0) {
            ForEach(codeLines.indices, id: \.self) { idx in
              Text("\(idx+1)")
                .font(.custom("Menlo", size: 12))
                .foregroundColor(.gray)
                .padding(EdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 2))
            }
          }
        }
        ScrollView(.horizontal) {
          VStack(alignment: .leading, spacing: 0) {
            ForEach(codeLines.indices, id: \.self) { idx in
              Text(syntaxHighlight(String(codeLines[idx])))
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.custom("Menlo", size: 12))
                .foregroundColor(.gray)
                .background(highlightRows.contains(idx+1) ? .yellow : Color.clear)
            }
          }
        }
      }
      .padding(10)
    }
    .background(bgColor)
    .cornerRadius(5)
    .overlay(
      RoundedRectangle(cornerRadius: 5, style: .continuous)
        .stroke(borderColor, lineWidth: 2)
    )
  }
}
