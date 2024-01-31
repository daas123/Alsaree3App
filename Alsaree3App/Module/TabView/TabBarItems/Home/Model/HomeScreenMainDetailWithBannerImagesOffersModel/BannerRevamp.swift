

import Foundation
struct BannerRevamp : Codable {
	let _id : String?
	let sequence_number : Int?
	let city_id : String?
	let image_url : String?
	let banner_title : String?
	let banner_text : String?
	let banner_color : String?
	let is_push_notification : Bool?
	let is_golden_customer_banner : Bool?
	let is_store_list : Bool?
	let banner_type : Int?
	let promo_code : String?
	let days : [String]?
	let start_time : String?
	let end_time : String?
	let is_default : Bool?
	let is_banner_visible : Bool?
	let is_current_open_order : Bool?
	let store_id : String?
	let store_list_id : String?
	let push_zones : [String]?
	let partner_id : String?
	let is_qcomm : Bool?
	let is_alsaree3_essential : Bool?
	let created_at : String?
	let updated_at : String?
	let unique_id : Int?
	let __v : Int?
	let is_in_zone : Bool?
	let close : Bool?

	enum CodingKeys: String, CodingKey {

		case _id = "_id"
		case sequence_number = "sequence_number"
		case city_id = "city_id"
		case image_url = "image_url"
		case banner_title = "banner_title"
		case banner_text = "banner_text"
		case banner_color = "banner_color"
		case is_push_notification = "is_push_notification"
		case is_golden_customer_banner = "is_golden_customer_banner"
		case is_store_list = "is_store_list"
		case banner_type = "banner_type"
		case promo_code = "promo_code"
		case days = "days"
		case start_time = "start_time"
		case end_time = "end_time"
		case is_default = "is_default"
		case is_banner_visible = "is_banner_visible"
		case is_current_open_order = "is_current_open_order"
		case store_id = "store_id"
		case store_list_id = "store_list_id"
		case push_zones = "push_zones"
		case partner_id = "partner_id"
		case is_qcomm = "is_qcomm"
		case is_alsaree3_essential = "is_alsaree3_essential"
		case created_at = "created_at"
		case updated_at = "updated_at"
		case unique_id = "unique_id"
		case __v = "__v"
		case is_in_zone = "is_in_zone"
		case close = "close"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		_id = try values.decodeIfPresent(String.self, forKey: ._id)
		sequence_number = try values.decodeIfPresent(Int.self, forKey: .sequence_number)
		city_id = try values.decodeIfPresent(String.self, forKey: .city_id)
		image_url = try values.decodeIfPresent(String.self, forKey: .image_url)
		banner_title = try values.decodeIfPresent(String.self, forKey: .banner_title)
		banner_text = try values.decodeIfPresent(String.self, forKey: .banner_text)
		banner_color = try values.decodeIfPresent(String.self, forKey: .banner_color)
		is_push_notification = try values.decodeIfPresent(Bool.self, forKey: .is_push_notification)
		is_golden_customer_banner = try values.decodeIfPresent(Bool.self, forKey: .is_golden_customer_banner)
		is_store_list = try values.decodeIfPresent(Bool.self, forKey: .is_store_list)
		banner_type = try values.decodeIfPresent(Int.self, forKey: .banner_type)
		promo_code = try values.decodeIfPresent(String.self, forKey: .promo_code)
		days = try values.decodeIfPresent([String].self, forKey: .days)
		start_time = try values.decodeIfPresent(String.self, forKey: .start_time)
		end_time = try values.decodeIfPresent(String.self, forKey: .end_time)
		is_default = try values.decodeIfPresent(Bool.self, forKey: .is_default)
		is_banner_visible = try values.decodeIfPresent(Bool.self, forKey: .is_banner_visible)
		is_current_open_order = try values.decodeIfPresent(Bool.self, forKey: .is_current_open_order)
		store_id = try values.decodeIfPresent(String.self, forKey: .store_id)
		store_list_id = try values.decodeIfPresent(String.self, forKey: .store_list_id)
		push_zones = try values.decodeIfPresent([String].self, forKey: .push_zones)
		partner_id = try values.decodeIfPresent(String.self, forKey: .partner_id)
		is_qcomm = try values.decodeIfPresent(Bool.self, forKey: .is_qcomm)
		is_alsaree3_essential = try values.decodeIfPresent(Bool.self, forKey: .is_alsaree3_essential)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
		unique_id = try values.decodeIfPresent(Int.self, forKey: .unique_id)
		__v = try values.decodeIfPresent(Int.self, forKey: .__v)
		is_in_zone = try values.decodeIfPresent(Bool.self, forKey: .is_in_zone)
		close = try values.decodeIfPresent(Bool.self, forKey: .close)
	}

}
