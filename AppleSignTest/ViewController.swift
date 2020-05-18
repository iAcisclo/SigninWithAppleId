//
//  ViewController.swift
//  AppleSignTest
//
//  Created by Ignacio Acisclo on 18/05/2020.
//  Copyright © 2020 iAcisclo. All rights reserved.
//

import UIKit
import AuthenticationServices

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let button = ASAuthorizationAppleIDButton()
        button.center = view.center
        button.addTarget(self, action: #selector(requestAuthentication), for: .touchUpInside)
        view.addSubview(button)
    }

    @objc func requestAuthentication() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
}


extension ViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        view.window!
    }
}

extension ViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        print(authorization.credential)
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
    
            print(credential.user)
            if let email = credential.email {
                print(email)
            }
            if let fullname = credential.fullName {
                print(fullname)
            }
            if let identityToken = credential.identityToken {
                print(identityToken)
            }
            if let code = credential.authorizationCode {
                print(code)
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Apple ID Authorization failed: \(error.localizedDescription)")
    }
}


