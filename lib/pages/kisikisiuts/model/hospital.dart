class Hospital {
  final String title;
  final String image;
  final String desc;
  final double latitude;
  final double longitude;

  Hospital({
    required this.title,
    required this.image,
    required this.desc,
    required this.latitude,
    required this.longitude,
  });
  factory Hospital.fromJson(Map<String, dynamic> json) {
    return Hospital(
      title: json['title'],
      image: json['image'],
      desc: json['desc'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
    );
  }
}