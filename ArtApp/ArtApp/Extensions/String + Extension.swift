//
//  String + Extension.swift
//  ArtApp
//
//  Created by Алексей on 31.05.2024.
//

import Foundation

extension String {
    var isReallyEmpty: Bool {
        return self.trimmingCharacters(in: .whitespaces).isEmpty
    }
}
