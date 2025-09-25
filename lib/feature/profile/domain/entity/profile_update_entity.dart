import 'package:equatable/equatable.dart';

class ProfileUpdateEntity extends Equatable {
  final String firstName;
  final String lastName;
  final String? gender;
  final String? dob;
  final String? nid;
  final String? address;
  final String? email;
  final String? thana;
  final String? policeId;
  final String? hospitalOrAgency;
  final String? fireStation;

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        gender,
        dob,
        nid,
        address,
        email,
        thana,
        policeId,
        hospitalOrAgency,
        fireStation,
      ];

  const ProfileUpdateEntity({
    required this.firstName,
    required this.lastName,
    this.gender,
    this.dob,
    this.nid,
    this.address,
    this.email,
    this.thana,
    this.policeId,
    this.hospitalOrAgency,
    this.fireStation,
  });
}
