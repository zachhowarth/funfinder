//
//  AddPhotoViewController.swift
//  funfinder
//
//  Created by Zachary Howarth on 5/18/19.
//  Copyright © 2019 Zachary Howarth. All rights reserved.
//

import UIKit

class AddPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var photoToSave: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self

        // Do any additional setup after loading the view.
    }
    @IBAction func photoLibraryTapped(_ sender: UIButton) {
        
        imagePicker.sourceType = .savedPhotosAlbum
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func cameraTapped(_ sender: UIButton) {
        
        imagePicker.sourceType = .camera
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func albumButtonTapped(_ sender: UIButton) {
        
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBOutlet weak var captionText: UITextField!
    
    @IBAction func savePhotoTapped(_ sender: UIButton) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let newCDPhoto = Photos(entity: Photos.entity(), insertInto: context)
            newCDPhoto.caption = captionText.text
            
            if let userImage = photoToSave.image {
                if let userImageData = userImage.pngData() {
                    newCDPhoto.addPhoto = userImageData
                }
            }
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            navigationController?.popViewController(animated: true)
        }
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //update photo
        
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoToSave.image = selectedImage
            
        }
        imagePicker.dismiss(animated: true, completion: nil )

    }
    
    



}

