class PlaceModel {
  int? id;
  String? title;
  String? image;
  String? address;
  String? description;
  int? featured;
  int? available;
  int? bookable;
  int? weekdayPrice;
  int? weekendPrice;
  String? tag;
  int? categoryId;
  int? vendorId;
  String? rate;
  int? userId;
  int? placeModelId;
  int? serviceId;
  int? price;
  String? startDate;
  String? endDate;
  List<String>? amenities;

  PlaceModel({
    this.id,
    this.title,
    this.image,
    this.address,
    this.description,
    this.featured,
    this.available,
    this.bookable,
    this.weekdayPrice,
    this.weekendPrice,
    this.tag,
    this.categoryId,
    this.vendorId,
    this.rate,
    this.userId,
    this.placeModelId,
    this.serviceId,
    this.price,
    this.startDate,
    this.endDate,
    this.amenities,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      image: json['image'] as String?,
      address: json['address'] as String?,
      description: json['description'] as String?,
      featured: json['featured'] as int?,
      available: json['available'] as int?,
      bookable: json['bookable'] as int?,
      weekdayPrice: json['weekday_price'] as int?,
      weekendPrice: json['weekend_price'] as int?,
      tag: json['tag'] as String?,
      categoryId: json['category_id'] as int?,
      vendorId: json['vendor_id'] as int?,
      rate: json['rating'] as String?,
      userId: json['user_id'] as int?,
      placeModelId: json['PlaceModel_id'] as int?,
      serviceId: json['service_id'] as int?,
      price: json['price'] as int?,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      amenities: (json['amenities'] as List<dynamic>?)
          ?.map((amenity) => amenity as String)
          .toList(),
    );
  }
}
