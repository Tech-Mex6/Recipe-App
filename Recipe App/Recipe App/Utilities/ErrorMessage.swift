//
//  ErrorMessage.swift
//  Recipe App
//
//  Created by meekam okeke on 1/11/22.
//

import Foundation

enum RAError: String, Error {
    case unableToComplete = "Unable to complete your request. Please check your internet connection and try again."
    case invalidResponse  = "Invalid response from the server. Please try again."
    case invalidData      = "The data received from the server is invalid. Please try again."
}
