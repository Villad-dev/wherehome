import 'package:flutter/material.dart';

import '../../const/countries.dart';

class DropDownCountriesList extends StatefulWidget {
  const DropDownCountriesList({
    super.key,
    required this.onCodeChanged,
  });

  final void Function(int) onCodeChanged;

  @override
  State<DropDownCountriesList> createState() => _DropDownCountriesListState();
}

class _DropDownCountriesListState extends State<DropDownCountriesList> {
  late int _codeDial;
  String _countryName = 'Poland';

  @override
  void initState() {
    super.initState();
    _codeDial = countries[_countryName]!.dialCode;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: colorScheme.onBackground),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          itemHeight: 65,
          alignment: Alignment.center,
          isExpanded: false,
          value: _countryName,
          onChanged: (newCountry) {
            if (newCountry != null) {
              setState(() {
                _countryName = newCountry;
                _codeDial = countries[newCountry]!.dialCode;
                widget.onCodeChanged(_codeDial);
              });
            }
          },
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          items: countries.entries.map((entry) {
            return DropdownMenuItem<String>(
              value: entry.key,
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
                        color: colorScheme.onBackground,
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
