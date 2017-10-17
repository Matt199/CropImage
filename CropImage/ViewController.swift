//
//  ViewController.swift
//  CropImage
//
//  Created by Mateusz Kopacz on 16.10.2017.
//  Copyright © 2017 Mateusz Kopacz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var imageViewWidth: NSLayoutConstraint!
    
    @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
    
    

    

    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func setImageToCrop(image: UIImage){

        // Sets the image
        imageView.image = image

        
        // Sets constant image dimensions
        imageViewWidth.constant = image.size.width
        imageViewHeight.constant = image.size.height

        
     
        let scaleHeight = scrollView.frame.width / image.size.width

        let scaleWidth = scrollView.frame.height / image.size.height

        let maxScale = max(scaleWidth, scaleHeight)

        scrollView.minimumZoomScale = maxScale
        scrollView.zoomScale = maxScale
       
      

    }
 
    @IBAction func cropButton(_ sender: UIButton) {
        
        let scale = 1 / scrollView.zoomScale
    
        let x:CGFloat = scrollView.contentOffset.x * scale
        
        let y:CGFloat = scrollView.contentOffset.y * scale
        
        let width:CGFloat = scrollView.frame.size.width * scale
        let height:CGFloat = scrollView.frame.size.height * scale
        
        let croppedCGImage = imageView.image?.cgImage?.cropping(to: CGRect(x: x, y: y, width: width, height: height))
        
        let croppedImage = UIImage(cgImage: croppedCGImage!)
        
        print("Height = \(imageView.frame.size.height)")
        print("Width = \(imageView.frame.size.width)")
        print("x = \(x)")
        print("y = \(y)")
        
        setImageToCrop(image: croppedImage)
    
        
        imageView.image = croppedImage
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        scrollView.delegate = self

        setImageToCrop(image: UIImage(named: "dog")!)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

