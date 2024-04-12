part of '../models/user.dart';

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['_id'] != null ? json['_id'] as String : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
    oldPassword:
        json['oldPassword'] != null ? json['oldPassword'] as String : null,
    deletedAt: json['deletedAt'] != null ? json['deletedAt'] as String : null,
    sessionId: json['sessionId'] != null ? json['sessionId'] as String : null,
    isActive: json['isActive'] != null ? json['isActive'] as bool : null,
    email: json['email'] != null ? json['email'] as String : null,
    username: json['username'] != null ? json['username'] as String : null,
    isEmailVerified: json['isEmailVerified'] != null
        ? json['isEmailVerified'] as bool
        : null,
    emailVerifiedDate: json['emailVerifiedDate'] != null
        ? json['emailVerifiedDate'] as String
        : null,
    phone: json['phone'] != null ? json['phone'] as String : null,
    isPhoneVerified: json['isPhoneVerified'] != null
        ? json['isPhoneVerified'] as String
        : null,
    phoneVerifiedDate: json['phoneVerifiedDate'] != null
        ? json['phoneVerifiedDate'] as String
        : null,
    lastName: json['lastName'] != null ? json['lastName'] as String : null,
    firstName: json['firstName'] != null ? json['firstName'] as String : null,
    password: json['password'] != null ? json['password'] as String : null,
    sessionScope:
        json['sessionScope'] != null ? json['sessionScope'] as String : null,
    expiryHours: json['expiryHours'] != null
        ? int.parse(json['expiryHours'].toString())
        : null,
    userSuspended:
        json['userSuspended'] != null ? json['userSuspended'] as bool : null,
    passwordExpired: json['passwordExpired'] != null
        ? json['passwordExpired'] as bool
        : null,
    passwordNeedChange: json['passwordNeedChange'] != null
        ? json['passwordNeedChange'] as bool
        : null,
    userTerminated:
        json['userTerminated'] != null ? json['userTerminated'] as bool : null,
    expiryDate:
        json['expiryDate'] != null ? json['expiryDate'] as String : null,
    userStatus:
        json['userStatus'] != null ? json['userStatus'] as String : null,
    userStatusDate: json['userStatusDate'] != null
        ? json['userStatusDate'] as String
        : null,
    staffId: json['staffId'] != null ? json['staffId'] as String : null,
    customerId:
        json['customerId'] != null ? json['customerId'] as String : null,
    customer: json['customer'] != null
        ? User.fromJson(json['customer'] as Map<String, dynamic>)
        : null,
    regUser: json['regUser'] != null
        ? User.fromJson(json['regUser'] as Map<String, dynamic>)
        : null,
    userId: json['userId'] != null ? json['userId'] as String : null,
    tokenType: json['tokenType'] != null ? json['tokenType'] as String : null,
    accessToken:
        json['accessToken'] != null ? json['accessToken'] as String : null,
    refreshToken:
        json['refreshToken'] != null ? json['refreshToken'] as String : null,
    sessionState:
        json['sessionState'] != null ? json['sessionState'] as String : null,
    registerNo:
        json['registerNo'] != null ? json['registerNo'] as String : null,
    genderId: json['genderId'] != null ? json['genderId'] as String : null,
    birthDate: json['birthDate'] != null ? json['birthDate'] as String : null,
    whoTypeId: json['whoTypeId'] != null ? json['whoTypeId'] as String : null,
    otpCode: json['otpCode'] != null ? json['otpCode'] as String : null,
    otpMethod: json['otpMethod'] != null ? json['otpMethod'] as String : null,
    isVerified: json['isVerified'] != null ? json['isVerified'] as bool : null,
    greenScore: json['greenScore'] != null ? json['greenScore'] as int : null,
    balance: json['balance'] != null ? json['balance'] as int : null,
  );
}

Map<String, dynamic> _$UserToJson(User instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['_id'] = instance.id;

  if (instance.isVerified != null) json['isVerified'] = instance.isVerified;
  if (instance.otpCode != null) json['otpCode'] = instance.otpCode;
  if (instance.otpMethod != null) json['otpMethod'] = instance.otpMethod;
  if (instance.whoTypeId != null) json['whoTypeId'] = instance.whoTypeId;
  if (instance.registerNo != null) json['registerNo'] = instance.registerNo;
  if (instance.genderId != null) json['genderId'] = instance.genderId;
  if (instance.birthDate != null) json['birthDate'] = instance.birthDate;
  if (instance.userId != null) json['userId'] = instance.userId;
  if (instance.tokenType != null) json['tokenType'] = instance.tokenType;
  if (instance.accessToken != null) json['accessToken'] = instance.accessToken;
  if (instance.refreshToken != null)
    json['refreshToken'] = instance.refreshToken;
  if (instance.sessionState != null)
    json['sessionState'] = instance.sessionState;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;
  if (instance.deletedAt != null) json['deletedAt'] = instance.deletedAt;
  if (instance.oldPassword != null) json['oldPassword'] = instance.oldPassword;
  if (instance.sessionId != null) json['sessionId'] = instance.sessionId;
  if (instance.isActive != null) json['isActive'] = instance.isActive;
  if (instance.email != null) json['email'] = instance.email;
  if (instance.username != null) json['username'] = instance.username;
  if (instance.isEmailVerified != null)
    json['isEmailVerified'] = instance.isEmailVerified;
  if (instance.emailVerifiedDate != null)
    json['emailVerifiedDate'] = instance.emailVerifiedDate;
  if (instance.phone != null) json['phone'] = instance.phone;
  if (instance.isPhoneVerified != null)
    json['isPhoneVerified'] = instance.isPhoneVerified;
  if (instance.phoneVerifiedDate != null)
    json['phoneVerifiedDate'] = instance.phoneVerifiedDate;
  if (instance.lastName != null) json['lastName'] = instance.lastName;
  if (instance.firstName != null) json['firstName'] = instance.firstName;
  if (instance.password != null) json['password'] = instance.password;
  if (instance.sessionScope != null)
    json['sessionScope'] = instance.sessionScope;
  if (instance.expiryHours != null) json['expiryHours'] = instance.expiryHours;
  if (instance.userSuspended != null)
    json['userSuspended'] = instance.userSuspended;
  if (instance.passwordExpired != null)
    json['passwordExpired'] = instance.passwordExpired;
  if (instance.passwordNeedChange != null)
    json['passwordNeedChange'] = instance.passwordNeedChange;
  if (instance.userTerminated != null)
    json['userTerminated'] = instance.userTerminated;
  if (instance.expiryDate != null) json['expiryDate'] = instance.expiryDate;
  if (instance.userStatus != null) json['userStatus'] = instance.userStatus;
  if (instance.userStatusDate != null)
    json['userStatusDate'] = instance.userStatusDate;
  if (instance.staffId != null) json['staffId'] = instance.staffId;
  if (instance.customerId != null) json['customerId'] = instance.customerId;
  if (instance.customer != null) json['customer'] = instance.customer;
  if (instance.regUser != null) json['regUser'] = instance.regUser;
  if (instance.greenScore != null) json['greenScore'] = instance.greenScore;
  if (instance.balance != null) json['balance'] = instance.balance;

  return json;
}
