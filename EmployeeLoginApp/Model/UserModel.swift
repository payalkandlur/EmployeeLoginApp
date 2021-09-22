//
//  UserModel.swift
//  EmployeeLoginApp
//
//  Created by Payal Kandlur on 22/09/21.
//

import Foundation


// MARK: - Page
enum PageModelKeys: CodingKey {
    case page, per_page, total, total_pages, data
}

struct Page: Codable {
    var page, per_page, total, total_pages: Int?
    var data: [User]?
}

extension Page {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PageModelKeys.self)
        page = try? container.decodeIfPresent(Int.self, forKey: .page)
        per_page = try? container.decodeIfPresent(Int.self, forKey: .per_page)
        total = try? container.decodeIfPresent(Int.self, forKey: .total)
        total_pages = try? container.decodeIfPresent(Int.self, forKey: .total_pages)
        data = try? container.decodeIfPresent([User].self, forKey: .data)
    }
}



// MARK: - User
enum UserModelKeys: CodingKey {
    case id, email, first_name, last_name, avatar
}

struct User: Codable {
    var id: Int?
    var email, first_name, last_name: String?
    var avatar: String?

}

extension User {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserModelKeys.self)
        id = try? container.decodeIfPresent(Int.self, forKey: .id)
        email = try? container.decodeIfPresent(String.self, forKey: .email)
        first_name = try? container.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try? container.decodeIfPresent(String.self, forKey: .last_name)
        avatar = try? container.decodeIfPresent(String.self, forKey: .avatar)
    }
}

