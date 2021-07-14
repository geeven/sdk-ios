//
//  ConfirmationV3.swift
//  Afterpay
//
//  Created by Chris Kolbu on 14/7/21.
//  Copyright © 2021 Afterpay. All rights reserved.
//

import Foundation

/// Data returned from a successful V3 checkout
public protocol CheckoutV3Data {
  /// A closure that will cancel the virtual card generated by Afterpay.
  var cancellation: CancellationClosure { get }
  /// A closure that will update the merchant reference on the checkout.
  var merchantReferenceUpdate: MerchantReferenceUpdateClosure { get }
  /// The time before which an authorization needs to be made on the virtual card.
  var cardValidUntil: Date? { get }
  /// The virtual card details
  var cardDetails: CardDetails { get }
}

@frozen public enum CheckoutV3Result {
  case success(data: CheckoutV3Data)
  case cancelled(reason: CheckoutResult.CancellationReason)
}
