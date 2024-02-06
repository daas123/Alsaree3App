//
//  SDWebImageManagerRevamp.swift
//  Alsaree3App
//
//  Created by Neosoft on 09/01/24.
//

import Foundation
import SDWebImage

class SDWebImageManagerRevamp {
    static let shared = SDWebImageManagerRevamp()
    var imageBaseUrl = ""

    private init() {}

    func loadImage(with urlString: String, into imageView: UIImageView, placeholder: UIImage? = UIImage(named: ImageConstant.placeholder.rawValue),isbaseUrlRequired : Bool = true) {
        var url : URL?
        if isbaseUrlRequired{
            url = URL(string: (imageBaseUrl+urlString))
        }else{
            url = URL(string: (urlString))
        }
        imageView.image = placeholder
        imageView.sd_setImage(with: url, placeholderImage: placeholder)
    }

    func cancelImageLoad(for imageView: UIImageView) {
        imageView.sd_cancelCurrentImageLoad()
    }
}


