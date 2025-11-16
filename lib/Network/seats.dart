class Seat {
  final String id;
  final String seatNumber;
  final String movieId;
  bool isBooked;
  bool isSelected;

  Seat({
    required this.id,
    required this.seatNumber,
    required this.movieId,
    this.isBooked = false,
    this.isSelected = false,
  });

  factory Seat.fromJson(Map<String, dynamic> json) {
    return Seat(
      id: json['id'] ?? '',
      seatNumber: json['seatNumber'] ?? 'A1',
      movieId: json['movieId'] ?? '',
      isBooked: json['isBooked'] ?? false,
      isSelected: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'seatNumber': seatNumber,
      'movieId': movieId,
      'isBooked': isBooked,
    };
  }
}
