import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class Currency {
  final String name;
  final String symbol;

  Currency({required this.name, required this.symbol});
}

List<Currency> currencies = [
  Currency(name: 'Euro', symbol: '€'),
  Currency(name: 'USD', symbol: '\$'),
];

class CurrencyDropdown extends StatefulWidget {
  const CurrencyDropdown({required this.onCurrencyChange, super.key});
  final Function(Currency?) onCurrencyChange;

  @override
  State<CurrencyDropdown> createState() => _CurrencyDropdownState();
}

class _CurrencyDropdownState extends State<CurrencyDropdown> {
  late Currency selectedCurrency;

  @override
  void initState() {
    super.initState();
    selectedCurrency = currencies.first;
  }

  @override
  Widget build(BuildContext context) {
    return AppDropdown<Currency>(
      value: selectedCurrency,
      onChanged: widget.onCurrencyChange,
      isCompulsory: false,
      data: currencies.map<DropdownMenuItem<Currency>>((Currency currency) {
        return DropdownMenuItem<Currency>(
          value: currency,
          child: Row(
            children: [
              Text(currency.symbol), // Display currency symbol
              SizedBox(width: 8),
              Text(currency.name), // Display currency name
            ],
          ),
        );
      }).toList(),
      hintText: '',
      label: '',
    );
  }
}
