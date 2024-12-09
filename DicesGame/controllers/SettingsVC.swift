//
//  Settings.swift
//  DicesGame
//
//  Created by Rıdvan Karslı on 25.06.2024.
//

import UIKit

class SettingsVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet weak var gamerImage: UIImageView!
    @IBOutlet weak var gamerName: UITextField!
    
    var selectedGamer : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gamerImage.isUserInteractionEnabled = true
        let imageTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageClicked))
        gamerImage.addGestureRecognizer(imageTapGestureRecognizer)
    }
    @objc func imageClicked(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickerImage = info[.originalImage] as? UIImage{
            gamerImage.image = pickerImage
        }
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    @IBAction func segmentedChanged(_ sender: UISegmentedControl) {
        selectedGamer = sender.selectedSegmentIndex
    }
    
    
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        
        if selectedGamer == 0{
            //first gamer
            if let firstGamerImageData = gamerImage.image?.jpegData(compressionQuality: 1.0){
                UserDefaults.standard.set(firstGamerImageData, forKey: "firstGamerImage")
            }
            UserDefaults.standard.set(gamerName.text, forKey: "firstGamerName")
        }else{
            //second gamer
            if let secondGamerImageData = gamerImage.image?.jpegData(compressionQuality: 1.0){
                UserDefaults.standard.set(secondGamerImageData, forKey: "secondGamerImage")
            }
            UserDefaults.standard.set(gamerName.text, forKey: "secondGamerName")
        }
        gamerName.text = ""
    }
    
}
