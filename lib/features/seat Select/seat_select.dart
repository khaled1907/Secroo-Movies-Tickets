import 'package:final_project/Network/api_respone.dart';
import 'package:final_project/features/seat%20Select/widgets/drop_down.dart';
import 'package:final_project/features/seat%20Select/widgets/select_seats.dart';
import 'package:final_project/sharedPrefrences/shared_prefrences.dart';
import 'package:flutter/material.dart';

class SelectSeatsScreen extends StatefulWidget {
  const SelectSeatsScreen({super.key, required this.movie});
  final Movie movie;
  @override
  State<SelectSeatsScreen> createState() => _SelectSeatsScreenState();
}

class _SelectSeatsScreenState extends State<SelectSeatsScreen> {
  Map<String, dynamic>? userDetails;
  bool isLoading = true;
  @override
  void initState() {
    checkLoginStatus();
    super.initState();
  }

  Future<void> checkLoginStatus() async {
    userDetails = await SharedPreferencesClass.getUserDetails();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => {
            Navigator.pop(context),
          },
        ),
        centerTitle: true,
        title: const Text(
          "Select Seats",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              "Cinema",
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 8),
            CustomDropdown(hintText: "Nasr City", items: [
              "Nasr City",
            ]),
            const SizedBox(height: 20),
            Row(
              children: const [
                Expanded(
                  child: CustomDropdown(
                    hintText: "02 Nov 2025",
                    items: [
                      "06 Dec 2025",
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: CustomDropdown(
                    hintText: "11.00 PM",
                    items: [
                      "11.00 PM",
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Center(
                  child: SeatSelection(
                userId: (userDetails?['id']).toString(),
                movieName: widget.movie.title,
                movieId: (widget.movie.id).toString(),
              )),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
