//
//  AccountViewController+.swift
//  Tweety
//
//  Created by Emir Küçükosman on 10.03.2021.
//

import UIKit

extension AccountViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func pickImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       
        guard let pickedImage = info[.editedImage] as? UIImage else {
            let alert = self.getAlert(title: "Error", message: "Please pick a valid image")
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        guard let pickedImageData = pickedImage.jpegData(compressionQuality: 0.8) else {
            let alert = self.getAlert(title: "Error", message: "Please pick a valid image")
            self.present(alert, animated: true, completion: nil)
            return
        }
                        
        picker.dismiss(animated: true, completion: nil)
        accountViewModel.setProfilePhoto(from: pickedImageData)
    }
    
}
