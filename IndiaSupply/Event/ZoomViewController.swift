//
//  ZoomViewController.swift
//  Exlcart
//
//  Created by Tech Basics on 10/02/16.
//  Copyright (c) 2016 iPhone. All rights reserved.
//

import UIKit
import Alamofire


class ZoomViewController: UIViewController {
    
    @IBOutlet  var imageView: FLImageView!
    @IBOutlet  var scrollView: UIScrollView!
    
    var FloorID:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageURL = FloorID 
        let trimmedUrl = imageURL.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!.trimmingCharacters(in: CharacterSet(charactersIn: "")).replacingOccurrences(of: " ", with: "%20") as String
        imageView.loadImage(at: URL(string: trimmedUrl), placeholderImage: UIImage(named: "place"))
        
        
    }
    @IBAction func BackBtnAction(_ sender: AnyObject)
    {
        dismiss(animated: false, completion: nil)
    }
    
    fileprivate func updateMinZoomScaleForSize(_ size: CGSize) {
        let widthScale = size.width / imageView.bounds.width
        let heightScale = size.height / imageView.bounds.height
        let minScale = min(widthScale, heightScale)
        
        scrollView.minimumZoomScale = minScale
        scrollView.zoomScale = minScale
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateMinZoomScaleForSize(view.bounds.size)
    }


}



extension ZoomViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
