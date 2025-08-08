

class Address{
  String addressLevel;
  String street;
  String city;
  String state;
  String zipCode;
  int latitude;
  int longitude;

  Address({
    required this.addressLevel,
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.latitude,
    required this.longitude,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    addressLevel: json["address_level"],
    street: json["street"],
    city: json["city"],
    state: json["state"],
    zipCode: json["zip_code"],
    latitude: json["latitude"],
    longitude: json["longitude"],
  );


  Map<String, dynamic> toJson() => {
    "address_level": addressLevel,
    "street": street,
    "city": city,
    "state": state,
    "zip_code": zipCode,
    "latitude": latitude,
    "longitude": longitude,
  };


}