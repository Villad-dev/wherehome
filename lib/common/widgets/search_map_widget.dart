import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_search/mapbox_search.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

List<Suggestion> suggestions = [];

void searchAddressAndUpdateMap(String inputText) async {
  String addressQuery = inputText;

  if (addressQuery.isNotEmpty) {
    SearchBoxAPI search = SearchBoxAPI(
      limit: 6,
    );
    ApiResponse<SuggestionResponse> searchPlace = await search.getSuggestions(
      inputText,
    );
    suggestions = searchPlace.success!.suggestions;
  }
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: SearchAnchor(
        builder: (BuildContext context, SearchController controller) {
          return SearchBar(
            controller: controller,
            onTap: () {
              controller.openView();
            },
            onChanged: (String newString) {
              searchAddressAndUpdateMap(newString);
            },
            leading: const Icon(Icons.search),
            hintText: 'find_home'.tr(),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width / 2,
              minWidth: 100,
              minHeight: 50,
              maxHeight: 100,
            ),
          );
        },
        suggestionsBuilder:
            (BuildContext context, SearchController controller) {
          return List.generate(suggestions.length, (index) {
            final String item = 'item ${suggestions[index].address}';
            return ListTile(
              title: Text(item),
              onTap: () {
                setState(() {
                  controller.closeView(item);
                });
              },
            );
          });
        },
      ),
    );
  }
}
