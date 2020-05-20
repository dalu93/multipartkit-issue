//
//  MultipartHelper.swift
//  
//
//  Created by D'Alberti, Luca on 5/12/20.
//

import Foundation

struct MultipartHelper {
    enum Error: Swift.Error {
        case fileDoesNotExist
        case unsupportedFileType(String)
    }

    func multipart(from filePath: String, partName: String, boundary: String) throws -> Data {
        guard FileManager.default.fileExists(atPath: filePath) else {
            throw Error.fileDoesNotExist
        }

        let fileUrl = URL(fileURLWithPath: filePath)
        let fileName = fileUrl.lastPathComponent
        let fileExtension = fileUrl.pathExtension
        guard !fileName.isEmpty, !fileExtension.isEmpty else {
            throw Error.fileDoesNotExist
        }

        guard let contentType = ContentType(fileExt: fileExtension) else {
            throw Error.unsupportedFileType(fileName)
        }

        let fileData: Data
        do {
            fileData = try Data(contentsOf: fileUrl)
        } catch {
            throw Error.fileDoesNotExist
        }

        let headersPart = Data("""
        --\(boundary)\r\n\
        Content-Disposition: form-data; name="\(partName)"; filename="\(fileName)"\r\n\
        Content-Type: \(contentType.header)\r\n\
        \r\n
        """.utf8)
        let footerPart = Data("""
        \r\n--\(boundary)--\r\n
        """.utf8)

        var data = Data()
        data.append(headersPart)
        data.append(fileData)
        data.append(footerPart)

        return data
    }
}

enum ContentType {
    case png, jpeg, gif

    init?(fileExt: String) {
        switch fileExt.lowercased() {
        case "png":
            self = .png

        case "jpeg", "jpg":
            self = .jpeg

        case "gif":
            self = .gif

        default:
            return nil
        }
    }

    var header: String {
        switch self {
        case .gif:
            return "image/gif"

        case .jpeg:
            return "image/jpeg"

        case .png:
            return "image/png"
        }
    }
}
