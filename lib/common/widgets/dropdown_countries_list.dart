import 'package:flutter/material.dart';

import '../../const/countries.dart';

class DropDownCountriesList extends StatefulWidget {
  const DropDownCountriesList({super.key});

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
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          itemHeight: 65,
          alignment: Alignment.center,
          value: selectedCountry,
          isExpanded: false,
          isDense: false,
          onChanged: (String? newValue) {
            setState(() {
              selectedCountry = newValue;
            });
          },
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          items: countries.entries.map((entry) {
            return DropdownMenuItem(
              value: entry.value.shortName,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Image.asset(
                      entry.value.flagPath,
                      width: 30,
                      height: 20,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '+${entry.value.dialCode}',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
