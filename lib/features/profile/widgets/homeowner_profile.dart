import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wherehome/common/inherited_http_controller.dart';
import 'package:wherehome/common/providers/user_provider.dart';
import 'package:wherehome/common/widgets/dialog_error.dart';
import 'package:wherehome/data/repositories/appointment_repo.dart';
import 'package:wherehome/data/repositories/home_owner_repo.dart';
import 'package:wherehome/features/home/home_view.dart';

import 'editable_text.dart';
import 'tablecalendar_dialog.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({super.key, required this.homeOwner});

  final HomeOwner homeOwner;

  @override
  ProfileInfoState createState() => ProfileInfoState();
}

class ProfileInfoState extends State<ProfileInfo> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  late HomeOwner homeOwner = widget.homeOwner;
  late DateTime selectedDay = DateTime.now();
  late DateTime focusedDay = DateTime.now();
  bool isEditing = false;

  void toggleEditing() {
    final api = HttpControllerInherited.of(context).api;
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    late HomeOwner newHomeOwner;
    setState(() {
      isEditing = !isEditing;
    });
    if (!isEditing) {
      api.sendPutRequest('homeowner/${userProvider.homeOwner!.id}', {
        'Authorization': 'Bearer ${userProvider.apiToken}'
      }, {
        'username': nameController.text,
        'phoneNumber': phoneController.text,
        'email': emailController.text,
      }, (onSuccess) {
        newHomeOwner = HomeOwner.fromJson(jsonDecode(onSuccess.body));
        userProvider.setHomeOwner(newHomeOwner);
        setState(() {
          homeOwner = newHomeOwner;
        });
      }, (onFailure) {
        showErrorDialog(context, onFailure.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          EditableTextWidget(
            isEditing: isEditing,
            hint: 'Enter username...',
            initialValue: homeOwner.ownerName ?? 'Username',
            controller: nameController,
            textStyle: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: colorScheme.onBackground,
            ),
          ),
          const SizedBox(height: 5),
          EditableTextWidget(
            isEditing: isEditing,
            hint: 'Enter phone...',
            initialValue: '+${homeOwner.user.phoneNumber}',
            controller: phoneController,
            textStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: colorScheme.onBackground,
            ),
          ),
          const SizedBox(height: 5),
          EditableTextWidget(
            isEditing: isEditing,
            hint: 'Enter email...',
            initialValue: homeOwner.user.email ?? 'example@gmail.com',
            controller: emailController,
            textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: colorScheme.onBackground),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  toggleEditing();
                },
                child:
                    Text(isEditing ? 'save_changes'.tr() : 'edit_profile'.tr()),
              ),
              IconButton(
                onPressed: () async {
                  final app = await getAppointments();
                  showTableCalendarDialog(app);
                },
                icon: const Icon(Icons.calendar_month_rounded),
              )
            ],
          ),
          const SizedBox(height: 18),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Posted homes:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Expanded(
              child: HomesGrid(
            isGrid: true,
            homes: homeOwner.homes != null && homeOwner.homes!.isNotEmpty
                ? homeOwner.homes!
                : [],
          )),
        ],
      ),
    );
  }

  Future<Map<DateTime, List<String>>> getAppointments() async {
    final api = HttpControllerInherited.of(context).api;
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    Map<DateTime, List<String>> appointment = {};
    var appointments = [];
    await api.sendGetRequest('appointment', {
      'Authorization': 'Bearer ${userProvider.apiToken}',
      'homeOwner': userProvider.homeOwner!.id!
    }, (onSuccess) {
      final List<dynamic> json = jsonDecode(onSuccess.body);
      appointments = Appointment.parseAppointments(json);
      for (Appointment obj in appointments) {
        final String timeString = obj.time;
        final String homeTitle = obj.home.title;
        final String address = obj.home.address;
        final DateTime time = DateTime.parse(timeString);
        final String formattedTime = DateFormat('HH:mm').format(time);
        appointment.addAll({
          time: [
            'Appointment at $homeTitle located at $address at $formattedTime.'
          ]
        });
      }
    }, (onFailure) {});

    return appointment;
  }

  void showTableCalendarDialog(Map<DateTime, List<String>> events) {
    /* final events = {
      DateTime(2024, 07, 3): ['Event 1', 'Event 2'],
      DateTime(2024, 07, 6): ['Event 3'],
    };*/
    showDialog(
      context: context,
      builder: (context) {
        return TableCalendarDialog(
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
          onDaySelected: (selectedD, focusedD) {
            setState(() {
              selectedDay = selectedD;
              focusedDay = focusedD;
            });
          },
          initialFocusedDay: DateTime.now(),
          initialSelectedDay: DateTime.now(),
          events: events,
        );
      },
    );
  }
}
