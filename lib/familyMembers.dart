class FamilyMember {
  String id;
  String name;
  String gender;
  int age;
  String relation;
  String educationLevel;
  String occupationType;
  String occupation;
  double grossMonthlyIncome;
  String mobileNumber;
  bool isRecievedAnyAid;
  String aidDescription;

  FamilyMember({
    required this.name,
    required this.relation,
    required this.gender,
    required this.age,
    required this.occupationType,
    required this.occupation,
    required this.grossMonthlyIncome,
    required this.mobileNumber,
    required this.educationLevel,
    required this.id,
    required this.isRecievedAnyAid,
    required this.aidDescription,
  });

  get ismemberrecievedanyaid => null;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'gender': gender,
      'age': age,
      'relation': relation,
      'educationlevel': educationLevel,
      'occupationtype': occupationType,
      'occupation': occupation,
      'grossmonthlyincome': grossMonthlyIncome,
      'mobilenumber': mobileNumber,
      'ismemberrecievedanyaid': isRecievedAnyAid,
      'aiddescription': aidDescription,
    };
  }
}
