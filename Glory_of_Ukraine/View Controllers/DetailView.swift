//
//  DetailView.swift
//  Glory_of_Ukraine
//
//  Created by Serhii Palamarchuk on 21.07.2022.
//

import UIKit

class DetailView: UIViewController {
    
    var detailText = ""
    var detailIndex = 0
    
    var gradientLayer : CAGradientLayer! {
        didSet {
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0.8, y: 0.8)
            gradientLayer.colors = [UIColor.systemRed.cgColor, UIColor.black.cgColor]
        }
    }
    
    @IBOutlet weak var textField: UITextView!
 
    override func viewDidLayoutSubviews() {
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text = detailText
        
        gradientLayer = CAGradientLayer()
        view.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    @IBAction func buttonPrevios(_ sender: UIButton) {
        if detailIndex > 0 {
            detailIndex -= 1
            textField.text = FirstViewController.arrayDetailText[detailIndex]
        }
    }
    @IBAction func buttonNext(_ sender: UIButton) {
        if detailIndex < (FirstViewController.arrayDetailText.count - 1) {
            detailIndex += 1
            textField.text = FirstViewController.arrayDetailText[detailIndex]
        }
    }
    @IBAction func shareAction(_ sender: UIButton) {
        
        let shareController = UIActivityViewController(activityItems: [textField.text!], applicationActivities: nil)
//        shareController.completionWithItemsHandler = {
//            
//        }
        present(shareController, animated: true, completion: nil)
        
    }
}
