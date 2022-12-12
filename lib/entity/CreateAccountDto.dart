import '../enums/gender.dart';

class CreateAccountDto {
  String email;
  String password;
  Gender gender;
  int age;

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'gender': gender.name,
        'age': age,
      };
}
