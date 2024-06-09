import 'package:flutter/material.dart';
import 'package:wherehome/common/widgets/time_picker.dart';
import 'package:wherehome/data/models/home.dart';

class HomeItemView extends StatelessWidget {
  final Home homeDetails;

  const HomeItemView({super.key, required this.homeDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(40)),
                  child: Image.asset(
                    homeDetails.imagePath,
                    fit: BoxFit.fill,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: IconButton.filledTonal(
                    color: Colors.lightBlue[300],
                    style: IconButton.styleFrom(
                        backgroundColor: Colors.lightBlue[300]?.withAlpha(100)),
                    iconSize: 25,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton.filled(
                    color: const Color.fromARGB(255, 220, 20, 60),
                    style: IconButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(100, 220, 20, 60)),
                    iconSize: 25,
                    onPressed: () {
                      //TODO
                    },
                    icon: const Icon(
                      Icons.favorite_rounded,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Tittle',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            /*  CalendarDatePicker(
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 60)),
              onDateChanged: (day) {},
            ),*/
            TimePickerField(
              from: DateTime.now(),
              to: DateTime.now().add(
                const Duration(hours: 5),
              ),
              interval: 30,
            ),
          ],
        ),
      ),
    );
  }
}
