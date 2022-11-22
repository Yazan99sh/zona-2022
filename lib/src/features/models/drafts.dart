// To parse this JSON data, do
//
//     final drafts = draftsFromJson(jsonString);

import 'dart:convert';

List<Drafts> draftsFromJson(String str) => List<Drafts>.from(json.decode(str).map((x) => Drafts.fromJson(x)));

String draftsToJson(List<Drafts> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Drafts {
    Drafts({
        this.id,
        this.name,
        this.orderNumber,
        this.date,
        this.time,
        this.address,
        this.phone,
        this.totalPrice,
        this.color,
        this.location,
        this.notes,
        this.longitude,
        this.latitude,
        this.taxNumber,
        this.status,
        this.service,
        this.username,
        this.provider,
    });

    int? id;
    String? name;
    String? orderNumber;
    String? date;
    String? time;
    String? address;
    String? phone;
    int? totalPrice;
    dynamic? color;
    dynamic? location;
    String? notes;
    dynamic? longitude;
    dynamic? latitude;
    dynamic? taxNumber;
    String? status;
    Service? service;
    String? username;
    Provider? provider;

    factory Drafts.fromJson(Map<String, dynamic> json) => Drafts(
        id: json["id"],
        name: json["name"],
        orderNumber: json["order_number"],
        date: json["date"],
        time: json["time"],
        address: json["address"],
        phone: json["phone"],
        totalPrice: json["total_price"],
        color: json["color"],
        location: json["location"],
        notes: json["notes"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        taxNumber: json["tax_number"],
        status: json["status"],
        service: Service.fromJson(json["service"]),
        username: json["username"],
        provider: Provider.fromJson(json["provider"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "order_number": orderNumber,
        "date": date,
        "time": time,
        "address": address,
        "phone": phone,
        "total_price": totalPrice,
        "color": color,
        "location": location,
        "notes": notes,
        "longitude": longitude,
        "latitude": latitude,
        "tax_number": taxNumber,
        "status": status,
        "service": service!.toJson(),
        "username": username,
        "provider": provider!.toJson(),
    };
}

class Provider {
    Provider({
        this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.gender,
        this.profileImage,
        this.dateOfBirth,
    });

    int? id;
    String? firstName;
    String? lastName;
    String? email;
    String? phone;
    String? gender;
    String? profileImage;
    dynamic? dateOfBirth;

    factory Provider.fromJson(Map<String, dynamic> json) => Provider(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phone: json["phone"],
        gender: json["gender"],
        profileImage: json["profile_image"],
        dateOfBirth: json["date_of_birth"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone": phone,
        "gender": gender,
        "profile_image": profileImage,
        "date_of_birth": dateOfBirth,
    };
}

class Service {
    Service({
        this.id,
        this.price,
        this.image,
        this.name,
        this.description,
        this.isColor,
        this.idcategory,
        this.idprovider,
        this.address,
        this.rate,
    });

    int? id;
    double? price;
    String? image;
    String? name;
    String? description;
    dynamic? isColor;
    String? idcategory;
    String? idprovider;
    String? address;
    int? rate;

    factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"],
        price: json["price"].toDouble(),
        image: json["image"],
        name: json["name"],
        description: json["description"],
        isColor: json["is_color"],
        idcategory: json["idcategory"],
        idprovider: json["idprovider"],
        address: json["address"],
        rate: json["rate"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "image": image,
        "name": name,
        "description": description,
        "is_color": isColor,
        "idcategory": idcategory,
        "idprovider": idprovider,
        "address": address,
        "rate": rate,
    };
}
