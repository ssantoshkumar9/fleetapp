// To parse this JSON data, do
//
//     final getDrivers = getDriversFromJson(jsonString);

import 'dart:convert';

GetDrivers getDriversFromJson(String str) => GetDrivers.fromJson(json.decode(str));

String getDriversToJson(GetDrivers data) => json.encode(data.toJson());

class GetDrivers {
    String id;
    String vehicleId;
    String deviceIdentifier;
    String lastReportedTime;
    String name;
    String managerName;
    String phoneNumber;
    dynamic countryCode;
    String licenseNumber;
    String authorityIssuedBy;
    String residencyProof;
    dynamic address;
    dynamic managerId;
    String activityDays;
    int workSheduledays;
    dynamic firstName;
    dynamic lastName;
    String profilepic;
    dynamic residencyProofUrl;
    dynamic idProofUrl;
    int statusId;
    String houseNoName;
    String addressLine1;
    String addressLine2;
    String addressLine3;
    String postcode;
    int loginFlag;
    dynamic userName;
    String email;
    dynamic passwordHash;
    bool monday;
    bool tuesday;
    bool wednesday;
    bool thrusday;
    bool friday;
    bool saturday;
    bool sunday;
    String startTime;
    String endTime;
    String fleetId;
    dynamic fleetName;
    dynamic identityFile;
    dynamic addressFile;
    String idProof;
    int workingTime;

    GetDrivers({
        this.id,
        this.vehicleId,
        this.deviceIdentifier,
        this.lastReportedTime,
        this.name,
        this.managerName,
        this.phoneNumber,
        this.countryCode,
        this.licenseNumber,
        this.authorityIssuedBy,
        this.residencyProof,
        this.address,
        this.managerId,
        this.activityDays,
        this.workSheduledays,
        this.firstName,
        this.lastName,
        this.profilepic,
        this.residencyProofUrl,
        this.idProofUrl,
        this.statusId,
        this.houseNoName,
        this.addressLine1,
        this.addressLine2,
        this.addressLine3,
        this.postcode,
        this.loginFlag,
        this.userName,
        this.email,
        this.passwordHash,
        this.monday,
        this.tuesday,
        this.wednesday,
        this.thrusday,
        this.friday,
        this.saturday,
        this.sunday,
        this.startTime,
        this.endTime,
        this.fleetId,
        this.fleetName,
        this.identityFile,
        this.addressFile,
        this.idProof,
        this.workingTime,
    });

    factory GetDrivers.fromJson(Map<String, dynamic> json) => new GetDrivers(
        id: json["Id"],
        vehicleId: json["VehicleId"],
        deviceIdentifier: json["DeviceIdentifier"],
        lastReportedTime: json["LastReportedTime"],
        name: json["Name"],
        managerName: json["ManagerName"],
        phoneNumber: json["PhoneNumber"],
        countryCode: json["CountryCode"],
        licenseNumber: json["LicenseNumber"],
        authorityIssuedBy: json["AuthorityIssuedBy"],
        residencyProof: json["ResidencyProof"],
        address: json["Address"],
        managerId: json["ManagerId"],
        activityDays: json["ActivityDays"],
        workSheduledays: json["WorkSheduledays"],
        firstName: json["FirstName"],
        lastName: json["LastName"],
        profilepic: json["Profilepic"],
        residencyProofUrl: json["ResidencyProofURL"],
        idProofUrl: json["IDProofURL"],
        statusId: json["StatusId"],
        houseNoName: json["HouseNoName"],
        addressLine1: json["AddressLine1"],
        addressLine2: json["AddressLine2"],
        addressLine3: json["AddressLine3"],
        postcode: json["Postcode"],
        loginFlag: json["LoginFlag"],
        userName: json["userName"],
        email: json["Email"],
        passwordHash: json["PasswordHash"],
        monday: json["Monday"],
        tuesday: json["Tuesday"],
        wednesday: json["Wednesday"],
        thrusday: json["Thrusday"],
        friday: json["Friday"],
        saturday: json["Saturday"],
        sunday: json["Sunday"],
        startTime: json["StartTime"],
        endTime: json["EndTime"],
        fleetId: json["FleetId"],
        fleetName: json["FleetName"],
        identityFile: json["IdentityFile"],
        addressFile: json["AddressFile"],
        idProof: json["IDProof"],
        workingTime: json["WorkingTime"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "VehicleId": vehicleId,
        "DeviceIdentifier": deviceIdentifier,
        "LastReportedTime": lastReportedTime,
        "Name": name,
        "ManagerName": managerName,
        "PhoneNumber": phoneNumber,
        "CountryCode": countryCode,
        "LicenseNumber": licenseNumber,
        "AuthorityIssuedBy": authorityIssuedBy,
        "ResidencyProof": residencyProof,
        "Address": address,
        "ManagerId": managerId,
        "ActivityDays": activityDays,
        "WorkSheduledays": workSheduledays,
        "FirstName": firstName,
        "LastName": lastName,
        "Profilepic": profilepic,
        "ResidencyProofURL": residencyProofUrl,
        "IDProofURL": idProofUrl,
        "StatusId": statusId,
        "HouseNoName": houseNoName,
        "AddressLine1": addressLine1,
        "AddressLine2": addressLine2,
        "AddressLine3": addressLine3,
        "Postcode": postcode,
        "LoginFlag": loginFlag,
        "userName": userName,
        "Email": email,
        "PasswordHash": passwordHash,
        "Monday": monday,
        "Tuesday": tuesday,
        "Wednesday": wednesday,
        "Thrusday": thrusday,
        "Friday": friday,
        "Saturday": saturday,
        "Sunday": sunday,
        "StartTime": startTime,
        "EndTime": endTime,
        "FleetId": fleetId,
        "FleetName": fleetName,
        "IdentityFile": identityFile,
        "AddressFile": addressFile,
        "IDProof": idProof,
        "WorkingTime": workingTime,
    };
}
