//
//  ErrorInterfaceController.swift
//  WaniTokei
//
//  Created by Andriy K. on 1/11/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import WatchKit
import Foundation

class ErrorInterfaceController: WKInterfaceController {
  
  @IBOutlet weak var errorMessageLabel: WKInterfaceLabel?
  
  override func awake(withContext context: Any?) {
    super.awake(withContext: context)
    if let dictionary = context as? [String: String] {
      if let message = dictionary["message"] {
        errorMessageLabel!.setText(message)
      }
    }
  }
  
  @IBAction func closeModalView() {
    dismiss()
  }
}
