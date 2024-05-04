import 'package:flutter/material.dart';

import '../../const/countries.dart';

class DropDownCountriesList extends StatefulWidget {
  const DropDownCountriesList({super.key, required BuildContext context});

  @override
  State<DropDownCountriesList> createState() => _DropDownCountriesListState();
}

class _DropDownCountriesListState extends State<DropDownCountriesList> {
  String? selectedCountry;

  @override
  void initState() {
    super.initState();
    selectedCountry = countries['Poland']?.shortName;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        itemHeight: 65,
        alignment: Alignment.center,
        style: const TextStyle(color: Colors.black),
        value: selectedCountry,
        isExpanded: false,
        isDense: false,
        //menuMaxHeight: 500,
        onChanged: (String? newValue) {
          setState(() {
            selectedCountry = newValue;
          });
        },
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        items: countries.entries.map((entry) {
          return DropdownMenuItem(
            value: entry.value.shortName,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Image.asset(
                  entry.value.flagPath,
                  width: 30,
                  height: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  entry.key,
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
                Text(
                  '+${entry.value.dialCode}',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
