//
//  ItemView.swift
//  Objects
//
//  Created by Vicente Ortega Aguado on 8/5/24.
//

import SwiftUI

struct ItemView: View {
    
    let item: Item
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top, spacing: 8) {
                Text(item.name)
                Spacer()
                Text(item.type)
            }
            Text(item.detail)
        }
    }
}

//#Preview {
//    ItemView(item: .init())
//}
