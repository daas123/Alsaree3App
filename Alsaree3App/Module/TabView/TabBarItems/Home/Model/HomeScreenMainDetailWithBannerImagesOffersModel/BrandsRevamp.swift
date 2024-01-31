 

import Foundation
struct BrandsRevamp: Codable {
	let _id : String?
	let name : String?
	let unique_id : Int?
	let city_id : String?
	let sequence_number : Int?
	let is_visible : Bool?
	let image_url : String?

	enum CodingKeys: String, CodingKey {

		case _id = "_id"
		case name = "name"
		case unique_id = "unique_id"
		case city_id = "city_id"
		case sequence_number = "sequence_number"
		case is_visible = "is_visible"
		case image_url = "image_url"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		_id = try values.decodeIfPresent(String.self, forKey: ._id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		unique_id = try values.decodeIfPresent(Int.self, forKey: .unique_id)
		city_id = try values.decodeIfPresent(String.self, forKey: .city_id)
		sequence_number = try values.decodeIfPresent(Int.self, forKey: .sequence_number)
		is_visible = try values.decodeIfPresent(Bool.self, forKey: .is_visible)
		image_url = try values.decodeIfPresent(String.self, forKey: .image_url)
	}

}
