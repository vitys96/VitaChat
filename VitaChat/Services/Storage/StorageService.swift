//
//  StorageService.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 05.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import RxSwift

final class StorageService {

    let storageRef = Storage.storage().reference()

    private var avatarsRef: StorageReference {
        return storageRef.child("avatars")
    }

    private var currentUserId: String {
        return Auth.auth().currentUser!.uid
    }

    init() {}
}

extension StorageService: StorageSeviceProtocol {

    func uploadPhoto1(with image: UIImage) -> Observable<URL> {
        guard
            let scaledImage = image.scaledToSafeUploadSize,
            let imageData = scaledImage.jpegData(compressionQuality: 0.4) else {
            return Observable.error(SignUpError.canNotUploadPhoto)
        }
        return Single<URL>.create { single in
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"

            self.avatarsRef.child(self.currentUserId).putData(imageData, metadata: metadata) { (metadata, error) in
                guard let _ = metadata else {
                    if let err = error {
                        return single(.error(err))
                    }
                    return
                }
                self.avatarsRef.child(self.currentUserId).downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        if let err = error {
                            return single(.error(err))
                        }
                        return
                    }
                    single(.success(downloadURL))
                }
            }
            return Disposables.create()
        }.asObservable()
    }

    func upload(photo: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
        guard
            let scaledImage = photo.scaledToSafeUploadSize,
            let imageData = scaledImage.jpegData(compressionQuality: 0.4) else { return }

        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"

        avatarsRef.child(currentUserId).putData(imageData, metadata: metadata) { (metadata, error) in
            guard let _ = metadata else {
                if let err = error {
                    completion(.failure(err))
                }
                return
            }
            self.avatarsRef.child(self.currentUserId).downloadURL { (url, error) in
                guard let downloadURL = url else {
                    if let err = error {
                        completion(.failure(err))
                    }
                    return
                }
                completion(.success(downloadURL))
            }
        }
    }

    
}
