

import 'dart:convert';

List<CityModel> cityModelFromJson(String str) => List<CityModel>.from(json.decode(str).map((x) => CityModel.fromJson(x)));

String cityModelToJson(List<CityModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CityModel {
    String? city;
    String? lat;
    String? lng;
    Country? country;
    Iso2? iso2;
    String? adminName;
    Capital? capital;
    String? population;
    String? populationProper;

    CityModel({
        this.city,
        this.lat,
        this.lng,
        this.country,
        this.iso2,
        this.adminName,
        this.capital,
        this.population,
        this.populationProper,
    });

    factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        city: json["city"],
        lat: json["lat"],
        lng: json["lng"],
        country: countryValues.map[json["country"]]!,
        iso2: iso2Values.map[json["iso2"]]!,
        adminName: json["admin_name"],
        capital: capitalValues.map[json["capital"]]!,
        population: json["population"],
        populationProper: json["population_proper"],
    );

    Map<String, dynamic> toJson() => {
        "city": city,
        "lat": lat,
        "lng": lng,
        "country": countryValues.reverse[country],
        "iso2": iso2Values.reverse[iso2],
        "admin_name": adminName,
        "capital": capitalValues.reverse[capital],
        "population": population,
        "population_proper": populationProper,
    };
}

enum Capital {
    ADMIN,
    MINOR,
    PRIMARY
}

final capitalValues = EnumValues({
    "admin": Capital.ADMIN,
    "minor": Capital.MINOR,
    "primary": Capital.PRIMARY
});

enum Country {
    NIGERIA
}

final countryValues = EnumValues({
    "Nigeria": Country.NIGERIA
});

enum Iso2 {
    NG
}

final iso2Values = EnumValues({
    "NG": Iso2.NG
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
