

import Foundation
struct AdsRevamp : Codable {
	let _id : String?
	let ads_detail : String?
	let is_ads_cc : Bool?
	let expiry_date : String?
	let start_time : String?
	let end_time : String?
	let is_ads_visible : Bool?
	let is_ads_redirect_to_store : Bool?
	let image_url : String?
	let new_design_image_url : String?
	let store_id : String?
	let store_radius : Int?
	let is_store_open : Bool?
	let location : [Double]?
	let store_offers_detail : Stores?
	let is_ads_on : Bool?

	enum CodingKeys: String, CodingKey {

		case _id = "_id"
		case ads_detail = "ads_detail"
		case is_ads_cc = "is_ads_cc"
		case expiry_date = "expiry_date"
		case start_time = "start_time"
		case end_time = "end_time"
		case is_ads_visible = "is_ads_visible"
		case is_ads_redirect_to_store = "is_ads_redirect_to_store"
		case image_url = "image_url"
		case new_design_image_url = "new_design_image_url"
		case store_id = "store_id"
		case store_radius = "store_radius"
		case is_store_open = "is_store_open"
		case location = "location"
		case store_offers_detail = "store_offers_detail"
		case is_ads_on = "is_ads_on"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		_id = try values.decodeIfPresent(String.self, forKey: ._id)
		ads_detail = try values.decodeIfPresent(String.self, forKey: .ads_detail)
		is_ads_cc = try values.decodeIfPresent(Bool.self, forKey: .is_ads_cc)
		expiry_date = try values.decodeIfPresent(String.self, forKey: .expiry_date)
		start_time = try values.decodeIfPresent(String.self, forKey: .start_time)
		end_time = try values.decodeIfPresent(String.self, forKey: .end_time)
		is_ads_visible = try values.decodeIfPresent(Bool.self, forKey: .is_ads_visible)
		is_ads_redirect_to_store = try values.decodeIfPresent(Bool.self, forKey: .is_ads_redirect_to_store)
		image_url = try values.decodeIfPresent(String.self, forKey: .image_url)
		new_design_image_url = try values.decodeIfPresent(String.self, forKey: .new_design_image_url)
		store_id = try values.decodeIfPresent(String.self, forKey: .store_id)
		store_radius = try values.decodeIfPresent(Int.self, forKey: .store_radius)
		is_store_open = try values.decodeIfPresent(Bool.self, forKey: .is_store_open)
		location = try values.decodeIfPresent([Double].self, forKey: .location)
		store_offers_detail = try values.decodeIfPresent(Stores.self, forKey: .store_offers_detail)
		is_ads_on = try values.decodeIfPresent(Bool.self, forKey: .is_ads_on)
	}

}
