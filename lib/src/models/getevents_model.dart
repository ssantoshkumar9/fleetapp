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
    //int id;
    String evetId;
    String type;
    String displayname;
    int eventTypeGroupId;
    String eventTypeGroupName;
    double lat;
    double lng;
    String time;
    DateTime eventDate;
    dynamic dateReceivedFromDevice;
    dynamic deviceIdentifier;
    dynamic fleetId;
    dynamic requestStartTime;
    dynamic dateCreated;
    int hdg;
    int alt;
    int gX;
    int gY;
    int gZ;
    int spd;
    int offset;
    String locationAddress;
   // int eventRaisedPoint;
    dynamic tripId;
    int severity;
    String eventAnalyticsFile;
    List<Image> imageList;
    List<NewimageList> newimageList;
    List<dynamic> videoList;
    dynamic eventReviewStatus;
    bool isDismissedEvent;
    bool isGeneralEvent;
    bool isFilter;
    dynamic flag;
    List<dynamic> servercommandVideoList;

    Event({
        //this.id,
        this.evetId,
        this.type,
        this.displayname,
        this.eventTypeGroupId,
        this.eventTypeGroupName,
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
       // this.eventRaisedPoint,
        this.tripId,
        this.severity,
        this.eventAnalyticsFile,
        this.imageList,
        this.newimageList,
        this.videoList,
        this.eventReviewStatus,
        this.isDismissedEvent,
        this.isGeneralEvent,
        this.isFilter,
        this.flag,
        this.servercommandVideoList,
    });

    factory Event.fromJson(Map<String, dynamic> json) => new Event(
        //id: json["id"],
        evetId: json["evetId"],
        type: json["type"],
        displayname: json["displayname"],
        eventTypeGroupId: json["EventTypeGroupId"],
        eventTypeGroupName: json["EventTypeGroupName"],
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
        time: json["time"],
        eventDate: DateTime.parse(json["eventDate"]),
        dateReceivedFromDevice: json["DateReceivedFromDevice"],
        deviceIdentifier: json["DeviceIdentifier"],
        fleetId: json["FleetId"],
        requestStartTime: json["RequestStartTime"],
        dateCreated: json["DateCreated"],
        hdg: json["hdg"],
        alt: json["alt"],
        gX: json["gX"],
        gY: json["gY"],
        gZ: json["gZ"],
        spd: json["spd"],
        offset: json["offset"],
        locationAddress: json["LocationAddress"],
       // eventRaisedPoint: json["eventRaisedPoint"],
        tripId: json["tripId"],
        severity: json["severity"],
        eventAnalyticsFile: json["EventAnalyticsFile"],
        imageList: new List<Image>.from(json["imageList"].map((x) => Image.fromJson(x))),
        newimageList: new List<NewimageList>.from(json["newimageList"].map((x) => NewimageList.fromJson(x))),
        videoList: new List<dynamic>.from(json["videoList"].map((x) => x)),
        eventReviewStatus: json["eventReviewStatus"],
        isDismissedEvent: json["isDismissedEvent"],
        isGeneralEvent: json["isGeneralEvent"],
        isFilter: json["isFilter"],
        flag: json["Flag"],
        servercommandVideoList: new List<dynamic>.from(json["servercommandVideoList"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
       // "id": id,
        "evetId": evetId,
        "type": type,
        "displayname": displayname,
        "EventTypeGroupId": eventTypeGroupId,
        "EventTypeGroupName": eventTypeGroupName,
        "lat": lat,
        "lng": lng,
        "time": time,
        "eventDate": eventDate.toIso8601String(),
        "DateReceivedFromDevice": dateReceivedFromDevice,
        "DeviceIdentifier": deviceIdentifier,
        "FleetId": fleetId,
        "RequestStartTime": requestStartTime,
        "DateCreated": dateCreated,
        "hdg": hdg,
        "alt": alt,
        "gX": gX,
        "gY": gY,
        "gZ": gZ,
        "spd": spd,
        "offset": offset,
        "LocationAddress": locationAddress,
        //"eventRaisedPoint": eventRaisedPoint,
        "tripId": tripId,
        "severity": severity,
        "EventAnalyticsFile": eventAnalyticsFile,
        "imageList": new List<dynamic>.from(imageList.map((x) => x.toJson())),
        "newimageList": new List<dynamic>.from(newimageList.map((x) => x.toJson())),
        "videoList": new List<dynamic>.from(videoList.map((x) => x)),
        "eventReviewStatus": eventReviewStatus,
        "isDismissedEvent": isDismissedEvent,
        "isGeneralEvent": isGeneralEvent,
        "isFilter": isFilter,
        "Flag": flag,
        "servercommandVideoList": new List<dynamic>.from(servercommandVideoList.map((x) => x)),
    };
}

class Image {
    int id;
    dynamic name;
    int type;
    String url;
    dynamic blobUrl;
    //int eventId;
    int channel;
    int mediaType;

    Image({
        this.id,
        this.name,
        this.type,
        this.url,
        this.blobUrl,
       // this.eventId,
        this.channel,
        this.mediaType,
    });

    factory Image.fromJson(Map<String, dynamic> json) => new Image(
       // id: json["Id"],
        name: json["name"],
        type: json["type"],
        url: json["Url"],
        blobUrl: json["BlobUrl"],
       // eventId: json["eventId"],
        channel: json["Channel"],
        mediaType: json["mediaType"],
    );

    Map<String, dynamic> toJson() => {
       // "Id": id,
        "name": name,
        "type": type,
        "Url": url,
        "BlobUrl": blobUrl,
       // "eventId": eventId,
        "Channel": channel,
        "mediaType": mediaType,
    };
}

class NewimageList {
    int channelId;
    List<Image> images;

    NewimageList({
        this.channelId,
        this.images,
    });

    factory NewimageList.fromJson(Map<String, dynamic> json) => new NewimageList(
        channelId: json["channelId"],
        images: new List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "channelId": channelId,
        "images": new List<dynamic>.from(images.map((x) => x.toJson())),
    };
}
