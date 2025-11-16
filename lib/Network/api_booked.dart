class MovieBokked {
  final String id;
  final String name;
  final List<String> seats;

  MovieBokked({
    required this.id,
    required this.name,
    required this.seats,
  });

  factory MovieBokked.fromJson(Map<String, dynamic> json) {
    return MovieBokked(
      id: json['id'] ?? "",
      name: json['name'] ?? "Unknown Title",
      seats: json['seats'] != null ? List<String>.from(json['seats']) : [],
    );
  }
}
