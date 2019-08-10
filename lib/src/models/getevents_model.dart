// To parse this JSON data, do
//
//     final getEvents = getEventsFromJson(jsonString);

import 'dart:convert';

GetEvents getEventsFromJson(String str) => GetEvents.fromJson(json.decode(str));

String getEventsToJson(GetEvents data) => json.encode(data.toJson());

class GetEvents {
    List<Event> events;
    List<dynamic> incidents;
    dynamic deviceIdentifier;

    GetEvents({
        this.events,
        this.incidents,
        this.deviceIdentifier,
    });

    factory GetEvents.fromJson(Map<String, dynamic> json) => new GetEvents(
        events: new List<Event>.from(json["events"].map((x) => Event.fromJson(x))),
        incidents: new List<dynamic>.from(json["incidents"].map((x) => x)),
        deviceIdentifier: json["deviceIdentifier"],
    );

    Map<String, dynamic> toJson() => {
        "events": new List<dynamic>.from(events.map((x) => x.toJson())),
        "incidents": new List<dynamic>.from(incidents.map((x) => x)),
        "deviceIdentifier": deviceIdentifier,
    };
}

class Event {
    int id;
    String evetId;
    Type type;
    Displayname displayname;
    double lat;
    double lng;
    String time;
    DateTime eventDate;
    String dateReceivedFromDevice;
    dynamic deviceIdentifier;
    dynamic fleetId;
    String requestStartTime;
    String dateCreated;
    int hdg;
    int alt;
    int gX;
    int gY;
    int gZ;
    int spd;
    int offset;
    String locationAddress;
    int eventRaisedPoint;
    dynamic tripId;
    int severity;
    String eventAnalyticsFile;
    List<ImageList> imageList;
    List<NewimageList> newimageList;
    List<ImageList> videoList;
    dynamic eventReviewStatus;
    bool isDismissedEvent;
    dynamic isFilter;
    dynamic flag;
    List<ServercommandVideoList> servercommandVideoList;

    Event({
        this.id,
        this.evetId,
        this.type,
        this.displayname,
        this.lat,
        this.lng,
        this.time,
        this.eventDate,
        this.dateReceivedFromDevice,
        this.deviceIdentifier,
        this.fleetId,
        this.requestStartTime,
        this.dateCreated,
        this.hdg,
        this.alt,
        this.gX,
        this.gY,
        this.gZ,
        this.spd,
        this.offset,
        this.locationAddress,
        this.eventRaisedPoint,
        this.tripId,
        this.severity,
        this.eventAnalyticsFile,
        this.imageList,
        this.newimageList,
        this.videoList,
        this.eventReviewStatus,
        this.isDismissedEvent,
        this.isFilter,
        this.flag,
        this.servercommandVideoList,
    });

