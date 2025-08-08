
import '../address.dart';

class FarmRequest{
  int? id;
  int accountId;
  String name;
  List<Address> addresses;

  FarmRequest({
    required this.accountId,
    required this.name,
    required this.addresses,
  });

  factory FarmRequest.fromJson(Map<String, dynamic> json) => FarmRequest(
    accountId: json["account_id"],
    name: json["name"],
    addresses: List<Address>.from(json["addresses"].map((x) => Address.fromJson(x))),
  );



  Map<String, dynamic> toJson() => {
    "account_id": accountId,
    "name": name,
    "addresses": List<dynamic>.from(addresses.map((x) => x.toJson())),
  };


}