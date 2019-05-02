//
//  ViewController.swift
//  RGB Calculator
//
//  Created by Nadezda Panchenko on 05/02/2019.
//  Copyright © 2019 Nadezda Panchenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var colorDisplay: UIView!
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    var averageColor: UIColor?
    var bestColors = [UIColor]()
    var colorSubviews = [UIView]()
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slider.transform = CGAffineTransform.init(rotationAngle: CGFloat(Double.pi/2))
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    @IBAction func valueChanged(_ sender: UISlider) {
        print(Int(sender.value))
        
        guard let color = averageColor else {
            print("average color is nil")
            return
        }
        
        switch Int(sender.value) {
        case 1:
            bestColors = color.getComplement()
        case 2:
            bestColors = color.getSplitComplement()
        case 3:
            bestColors = color.getTriadic()
        case 4:
            bestColors = color.getTetradic()
        case 5:
            bestColors = color.getAnalogous(position: 0)
        default:
            bestColors.removeAll()
        }
        bestColors.append(color)
        showBestColors(bestColors)
    }
    
    @IBAction func takePhoto(_ sender: Any) {
        removeSubviews()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
        self.slider.value = 0
    }
    
    func getAverageColor(from image: UIImage) {
        guard let averageColor = image.averageColor else {
            print("no average color returned")
            return
        }
        updateUI(with: averageColor)
    }
    
    func updateUI(with color: UIColor) {
        infoLabel.text = ""
        averageColor = color
        colorDisplay.backgroundColor = averageColor
    }
    
    func showBestColors(_ color: [UIColor]) {
        removeSubviews()
        prepareSubviews()
        for item in colorSubviews {
            colorDisplay.addSubview(item)
        }
    }
    func prepareSubviews() {
        var x = 0
        var y = 0
        let height = Int(colorDisplay.frame.height - CGFloat(40)) / 4
        
        for item in bestColors {
            let subview = UIView(frame: CGRect(x: x, y: y, width: Int(colorDisplay.frame.width), height: height))
            //subview.layer.cornerRadius = subview.frame.size.width/2
            
            subview.backgroundColor = item
            colorSubviews.append(subview)
            
            y += height
//            if CGFloat(y) >= colorDisplay.frame.height-CGFloat(height+10) {
//                x += height+10
//                y = 20
//            }
            
            
        }
    }
    
    func removeSubviews() {
        for item in colorSubviews {
            item.removeFromSuperview()
            colorSubviews.removeAll()
        }
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            print("no image returned")
            return
        }
        imagePicker.dismiss(animated: true, completion: nil)
        getAverageColor(from: image)
    }
}
