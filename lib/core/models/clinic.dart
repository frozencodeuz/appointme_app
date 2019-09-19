class Clinic {
  final int id;
  final String name;
  final String phoneNumber;
  final String counsultantFee;
  final String mobileNumber;
  final String address;
  final String regNo;
  final String openingTime;
  final String closingTime;
  final String description;
  final String avatar;

  Clinic({
    this.id,
    this.name,
    this.phoneNumber,
    this.counsultantFee,
    this.mobileNumber,
    this.address,
    this.regNo,
    this.openingTime,
    this.closingTime,
    this.description,
    this.avatar,
  });

  Clinic.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['user']['name'],
        phoneNumber = json['phone_number'],
        counsultantFee = json['opd_fee'],
        mobileNumber = json['mobile_number'],
        address = json['address'],
        regNo = json['reg_no'],
        openingTime = json['opening_time'],
        closingTime = json['closing_time'],
        description = json['description'],
        avatar = json['user']['avatar'];
}
