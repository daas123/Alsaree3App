
import Foundation
struct Store_time : Codable {
	let is_store_open : Bool?
	let is_store_open_full_time : Bool?
	let day : Int?
	let day_time : [Day_timeRevamp]?

	enum CodingKeys: String, CodingKey {

		case is_store_open = "is_store_open"
		case is_store_open_full_time = "is_store_open_full_time"
		case day = "day"
		case day_time = "day_time"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		is_store_open = try values.decodeIfPresent(Bool.self, forKey: .is_store_open)
		is_store_open_full_time = try values.decodeIfPresent(Bool.self, forKey: .is_store_open_full_time)
		day = try values.decodeIfPresent(Int.self, forKey: .day)
		day_time = try values.decodeIfPresent([Day_timeRevamp].self, forKey: .day_time)
	}

}
