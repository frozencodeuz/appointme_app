class Doctor {
  final int id;
  final String department;
  final String licenseNo;
  final String name;
  final String email;
  final String avatar;
  final String about;
  final String education;
  final String experience;
  final String experiences;
  final String mobileNumber;
  final String address;

  Doctor({
    this.id,
    this.department,
    this.licenseNo,
    this.name,
    this.email,
    this.avatar,
    this.about,
    this.education,
    this.experience,
    this.experiences,
    this.mobileNumber,
    this.address,
  });

  Doctor.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        department = json['department']['name'],
        licenseNo = json['license_no'],
        name = json['name'],
        email = json['email'],
        avatar = json['avatar'],
        about = json['description'],
        education = json['educations'],
        experience = json['experience'],
        experiences = json['experiences'],
        mobileNumber = json['mobile_number'],
        address = json['address'];
}