    factory Event.fromJson(Map<String, dynamic> json) => new Event(
        id: json["id"],
        evetId: json["evetId"],
        type: typeValues.map[json["type"]],
        displayname: displaynameValues.map[json["displayname"]],
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
        time: json["time"],
        eventDate: DateTime.parse(json["eventDate"]),
        dateReceivedFromDevice: json["DateReceivedFromDevice"] == null ? null : json["DateReceivedFromDevice"],
        deviceIdentifier: json["DeviceIdentifier"],
        fleetId: json["FleetId"],
        requestStartTime: json["RequestStartTime"] == null ? null : json["RequestStartTime"],
        dateCreated: json["DateCreated"] == null ? null : json["DateCreated"],
        hdg: json["hdg"],
        alt: json["alt"],
        gX: json["gX"],
        gY: json["gY"],
        gZ: json["gZ"],
        spd: json["spd"],
        offset: json["offset"],
        locationAddress: json["LocationAddress"],
        eventRaisedPoint: json["eventRaisedPoint"],
        tripId: json["tripId"],
        severity: json["severity"],
        eventAnalyticsFile: json["EventAnalyticsFile"],
        imageList: new List<ImageList>.from(json["imageList"].map((x) => ImageList.fromJson(x))),
        newimageList: new List<NewimageList>.from(json["newimageList"].map((x) => NewimageList.fromJson(x))),
        videoList: new List<ImageList>.from(json["videoList"].map((x) => ImageList.fromJson(x))),
        eventReviewStatus: json["eventReviewStatus"],
        isDismissedEvent: json["isDismissedEvent"],
        isFilter: json["isFilter"],
        flag: json["Flag"],
        servercommandVideoList: new List<ServercommandVideoList>.from(json["servercommandVideoList"].map((x) => ServercommandVideoList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "evetId": evetId,
        "type": typeValues.reverse[type],
        "displayname": displaynameValues.reverse[displayname],
        "lat": lat,
        "lng": lng,
        "time": time,
        "eventDate": eventDate.toIso8601String(),
        "DateReceivedFromDevice": dateReceivedFromDevice == null ? null : dateReceivedFromDevice,
        "DeviceIdentifier": deviceIdentifier,
        "FleetId": fleetId,
        "RequestStartTime": requestStartTime == null ? null : requestStartTime,
        "DateCreated": dateCreated == null ? null : dateCreated,
        "hdg": hdg,
        "alt": alt,
        "gX": gX,
        "gY": gY,
        "gZ": gZ,
        "spd": spd,
        "offset": offset,
        "LocationAddress": locationAddress,
        "eventRaisedPoint": eventRaisedPoint,
        "tripId": tripId,
        "severity": severity,
        "EventAnalyticsFile": eventAnalyticsFile,
        "imageList": new List<dynamic>.from(imageList.map((x) => x.toJson())),
        "newimageList": new List<dynamic>.from(newimageList.map((x) => x.toJson())),
        "videoList": new List<dynamic>.from(videoList.map((x) => x.toJson())),
        "eventReviewStatus": eventReviewStatus,
        "isDismissedEvent": isDismissedEvent,
        "isFilter": isFilter,
        "Flag": flag,
        "servercommandVideoList": new List<dynamic>.from(servercommandVideoList.map((x) => x.toJson())),
    };
}

enum Displayname { SUDDEN_ACCELERATION, G_SHOCK, SUDDEN_BRAKING }

final displaynameValues = new EnumValues({
    "GShock": Displayname.G_SHOCK,
    "Sudden Acceleration": Displayname.SUDDEN_ACCELERATION,
    "Sudden Braking": Displayname.SUDDEN_BRAKING
});

class ImageList {
    int id;
    dynamic name;
    int type;
    String url;
    dynamic blobUrl;
    int eventId;
    int channel;
    int mediaType;

    ImageList({
        this.id,
        this.name,
        this.type,
        this.url,
        this.blobUrl,
        this.eventId,
        this.channel,
        this.mediaType,
    });

    factory ImageList.fromJson(Map<String, dynamic> json) => new ImageList(
        id: json["Id"],
        name: json["name"],
        type: json["type"],
        url: json["Url"],
        blobUrl: json["BlobUrl"],
        eventId: json["eventId"],
        channel: json["Channel"],
        mediaType: json["mediaType"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "name": name,
        "type": type,
        "Url": url,
        "BlobUrl": blobUrl,
        "eventId": eventId,
        "Channel": channel,
        "mediaType": mediaType,
    };
}

class NewimageList {
    int channelId;
    List<ImageList> images;

    NewimageList({
        this.channelId,
        this.images,
    });

    factory NewimageList.fromJson(Map<String, dynamic> json) => new NewimageList(
        channelId: json["channelId"],
        images: new List<ImageList>.from(json["images"].map((x) => ImageList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "channelId": channelId,
        "images": new List<dynamic>.from(images.map((x) => x.toJson())),
    };
}

class ServercommandVideoList {
    String id;
    String deviceIdentifier;
    String status;
    String createdBy;
    String commandTypeId;
    int commandSequence;
    int data;
    String commandData;
    DateTime dateRaised;
    DateTime dateCreated;
    DateTime dateSentToDevice;
    DateTime dateReceivedFromDevice;
    String documentId;
    String deviceId;
    DateTime requestStartTime;
    dynamic callbackUrl;
    bool mediaOverlay;
    int channelId;
    String mediaRequestId;
    List<Media> media;
    String eventId;
    int duration;
    dynamic responseReceivedFromDevice;
    dynamic notes;
    String description;
    int deviceModelId;
    dynamic commandTemplate;
    dynamic timeSentToDevice;
    dynamic timeReceivedFromDevice;

    ServercommandVideoList({
        this.id,
        this.deviceIdentifier,
        this.status,
        this.createdBy,
        this.commandTypeId,
        this.commandSequence,
        this.data,
        this.commandData,
        this.dateRaised,
        this.dateCreated,
        this.dateSentToDevice,
        this.dateReceivedFromDevice,
        this.documentId,
        this.deviceId,
        this.requestStartTime,
        this.callbackUrl,
        this.mediaOverlay,
        this.channelId,
        this.mediaRequestId,
        this.media,
        this.eventId,
        this.duration,
        this.responseReceivedFromDevice,
        this.notes,
        this.description,
        this.deviceModelId,
        this.commandTemplate,
        this.timeSentToDevice,
        this.timeReceivedFromDevice,
    });

    factory ServercommandVideoList.fromJson(Map<String, dynamic> json) => new ServercommandVideoList(
        id: json["Id"],
        deviceIdentifier: json["DeviceIdentifier"],
        status: json["Status"],
        createdBy: json["CreatedBy"],
        commandTypeId: json["CommandTypeId"],
        commandSequence: json["CommandSequence"],
        data: json["Data"],
        commandData: json["CommandData"],
        dateRaised: DateTime.parse(json["DateRaised"]),
        dateCreated: DateTime.parse(json["DateCreated"]),
        dateSentToDevice: DateTime.parse(json["DateSentToDevice"]),
        dateReceivedFromDevice: DateTime.parse(json["DateReceivedFromDevice"]),
        documentId: json["DocumentId"],
        deviceId: json["DeviceId"],
        requestStartTime: DateTime.parse(json["RequestStartTime"]),
        callbackUrl: json["CallbackUrl"],
        mediaOverlay: json["MediaOverlay"],
        channelId: json["ChannelId"],
        mediaRequestId: json["MediaRequestId"],
        media: new List<Media>.from(json["Media"].map((x) => Media.fromJson(x))),
        eventId: json["EventId"],
        duration: json["Duration"],
        responseReceivedFromDevice: json["ResponseReceivedFromDevice"],
        notes: json["Notes"],
        description: json["Description"],
        deviceModelId: json["DeviceModelId"],
        commandTemplate: json["CommandTemplate"],
        timeSentToDevice: json["TimeSentToDevice"],
        timeReceivedFromDevice: json["TimeReceivedFromDevice"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "DeviceIdentifier": deviceIdentifier,
        "Status": status,
        "CreatedBy": createdBy,
        "CommandTypeId": commandTypeId,
        "CommandSequence": commandSequence,
        "Data": data,
        "CommandData": commandData,
        "DateRaised": dateRaised.toIso8601String(),
        "DateCreated": dateCreated.toIso8601String(),
        "DateSentToDevice": dateSentToDevice.toIso8601String(),
        "DateReceivedFromDevice": dateReceivedFromDevice.toIso8601String(),
        "DocumentId": documentId,
        "DeviceId": deviceId,
        "RequestStartTime": requestStartTime.toIso8601String(),
        "CallbackUrl": callbackUrl,
        "MediaOverlay": mediaOverlay,
        "ChannelId": channelId,
        "MediaRequestId": mediaRequestId,
        "Media": new List<dynamic>.from(media.map((x) => x.toJson())),
        "EventId": eventId,
        "Duration": duration,
        "ResponseReceivedFromDevice": responseReceivedFromDevice,
        "Notes": notes,
        "Description": description,
        "DeviceModelId": deviceModelId,
        "CommandTemplate": commandTemplate,
        "TimeSentToDevice": timeSentToDevice,
        "TimeReceivedFromDevice": timeReceivedFromDevice,
    };
}

class Media {
    String url;
    dynamic blobUrl;
    int channelId;
    int mediaType;
    String mediaRequestId;

    Media({
        this.url,
        this.blobUrl,
        this.channelId,
        this.mediaType,
        this.mediaRequestId,
    });

    factory Media.fromJson(Map<String, dynamic> json) => new Media(
        url: json["Url"] == null ? null : json["Url"],
        blobUrl: json["BlobUrl"],
        channelId: json["ChannelId"],
        mediaType: json["MediaType"],
        mediaRequestId: json["MediaRequestId"],
    );

    Map<String, dynamic> toJson() => {
        "Url": url == null ? null : url,
        "BlobUrl": blobUrl,
        "ChannelId": channelId,
        "MediaType": mediaType,
        "MediaRequestId": mediaRequestId,
    };
}

enum Type { SUDDEN_ACCELERATION, G_SHOCK, SUDDEN_BRAKING }

final typeValues = new EnumValues({
    "GShock": Type.G_SHOCK,
    "SuddenAcceleration": Type.SUDDEN_ACCELERATION,
    "SuddenBraking": Type.SUDDEN_BRAKING
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
