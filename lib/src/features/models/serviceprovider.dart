class ServiceProvider {
  int? id;
  String? firstName;
  String? lastName;
  String? name;
  String? phone;
  String? gender;
  String? email;
  String? emailVerifiedAt;
  String? profileImage;
  String? verified;
  String? verificationCodes;
  String? remove;
  int? idcategory;
  String? description;
  String? location;
  String? dateOfBirth;
  String? createdAt;
  String? updatedAt;

  ServiceProvider(
      {this.id,
      this.firstName,
      this.lastName,
      this.name,
      this.phone,
      this.gender,
      this.email,
      this.emailVerifiedAt,
      this.profileImage,
      this.verified,
      this.verificationCodes,
      this.remove,
      this.idcategory,
      this.description,
      this.location,
      this.dateOfBirth,
      this.createdAt,
      this.updatedAt});

  ServiceProvider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    name = json['name'];
    phone = json['phone'];
    gender = json['gender'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    profileImage = json['profile_image'];
    verified = json['verified'];
    verificationCodes = json['verification_codes'];
    remove = json['remove'];
    idcategory = json['idcategory'];
    description = json['description'];
    location = json['location'];
    dateOfBirth = json['date_of_birth'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['name'] = name;
    data['phone'] = phone;
    data['gender'] = gender;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['profile_image'] = profileImage;
    data['verified'] = verified;
    data['verification_codes'] = verificationCodes;
    data['remove'] = remove;
    data['idcategory'] = idcategory;
    data['description'] = description;
    data['location'] = location;
    data['date_of_birth'] = dateOfBirth;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
