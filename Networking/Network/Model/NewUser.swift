//
//  NewUser.swift
//  Networking
//
//  Created by Wilson David Molina Lozano on 18/08/22.
//

import Foundation

struct NewUser: Encodable {
    let name: String?
    let email: String?
    let gender: String?
    let status: String?
}
