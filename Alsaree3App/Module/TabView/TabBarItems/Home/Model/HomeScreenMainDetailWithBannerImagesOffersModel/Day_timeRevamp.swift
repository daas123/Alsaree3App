

import Foundation
struct Day_timeRevamp : Codable {
	let store_open_time : String?
	let store_close_time : String?

	enum CodingKeys: String, CodingKey {

		case store_open_time = "store_open_time"
		case store_close_time = "store_close_time"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		store_open_time = try values.decodeIfPresent(String.self, forKey: .store_open_time)
		store_close_time = try values.decodeIfPresent(String.self, forKey: .store_close_time)
	}

}
