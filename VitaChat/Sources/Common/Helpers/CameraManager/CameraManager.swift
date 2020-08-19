//
//  CameraManager.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 18.08.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//
import UIKit

final class CameraManager: NSObject {


    // MARK: - Protocol properties
    static let shared: CameraManagerProtocol = CameraManager()

    // MARK: - Properties
    private var imagePickedBlock: ((UIImage?) -> Void)?

}

extension CameraManager: CameraManagerProtocol {

    func showActionSheet(vc: UIViewController, completion: ((UIImage?) -> Void)?) {
        imagePickedBlock = completion
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        let actionSheet = UIAlertController(title: "Выбрать фото из:", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Камеры", style: .default) { _ in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                picker.sourceType = .camera
                vc.present(picker, animated: true)
            }
        })
        actionSheet.addAction(UIAlertAction(title: "Галереи", style: .default) { _ in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                picker.sourceType = .photoLibrary
                vc.present(picker, animated: true)
            }
        })
        actionSheet.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        vc.present(actionSheet, animated: true)
    }

}

// MARK: - UIImagePickerControllerDelegate
extension CameraManager: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        picker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagePickedBlock?(image)
        }
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            imagePickedBlock?(image)
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
