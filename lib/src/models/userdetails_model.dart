// To parse this JSON data, do
//
//     final userDetails = userDetailsFromJson(jsonString);

import 'dart:convert';

UserDetails userDetailsFromJson(String str) => UserDetails.fromJson(json.decode(str));

String userDetailsToJson(UserDetails data) => json.encode(data.toJson());

class UserDetails {
    String id;
    String roleId;
    String userName;
    String firstName;
    String lastName;
    String email;
    String passwordHash;
    String phoneNumber;
    DateTime lockoutEndDateUtc;
    bool lockoutEnabled;
    int accessFailedCount;
    String fleetGroupid;
    String deviceId;
    dynamic securityStamp;
    bool keepSessionAlive;
    String roleName;
    int roletypeId;
    dynamic roleDisplayName;
    int statusId;
    dynamic fleetName;
    String createdDate;
    String profilepic;
    dynamic profilepic1;
    dynamic clientIpAddress;
    dynamic success;
    dynamic request;
    dynamic status;
    String userTimeZone;
    String timeFormat;
    String dateFormate;
    String blobUserProfileUrl;
    String variantId;
    String variant;
    bool usernameExit;

    UserDetails({
        this.id,
        this.roleId,
        this.userName,
        this.firstName,
        this.lastName,
        this.email,
        this.passwordHash,
        this.phoneNumber,
        this.lockoutEndDateUtc,
        this.lockoutEnabled,
        this.accessFailedCount,
        this.fleetGroupid,
        this.deviceId,
        this.securityStamp,
        this.keepSessionAlive,
        this.roleName,
        this.roletypeId,
        this.roleDisplayName,
        this.statusId,
        this.fleetName,
        this.createdDate,
        this.profilepic,
        this.profilepic1,
        this.clientIpAddress,
        this.success,
        this.request,
        this.status,
        this.userTimeZone,
        this.timeFormat,
        this.dateFormate,
        this.blobUserProfileUrl,
        this.variantId,
        this.variant,
        this.usernameExit,
    });

    factory UserDetails.fromJson(Map<String, dynamic> json) => new UserDetails(
        id: json["Id"],
        roleId: json["RoleId"],
        userName: json["UserName"],
        firstName: json["FirstName"],
        lastName: json["LastName"],
        email: json["Email"],
        passwordHash: json["PasswordHash"],
        phoneNumber: json["PhoneNumber"],
        lockoutEndDateUtc: DateTime.parse(json["LockoutEndDateUtc"]),
        lockoutEnabled: json["LockoutEnabled"],
        accessFailedCount: json["AccessFailedCount"],
        fleetGroupid: json["FleetGroupid"],
        deviceId: json["DeviceId"],
        securityStamp: json["SecurityStamp"],
        keepSessionAlive: json["KeepSessionAlive"],
        roleName: json["RoleName"],
        roletypeId: json["roletypeId"],
        roleDisplayName: json["RoleDisplayName"],
        statusId: json["StatusId"],
        fleetName: json["FleetName"],
        createdDate: json["CreatedDate"],
        profilepic: json["Profilepic"],
        profilepic1: json["Profilepic1"],
        clientIpAddress: json["ClientIpAddress"],
        success: json["Success"],
        request: json["Request"],
        status: json["Status"],
        userTimeZone: json["UserTimeZone"],
        timeFormat: json["timeFormat"],
        dateFormate: json["dateFormate"],
        blobUserProfileUrl: json["blobUserProfileUrl"],
        variantId: json["VariantId"],
        variant: json["Variant"],
        usernameExit: json["UsernameExit"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "RoleId": roleId,
        "UserName": userName,
        "FirstName": firstName,
        "LastName": lastName,
        "Email": email,
        "PasswordHash": passwordHash,
        "PhoneNumber": phoneNumber,
        "LockoutEndDateUtc": lockoutEndDateUtc.toIso8601String(),
        "LockoutEnabled": lockoutEnabled,
        "AccessFailedCount": accessFailedCount,
        "FleetGroupid": fleetGroupid,
        "DeviceId": deviceId,
        "SecurityStamp": securityStamp,
        "KeepSessionAlive": keepSessionAlive,
        "RoleName": roleName,
        "roletypeId": roletypeId,
        "RoleDisplayName": roleDisplayName,
        "StatusId": statusId,
        "FleetName": fleetName,
        "CreatedDate": createdDate,
        "Profilepic": profilepic,
        "Profilepic1": profilepic1,
        "ClientIpAddress": clientIpAddress,
        "Success": success,
        "Request": request,
        "Status": status,
        "UserTimeZone": userTimeZone,
        "timeFormat": timeFormat,
        "dateFormate": dateFormate,
        "blobUserProfileUrl": blobUserProfileUrl,
        "VariantId": variantId,
        "Variant": variant,
        "UsernameExit": usernameExit,
    };
}
