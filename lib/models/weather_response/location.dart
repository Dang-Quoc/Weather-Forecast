class Location {
  final String name;
  final String localtime;

  Location({required this.name, required this.localtime});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'],
      localtime: json['localtime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'localtime': localtime,
    };
  }
}
