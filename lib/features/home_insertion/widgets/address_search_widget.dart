import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mapbox_search/mapbox_search.dart';

class AddressSearchWidget extends StatefulWidget {
  final Function(MapBoxPlace) onSelected;

  const AddressSearchWidget({super.key, required this.onSelected});

  @override
  AddressSearchWidgetState createState() => AddressSearchWidgetState();
}

class AddressSearchWidgetState extends State<AddressSearchWidget> {
  final TextEditingController _controller = TextEditingController();
  final delayer = Delayer(milliseconds: 1000);
  List<MapBoxPlace> _suggestions = [];
  bool _isSearching = false;

  final placesService = GeoCoding(
    types: [PlaceType.address],
    limit: 3,
  );

  void _searchPlaces(String query) async {
    if (query.isEmpty) {
      setState(() {
        _suggestions = [];
      });
      return;
    }
    setState(() {
      _isSearching = true;
    });
    final places = await placesService.getPlaces(query);
    setState(() {
      _isSearching = false;
      _suggestions = places.success ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          onChanged: (input) {
            delayer.run(() => _searchPlaces(input));
          },
          decoration: const InputDecoration(
            hintText: 'Enter an address...',
          ),
        ),
        if (_isSearching) const CircularProgressIndicator(),
        if (!_isSearching && _suggestions.isNotEmpty)
          ListView.builder(
            shrinkWrap: true,
            itemCount: _suggestions.length,
            itemBuilder: (context, index) {
              final suggestion = _suggestions[index];
              return ListTile(
                title: Text(suggestion.placeName ?? 'No suggestions available'),
                onTap: () {
                  _controller.text = suggestion.placeName ?? '';
                  setState(() {
                    _suggestions = [];
                    _isSearching = false;
                    widget.onSelected(suggestion);
                  });
                },
              );
            },
          ),
        /*if (!_isSearching &&
            _suggestions.isEmpty &&
            _controller.text.isNotEmpty)
          Container(),
        */ /*ListTile(
            title: Text('No suggestions available'),
          ),*/
      ],
    );
  }
}

class Delayer {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  Delayer({required this.milliseconds});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
