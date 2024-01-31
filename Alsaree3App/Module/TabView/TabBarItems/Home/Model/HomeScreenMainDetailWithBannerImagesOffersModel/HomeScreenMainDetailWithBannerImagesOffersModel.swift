
import Foundation
struct HomeScreenMainDetailWithBannerImagesOffersModel: Codable {
	let success : Bool?
	let message : Int?
	let server_time : String?
	let campaign_detail : Campaign_detail?
	let is_show_ad_text : Bool?
	let is_show_curfew_image : Bool?
	let ads_title : String?
	let tags_title : String?
	let store_listing_title : String?
	let home_screen_store_type : Int?
	let horizontal_store_title : String?
	let horizontal_store_title_2 : String?
	let popular_searches : [String]?
	let banner : [BannerRevamp]?
	let show_brand_scroll_after : Int?
	let brands : [BrandsRevamp]?
	let tags : [TagsRevamp]?
	let ads : [AdsRevamp]?
	let store_offers : [Stores]?
	let zone_id : String?
	let horizontal_stores : [Stores]?
	let horizontal_stores_2 : [Stores]?

	enum CodingKeys: String, CodingKey {

		case success = "success"
		case message = "message"
		case server_time = "server_time"
		case campaign_detail = "campaign_detail"
		case is_show_ad_text = "is_show_ad_text"
		case is_show_curfew_image = "is_show_curfew_image"
		case ads_title = "ads_title"
		case tags_title = "tags_title"
		case store_listing_title = "store_listing_title"
		case home_screen_store_type = "home_screen_store_type"
		case horizontal_store_title = "horizontal_store_title"
		case horizontal_store_title_2 = "horizontal_store_title_2"
		case popular_searches = "popular_searches"
		case banner = "banner"
		case show_brand_scroll_after = "show_brand_scroll_after"
		case brands = "brands"
		case tags = "tags"
		case ads = "ads"
		case store_offers = "store_offers"
		case zone_id = "zone_id"
		case horizontal_stores = "horizontal_stores"
		case horizontal_stores_2 = "horizontal_stores_2"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		success = try values.decodeIfPresent(Bool.self, forKey: .success)
		message = try values.decodeIfPresent(Int.self, forKey: .message)
		server_time = try values.decodeIfPresent(String.self, forKey: .server_time)
		campaign_detail = try values.decodeIfPresent(Campaign_detail.self, forKey: .campaign_detail)
		is_show_ad_text = try values.decodeIfPresent(Bool.self, forKey: .is_show_ad_text)
		is_show_curfew_image = try values.decodeIfPresent(Bool.self, forKey: .is_show_curfew_image)
		ads_title = try values.decodeIfPresent(String.self, forKey: .ads_title)
		tags_title = try values.decodeIfPresent(String.self, forKey: .tags_title)
		store_listing_title = try values.decodeIfPresent(String.self, forKey: .store_listing_title)
		home_screen_store_type = try values.decodeIfPresent(Int.self, forKey: .home_screen_store_type)
		horizontal_store_title = try values.decodeIfPresent(String.self, forKey: .horizontal_store_title)
		horizontal_store_title_2 = try values.decodeIfPresent(String.self, forKey: .horizontal_store_title_2)
		popular_searches = try values.decodeIfPresent([String].self, forKey: .popular_searches)
		banner = try values.decodeIfPresent([BannerRevamp].self, forKey: .banner)
		show_brand_scroll_after = try values.decodeIfPresent(Int.self, forKey: .show_brand_scroll_after)
		brands = try values.decodeIfPresent([BrandsRevamp].self, forKey: .brands)
		tags = try values.decodeIfPresent([TagsRevamp].self, forKey: .tags)
		ads = try values.decodeIfPresent([AdsRevamp].self, forKey: .ads)
		store_offers = try values.decodeIfPresent([Stores].self, forKey: .store_offers)
		zone_id = try values.decodeIfPresent(String.self, forKey: .zone_id)
		horizontal_stores = try values.decodeIfPresent([Stores].self, forKey: .horizontal_stores)
		horizontal_stores_2 = try values.decodeIfPresent([Stores].self, forKey: .horizontal_stores_2)
	}

}
