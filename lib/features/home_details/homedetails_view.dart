import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wherehome/common/controllers/format_controller.dart';
import 'package:wherehome/common/inherited_http_controller.dart';
import 'package:wherehome/common/providers/user_provider.dart';
import 'package:wherehome/common/widgets/calendar_picker.dart';
import 'package:wherehome/common/widgets/dialog_error.dart';
import 'package:wherehome/data/repositories/appointment_repo.dart';
import 'package:wherehome/data/repositories/home_repo.dart';
import 'package:wherehome/features/home/widgets/home_resizable.dart';

import 'widgets/time_picker.dart';

class HomeItemView extends StatefulWidget {
  final Home homeDetails;

  const HomeItemView({super.key, required this.homeDetails});

  @override
  State<HomeItemView> createState() => _HomeItemViewState();
}

class _HomeItemViewState extends State<HomeItemView> {
  DateTime selectedDateTime = DateTime.now();
  List<bool> selectedDateBool = [false, false];

  @override
  Widget build(BuildContext context) {
    final api = HttpControllerInherited.of(context).api;
    final userProvier = Provider.of<UserProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(40)),
                  child: SizedBox(
                    height: 250,
                    width: double.maxFinite,
                    child: Image.network(
                      '${api.baseUrl}/${widget.homeDetails.imagePath[0]}',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: IconButton.filledTonal(
                    color: Colors.blue[700],
                    style: IconButton.styleFrom(
                        backgroundColor: Colors.lightBlue[300]?.withAlpha(150)),
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
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      alignment: Alignment.center,
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue.withAlpha(170),
                        border: const Border.symmetric(),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        'For ${widget.homeDetails.type}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.homeDetails.title,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                    Text(
                      '${widget.homeDetails.city}, ${widget.homeDetails.country}',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            AutoSizeText(
              minFontSize: 18,
              maxFontSize: 22,
              maxLines: 4,
              'Address: ${widget.homeDetails.address}',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                HomeProperty(
                  icon: Icons.bed_rounded,
                  measure: Text(
                    '${widget.homeDetails.rooms.toString()} room',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  iconSize: 25,
                ),
                const SizedBox(
                  width: 30,
                ),
                HomeProperty(
                  icon: Icons.grid_3x3_rounded,
                  measure: Row(
                    children: [
                      Text(
                        '${widget.homeDetails.area.toString()} m',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Transform(
                        transform: Matrix4.translationValues(0, -10, 0),
                        child: const Text(
                          '2',
                          textScaler: TextScaler.linear(0.6),
                        ),
                      )
                    ],
                  ),
                  iconSize: 25,
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Features:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
            // Features section
            if (widget.homeDetails.features!.isNotEmpty)
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemCount: widget.homeDetails.features!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisExtent: 60,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    return Card(
                      child: Center(
                        child: AutoSizeText(
                          widget.homeDetails.features![index],
                          minFontSize: 10,
                          maxFontSize: 14,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            else
              const Text('Empty list of features'),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        height: 230,
        elevation: 0.0,
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Price',
                      style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.onSecondary),
                    ),
                    Text(
                      '${formatDoublePriceWithSpaces(widget.homeDetails.price)} ${tr('currency')}',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: CalendarPickerField(
                    from: widget.homeDetails.timetable.startDayTime,
                    to: widget.homeDetails.timetable.endDayTime,
                    interval: 1,
                    onDateSelected: (DateTime date) {
                      setState(() {
                        selectedDateTime = DateTime(
                          date.year,
                          date.month,
                          date.day,
                          selectedDateTime.hour,
                          selectedDateTime.minute,
                        );
                      });
                      selectedDateBool[0] = true;
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: TimePickerField(
                    from: widget.homeDetails.timetable.startDayTime,
                    to: widget.homeDetails.timetable.endDayTime,
                    interval: widget.homeDetails.timetable.interval,
                    onTimePicked: (DateTime time) {
                      setState(() {
                        selectedDateTime = DateTime(
                          selectedDateTime.year,
                          selectedDateTime.month,
                          selectedDateTime.day,
                          time.hour,
                          time.minute,
                        );
                        selectedDateBool[1] = true;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                bool allTrue =
                    (selectedDateBool.first && selectedDateBool.last);
                if (allTrue) {
                  await api.sendPostRequest(
                    'appointment',
                    {'Authorization': 'Bearer ${userProvier.apiToken!}'},
                    Appointment(
                      home: widget.homeDetails,
                      owner: widget.homeDetails.homeOwner,
                      potentialClient: userProvier.homeOwner!.id!,
                      createdAt: DateTime.now().toIso8601String(),
                      time: selectedDateTime.toIso8601String(),
                    ).toJson(),
                    (onSuccess) {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text('Success'),
                          content:
                              const Text('Appointment created successfully.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                    (onFailure) {
                      showErrorDialog(context, onFailure.body);
                    },
                  );
                } else {
                  showErrorDialog(context, 'Not chosen date or time!');
                }
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                child: const Text(
                  'Make an appointment',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
