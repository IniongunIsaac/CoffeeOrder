//
//  OrderCellView.swift
//  CoffeeOrder
//
//  Created by Isaac Iniongun on 20/04/2023.
//

import SwiftUI

struct OrderCellView: View {
    
    let order: Order
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(order.name).accessibilityIdentifier("orderNameText")
                    .bold()
                Text("\(order.coffeeName) (\(order.size.rawValue))")
                    .accessibilityIdentifier("coffeeNameAndSizeText")
                    .opacity(0.5)
                
            }
            Spacer()
            Text(order.total as NSNumber, formatter: NumberFormatter.currency)
                .accessibilityIdentifier("coffeePriceText")
        }
    }
}


struct OrderCellView_Previews: PreviewProvider {
    static var previews: some View {
        OrderCellView(order: Order(name: "Texas", coffeeName: "Black Coffee", total: 10, size: .large))
            .previewLayout(.sizeThatFits)
    }
}
