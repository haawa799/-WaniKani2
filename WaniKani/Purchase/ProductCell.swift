/*
* Copyright (c) 2016 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit
import StoreKit

class ProductCell: UITableViewCell {
  static let priceFormatter: NumberFormatter = {
    let formatter = NumberFormatter()

    formatter.formatterBehavior = .behavior10_4
    formatter.numberStyle = .currency

    return formatter
  }()

  var buyButtonHandler: ((_ product: SKProduct) -> Void)?

  var product: SKProduct? {
    didSet {
      guard let product = product else { return }

      textLabel?.text = product.localizedTitle

      if RageProducts.store.isProductPurchased(product.productIdentifier) {
        accessoryType = .checkmark
        accessoryView = nil
        detailTextLabel?.text = ""
      } else if IAPHelper.canMakePayments() {
        ProductCell.priceFormatter.locale = product.priceLocale
        detailTextLabel?.text = ProductCell.priceFormatter.string(from: product.price)

        accessoryType = .none
        accessoryView = self.newBuyButton()
      } else {
        detailTextLabel?.text = "Not available"
      }
    }
  }

  override func prepareForReuse() {
    super.prepareForReuse()

    textLabel?.text = ""
    detailTextLabel?.text = ""
    accessoryView = nil
  }

  func newBuyButton() -> UIButton {
    let button = UIButton(type: .system)
    button.setTitleColor(tintColor, for: UIControlState())
    button.setTitle("Buy", for: UIControlState())
    button.addTarget(self, action: #selector(ProductCell.buyButtonTapped(_:)), for: .touchUpInside)
    button.sizeToFit()

    return button
  }

  func buyButtonTapped(_ sender: AnyObject) {
    buyButtonHandler?(product!)
  }
}
