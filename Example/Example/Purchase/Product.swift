//
//  Product.swift
//  Example
//
//  Created by Adam Campbell on 1/7/20.
//  Copyright © 2020 Afterpay. All rights reserved.
//

import Foundation

struct Product {
  let id = UUID()
  let name: String
  let description: String
  let price: Decimal
}

extension Collection where Element == Product {
  static var stub: [Product] {
    [
      Product(name: "Coffee", description: "Ground 250g", price: 12.99),
      Product(name: "Milk", description: "Full Cream 2L", price: 3.49),
      Product(name: "Drinking Chocolate", description: "Malted 460g", price: 7.00),
    ]
  }
}

struct ProductDisplay {
  let id: UUID
  let title: String
  let subtitle: String
  let displayPrice: String
  let quantity: String

  init(product: Product, quantity: UInt) {
    id = product.id
    title = product.name
    subtitle = product.description
    displayPrice = "\(product.price)"
    self.quantity = "\(quantity)"
  }
}
