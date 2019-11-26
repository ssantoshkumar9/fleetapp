// To parse this JSON data, do
//
//     final newEventsList = newEventsListFromJson(jsonString);

import 'dart:convert';

List<NewEventsList> newEventsListFromJson(String str) => List<NewEventsList>.from(json.decode(str).map((x) => NewEventsList.fromJson(x)));

String newEventsListToJson(List<NewEventsList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewEventsList {
    String eventId;
    String type;
    double lat;
    double lng;
    String time;
    String deviceIdentifier;
    int hdg;
    int alt;
    int gX;
    int gY;
    int gZ;
    int spd;
    int offset;
    String address;
    int severity;
    String eventAnalyticsFile;
    List<Image> images;
    List<Image> videos;
    bool isDismissedEvent;
    bool isGeneralEvent;
    List<ServerCommandVideo> serverCommandVideos;
    String vrn;
    int vehicleType;
    String driver;

    NewEventsList({
        this.eventId,
        this.type,
        this.lat,
        this.lng,
        this.time,
        this.deviceIdentifier,
        this.hdg,
        this.alt,
        this.gX,
        this.gY,
        this.gZ,
        this.spd,
        this.offset,
        this.address,
        this.severity,
        this.eventAnalyticsFile,
        this.images,
        this.videos,
        this.isDismissedEvent,
        this.isGeneralEvent,
        this.serverCommandVideos,
        this.vrn,
        this.vehicleType,
        this.driver,
    });

    factory NewEventsList.fromJson(Map<String, dynamic> json) => NewEventsList(
        eventId: json["eventId"],
        type: json["type"],
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
        time: json["time"],
        deviceIdentifier: json["deviceIdentifier"],
        hdg: json["hdg"],
        alt: json["alt"],
        gX: json["gX"],
        gY: json["gY"],
        gZ: json["gZ"],
        spd: json["spd"],
        offset: json["offset"],
        address: json["address"],
        severity: json["severity"],
        eventAnalyticsFile: json["eventAnalyticsFile"] == null ? null : json["eventAnalyticsFile"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        videos: List<Image>.from(json["videos"].map((x) => Image.fromJson(x))),
        isDismissedEvent: json["isDismissedEvent"],
        isGeneralEvent: json["isGeneralEvent"],
        serverCommandVideos: List<ServerCommandVideo>.from(json["serverCommandVideos"].map((x) => ServerCommandVideo.fromJson(x))),
        vrn: json["VRN"],
        vehicleType: json["VehicleType"],
        driver: json["Driver"],
    );

    Map<String, dynamic> toJson() => {
        "eventId": eventId,
        "type": type,
        "lat": lat,
        "lng": lng,
        "time": time,
        "deviceIdentifier": deviceIdentifier,
        "hdg": hdg,
        "alt": alt,
        "gX": gX,
        "gY": gY,
        "gZ": gZ,
        "spd": spd,
        "offset": offset,
        "address": address,
        "severity": severity,
        "eventAnalyticsFile": eventAnalyticsFile == null ? null : eventAnalyticsFile,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
        "isDismissedEvent": isDismissedEvent,
        "isGeneralEvent": isGeneralEvent,
        "serverCommandVideos": List<dynamic>.from(serverCommandVideos.map((x) => x.toJson())),
        "VRN": vrn,
        "VehicleType": vehicleType,
        "Driver": driver,
    };
}

enum DeviceIdentifier { V2_MAX1500858, THE_359647090234928 }

final deviceIdentifierValues = EnumValues({
    "359647090234928": DeviceIdentifier.THE_359647090234928,
    "V2MAX1500858": DeviceIdentifier.V2_MAX1500858
});

enum Driver { MANISH_SRIVASTAVA, SANGRAM_I20 }

final driverValues = EnumValues({
    "Manish Srivastava": Driver.MANISH_SRIVASTAVA,
    "sangram i20": Driver.SANGRAM_I20
});

class Image {
    int channelId;
    double id;
    String url;
    String blobUrl;
    int mediaType;

    Image({
        this.channelId,
        this.id,
        this.url,
        this.blobUrl,
        this.mediaType,
    });

    factory Image.fromJson(Map<String, dynamic> json) => Image(
        channelId: json["channelId"],
        id: json["id"] == null ? null : json["id"],
        url: json["url"],
        blobUrl: json["blobUrl"],
        mediaType: json["mediaType"] == null ? null : json["mediaType"],
    );

    Map<String, dynamic> toJson() => {
        "channelId": channelId,
        "id": id == null ? null : id,
        "url": url,
        "blobUrl": blobUrl,
        "mediaType": mediaType == null ? null : mediaType,
    };
}

class ServerCommandVideo {
    String id;
    int status;
    List<Image> media;
    int duration;

    ServerCommandVideo({
        this.id,
        this.status,
        this.media,
        this.duration,
    });

    factory ServerCommandVideo.fromJson(Map<String, dynamic> json) => ServerCommandVideo(
        id: json["id"],
        status: json["status"],
        media: List<Image>.from(json["media"].map((x) => Image.fromJson(x))),
        duration: json["duration"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "media": List<dynamic>.from(media.map((x) => x.toJson())),
        "duration": duration,
    };
}

enum Type { ENTER_AREA, SUDDEN_ACCELERATION, SPEED, G_SHOCK }

final typeValues = EnumValues({
    "EnterArea": Type.ENTER_AREA,
    "GShock": Type.G_SHOCK,
    "Speed": Type.SPEED,
    "SuddenAcceleration": Type.SUDDEN_ACCELERATION
});

enum Vrn { SMANISH, TS08_FQ_0841 }

final vrnValues = EnumValues({
    "SMANISH": Vrn.SMANISH,
    "TS08 FQ 0841": Vrn.TS08_FQ_0841
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
