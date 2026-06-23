import Foundation
import os

struct PlistResourceLoader {
    private let logger = Logger(subsystem: Constants.subsystem, category: Constants.category)

    func load<Item: Decodable>(_ resourceName: String, in bundle: Bundle = .main) -> [Item] {
        guard let url = bundle.url(forResource: resourceName, withExtension: Constants.fileExtension) else {
            logger.error("Resource not found: \(resourceName, privacy: .public)")
            return []
        }
        guard let data = try? Data(contentsOf: url) else {
            logger.error("Failed to read resource: \(resourceName, privacy: .public)")
            return []
        }
        guard let wrappedItems = try? PropertyListDecoder().decode([FailableDecodable<Item>].self, from: data) else {
            logger.error("Failed to decode resource: \(resourceName, privacy: .public)")
            return []
        }
        return wrappedItems.compactMap { $0.value }
    }
}

// Constants
private extension PlistResourceLoader {
    enum Constants {
        static let fileExtension = "plist"
        static let subsystem = "com.menttest.transactions"
        static let category = "PlistResourceLoader"
    }
}
