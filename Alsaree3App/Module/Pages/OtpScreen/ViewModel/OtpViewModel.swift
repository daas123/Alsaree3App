//
//  OtpViewModel.swift
//  Alsaree3App
//
//  Created by Neosoft1 on 04/03/24.
//

import Foundation
class OtpViewModel{
    func getpresentingHeight(screenHeigth:CGFloat) -> Double{
        if screenHeigth > 900 {
            return 0.55
        } else if screenHeigth > 700 {
            return 0.61
        } else {
            return 0.73
        }
    }
}
