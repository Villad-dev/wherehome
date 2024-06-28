import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wherehome/common/controllers/format_controller.dart';
import 'package:wherehome/common/controllers/http_controller.dart';
import 'package:wherehome/common/inherited_http_controller.dart';
import 'package:wherehome/common/providers/user_provider.dart';
import 'package:wherehome/data/repositories/home_repo.dart';
import 'package:wherehome/features/home_details/homedetails_view.dart';

class HomeWidget extends StatefulWidget {
  final Home homeDataSet;
  final int elementHeight;
  final int imageHeight;

  const HomeWidget({
    super.key,
    required this.homeDataSet,
    required this.elementHeight,
    required this.imageHeight,
  });

  @override
  HomeWidgetState createState() => HomeWidgetState();
}

class HomeWidgetState extends State<HomeWidget> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> addToFavourites(Home chosen, HttpController api) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    if (userProvider.homeOwner != null) {
      await api.sendPutRequest(
          'homeowner/${userProvider.homeOwner!.id}',
          {
            'Authorization': 'Bearer ${userProvider.apiToken}',
            'list': 'favourite',
          },
          chosen.toJson(),
          (success) {},
          (failure) {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final colortheme = Theme.of(context);
    final user = Provider.of<UserProvider>(context, listen: false);
    final api = HttpControllerInherited.of(context).api;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeItemView(
                homeDetails: widget.homeDataSet,
              ),
            ));
      },
      child: Container(
        height: widget.elementHeight.toDouble(),
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          color: colortheme.colorScheme.tertiaryContainer,
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          border: Border.all(
            width: 1.0,
            color: colortheme.primaryColor,
            style: BorderStyle.solid,
          ),
          boxShadow: [
            BoxShadow(
              color: colortheme.colorScheme.primary.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // Shadow position
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.maxFinite,
                  height: widget.imageHeight.toDouble(),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                    child: Image.network(
                      '${api.baseUrl}/${widget.homeDataSet.imagePath[0]}',
                      fit: BoxFit.fill,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child; // Return the child (image) if the loading is complete
                        } else {
                          return const Center(
                            child: SizedBox(
                              width: 40.0,
                              height: 40.0,
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
                user.user != null
                    ? Positioned(
                        left: 8,
                        top: 8,
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: colortheme.hintColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: IconButton(
                            onPressed: () {
                              addToFavourites(widget.homeDataSet, api);
                            },
                            icon: Icon(
                              size: 16,
                              Icons.favorite,
                              color: colortheme.primaryColor,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          widget.homeDataSet.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.homeDataSet.type,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  AutoSizeText(
                    minFontSize: 14,
                    maxFontSize: 18,
                    maxLines: 1,
                    '${formatDoublePriceWithSpaces(widget.homeDataSet.price)} ${tr('currency')}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ), //
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.location_on_outlined,
                          size: 25,
                        ),
                      ),
                      Expanded(
                        child: AutoSizeText(
                          textAlign: TextAlign.right,
                          "${widget.homeDataSet.address} ${widget.homeDataSet.addressNum}",
                          maxFontSize: 12,
                          minFontSize: 10,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis, // Handle overflow
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HomeProperty(
                        icon: Icons.bed_rounded,
                        measure: Text(
                            '${widget.homeDataSet.rooms.toString()} rooms'),
                        iconSize: 20,
                      ),
                      /* const HomeProperty(
                        icon: Icons.bathtub_outlined,
                        measure: Text('2 '),
                      ),
                      const HomeProperty(
                        icon: Icons.kitchen_rounded,
                        measure: Text('2 '),
                      ),*/
                      HomeProperty(
                        icon: Icons.grid_3x3_rounded,
                        measure: Row(
                          children: [
                            Text(
                              '${widget.homeDataSet.area.toString()} m',
                            ),
                            Transform(
                              transform: Matrix4.translationValues(0, -6, 0),
                              child: const Text(
                                '2',
                                textScaler: TextScaler.linear(0.5),
                              ),
                            )
                          ],
                        ),
                        iconSize: 20,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeProperty extends StatelessWidget {
  const HomeProperty(
      {super.key,
      required this.icon,
      required this.measure,
      required this.iconSize});

  final Widget measure;
  final IconData icon;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: iconSize,
        ),
        measure,
      ],
    );
  }
}
