import MultipartKit
import Foundation

let boundary = "MY-BOUNDARY"
let fileUrl = URL(fileURLWithPath: ProcessInfo.processInfo.environment["FILE_PATH"]!)
let fileData = try! Data(contentsOf: fileUrl)
var multipart = MultipartPart(body: fileData)
multipart.headers.replaceOrAdd(
    name: "Content-Disposition",
    value: "form-data; name=\"file\"; filename=\"picture.png\""
)
multipart.headers.replaceOrAdd(
    name: "Content-Type",
    value: "image/png"
)

let body = try MultipartSerializer().serialize(
    parts: [multipart],
    boundary: boundary
)

print(Data(body.utf8).count)

let multipartData = try MultipartHelper().multipart(
    from: fileUrl.path,
    partName: "file",
    boundary: boundary
)

print(multipartData.count)
