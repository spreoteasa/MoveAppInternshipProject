//
//  LicenseViewModel.swift
//  Move
//
//  Created by Silviu Preoteasa on 01.09.2022.
//

import Foundation


class LicenseViewModel: ObservableObject {
    @Published var showingSheet = false
    @Published var imageViewModel = ImagePickerViewModel()
    
    func sendImageForUpload(onUploadDone: @escaping () -> Void) {
        DriverLicenseAPI().uploadForValidation(image: imageViewModel.image) { result in
            switch result {
            case .success:
                onUploadDone()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func logOut(onLogOut: () -> Void) {
        let encodedUser = UserDefaults.standard.value(forKey: UserDefaultsEnum.loggedUser.rawValue)
        let decodedUser = try! JSONDecoder().decode(LoggedUser.self, from: encodedUser as! Data)
        AuthenticationAPI().logOut(loggedUser: decodedUser) { result in
            print(result)
        }
        UserDefaults.standard.removeObject(forKey: UserDefaultsEnum.loggedUser.rawValue)
        onLogOut()
        
    }
}