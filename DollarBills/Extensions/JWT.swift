//
//  JWT.swift
//  DollarBills
//
//  Created by Febrian Daniel on 14/11/23.
//

import Foundation
import SwiftJWT

struct JWT {
    let kid = "W28537LG9C"
    let iss = "6f1a0e6a-a260-4d68-a6fb-6fb382b2f946"
    let iat = NSDate().timeIntervalSince1970
    let exp = ((NSDate() as Date) + 20 * 60).timeIntervalSince1970
    let aud = "appstoreconnect-v1"
    
    let authToken = """
-----BEGIN PRIVATE KEY-----
MIGTAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBHkwdwIBAQQgg2ot+zK3pz1NIZNp
0XtaXzb+eCR2FEL9f5q07x6M1kKgCgYIKoZIzj0DAQehRANCAAQICVMjYeF6Y3m/
TGbCriCcVJsqh7JSl3vgD2tdLUZSNZ56v18FFt01xerYfRhvj5+8xPQD0Hcc32KT
g3J0fkgK
-----END PRIVATE KEY-----
"""
    
    func generateToken() {
        let myHeader = Header(kid: kid)
        let claims = GCPayload(iss: iss, iat: iat, exp: iat, aud: aud)
        var jwt = SwiftJWT.JWT(header: myHeader, claims: claims)
        
        guard let tokenData = authToken.data(using: .utf8) else {
            return
        }
        
        do {
            let token = try jwt.sign(using: .es256(privateKey: tokenData))
        } catch {
            print(error)
            print(tokenData)
        }
    }
}

struct GCHeader {
    let alg = "ES256"
    let kid = "W28537LG9C"
    let typ = "JWT"
}

struct GCPayload: Claims {
    let iss: String
    let iat: Double?
    let exp: Double?
    let aud: String
}
