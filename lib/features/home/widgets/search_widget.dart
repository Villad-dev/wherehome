import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SearchHomeWidget extends StatefulWidget {
  const SearchHomeWidget({super.key, required this.onSearch});

  final Function(String) onSearch;

  @override
  SearchWidgetState createState() => SearchWidgetState();
}

class SearchWidgetState extends State<SearchHomeWidget> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: SearchBar(
        controller: searchController,
        onTap: () {
          // Handle onTap event if needed
          // E.g., open an advanced search view
        },
        onChanged: (query) {
          searchController.text = query;
          widget.onSearch(query);
        },
        onSubmitted: (query) {
          widget.onSearch(query);
        },
        leading: const Icon(Icons.search),
        hintText: 'find_home'.tr(),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width,
          minWidth: 100,
          minHeight: 50,
          maxHeight: 100,
        ),
      ),
    );
  }
}
