part '../parts/user.dart';

class User {
  String? id;
  bool? isActive;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  int? greenScore;
  int? balance;
  int? expiryHours;
  String? userStatus;
  String? userStatusDate;
  String? sessionId;
  String? createdAt;
  String? updatedAt;

  String? deletedAt;
  String? username;
  bool? isEmailVerified;
  String? emailVerifiedDate;
  String? isPhoneVerified;
  String? phoneVerifiedDate;
  String? password;
  String? sessionScope;
  bool? userSuspended;
  bool? passwordExpired;
  bool? passwordNeedChange;
  bool? userTerminated;
  String? expiryDate;
  String? staffId;
  String? customerId;
  User? customer;
  User? regUser;
  String? oldPassword;
  String? userId;
  String? tokenType;
  String? accessToken;
  String? refreshToken;
  String? sessionState;
  String? registerNo;
  String? genderId;
  String? birthDate;
  String? whoTypeId;
  bool? isVerified;
  String? type;
  String? message;
  String? otpMethod;
  String? otpCode;
  Uri? url;
  String? avatar;

  User({
    this.isVerified,
    this.otpMethod,
    this.otpCode,
    this.whoTypeId,
    this.registerNo,
    this.genderId,
    this.birthDate,
    this.userId,
    this.tokenType,
    this.accessToken,
    this.refreshToken,
    this.sessionState,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.sessionId,
    this.isActive,
    this.email,
    this.username,
    this.oldPassword,
    this.isEmailVerified,
    this.emailVerifiedDate,
    this.phone,
    this.isPhoneVerified,
    this.phoneVerifiedDate,
    this.lastName,
    this.firstName,
    this.password,
    this.sessionScope,
    this.expiryHours,
    this.userSuspended,
    this.passwordExpired,
    this.passwordNeedChange,
    this.userTerminated,
    this.expiryDate,
    this.userStatus,
    this.userStatusDate,
    this.staffId,
    this.customerId,
    this.customer,
    this.regUser,
    this.greenScore,
    this.balance,
    this.type,
    this.message,
    this.url,
    this.avatar,
  });

  static $fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
