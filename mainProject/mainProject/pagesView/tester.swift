//
//  tester.swift
//  mainProject
//
//  Created by Can Özgür on 20.05.2024.
//

import SwiftUI

struct tester: View {
    let items = ["Apple", "Banana", "Orange", "Grapes", "Watermelon"]
    
    var body: some View {
        List(items, id: \.self) { item in
            Text(item)
        }
    }
}


#Preview {
    tester()
}
