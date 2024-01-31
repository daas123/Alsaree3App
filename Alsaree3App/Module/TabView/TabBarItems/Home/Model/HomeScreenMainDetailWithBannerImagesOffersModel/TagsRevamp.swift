

import Foundation
struct TagsRevamp : Codable {
	let _id : String?
	let name : String?
	let image_url : String?

	enum CodingKeys: String, CodingKey {

		case _id = "_id"
		case name = "name"
		case image_url = "image_url"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		_id = try values.decodeIfPresent(String.self, forKey: ._id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		image_url = try values.decodeIfPresent(String.self, forKey: .image_url)
	}

}
