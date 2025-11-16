import 'package:final_project/Network/api_services.dart';
import 'package:final_project/core/constans/app_colores.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../Network/seats.dart';
import 'package:final_project/Network/app_results.dart';

class SeatSelection extends StatefulWidget {
  final String movieId;

  final String movieName;
  final String userId;
  const SeatSelection(
      {super.key,
      required this.movieId,
      required this.movieName,
      required this.userId});

  @override
  State<SeatSelection> createState() => _SeatSelectionState();
}

class _SeatSelectionState extends State<SeatSelection> {
  List<Seat> seats = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadSeats();
  }

  Future<void> loadSeats() async {
    setState(() => isLoading = true);

    final result = await AppServices.instance.fetchSeatsByMovie(widget.movieId);

    if (result is ApiSuccess<List<Seat>>) {
      seats = result.data;
    }

    setState(() => isLoading = false);
  }

  void toggleSeat(int index) {
    setState(() {
      if (!seats[index].isBooked)
        seats[index].isSelected = !seats[index].isSelected;
    });
  }

  Future<void> checkoutSeats() async {
    final selectedSeats = seats.where((s) => s.isSelected).toList();
    if (selectedSeats.isEmpty) return;

    setState(() => isLoading = true);

    final result = await AppServices.instance.bookSeats(selectedSeats);

    final movieData = {
      "id": widget.movieId,
      "name": widget.movieName,
    };

    await AppServices.instance
        .addMovieToUser(widget.userId, movieData, selectedSeats);

    if (result is ApiSuccess<List<Seat>>) {
      seats = result.data;
      _showBookingDialog(context, widget.movieName, selectedSeats);
    } else if (result is ApiFailure<List<Seat>>) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(result.exception.message)));
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 8,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: seats.length,
                  itemBuilder: (context, index) {
                    final seat = seats[index];
                    Color color = seat.isBooked
                        ? Colors.grey
                        : seat.isSelected
                            ? Colors.blue
                            : Colors.grey[800]!;

                    return GestureDetector(
                      onTap: seat.isBooked ? null : () => toggleSeat(index),
                      child: Container(
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Center(
                            child: Text(seat.seatNumber,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12))),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: checkoutSeats,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColores.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Checkout",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}

void _showBookingDialog(
    BuildContext context, String movieName, List<Seat> selectedSeats) {
  final bookingInfo = {
    "movie": movieName,
    "seats": selectedSeats.map((s) => s.seatNumber).toList(),
    "date": DateTime.now().toString().substring(0, 16),
  };

  final qrData = bookingInfo.toString();

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text("Your ticket is ready take Screenshot"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            movieName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 8),
          Text("Your seats: ${(bookingInfo['seats'] as List).join(', ')}"),
          const SizedBox(height: 8),
          Text("Date: ${bookingInfo['date']}"),
          const SizedBox(height: 16),
          SizedBox(
            width: 180,
            height: 180,
            child: QrImageView(
              data: qrData,
              version: QrVersions.auto,
              backgroundColor: Colors.white,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Done", style: TextStyle(color: Colors.black)),
        ),
      ],
    ),
  );
}
