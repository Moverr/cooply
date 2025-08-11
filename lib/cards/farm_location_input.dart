

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/dtos/address.dart';
import '../services/nominatim_service.dart';

class FarmLocationInput extends StatefulWidget{
  final TextEditingController controller;
  final void Function(Address address)? onLocationSelected;


  const FarmLocationInput({
    Key? key,
    required this.controller,
    this.onLocationSelected,
  }) : super(key: key);


  @override
  State<StatefulWidget> createState() =>   _FarmLocationInputState();

}
class _FarmLocationInputState extends State<FarmLocationInput> {

  List<Map<String, dynamic>> _suggestions = [];
  Timer? _debounce;




  void _onChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (query.isEmpty) {
        setState(() => _suggestions = []);
        return;
      }

      final results = await NominatimService.search(query);
      setState(() {
        _suggestions = results;
      });
    });
  }


  void _onSuggestionTap(Map<String, dynamic> place) {
    widget.controller.text = place['display_name'] ?? '';
    _suggestions = [];
    final String userAddress = widget.controller.text;


    Address selectedAddress = _parseAddress(place,userAddress);

    // Pass the full Address object to callback
    widget.onLocationSelected?.call(selectedAddress);

    setState(() {});

  }


  Address _parseAddress(Map<String, dynamic> place,String addressText) {
    final addressData = place['address'] ?? {};

    String street = addressData['road'] ?? '';
    String city = addressData['city'] ?? addressData['town'] ?? addressData['village'] ?? '';
    String state = addressData['state'] ?? '';
    String zipCode = addressData['postcode'] ?? '';

    double latitude = double.tryParse(place['lat'] ?? '') ?? 0.0;
    double longitude = double.tryParse(place['lon'] ?? '') ?? 0.0;

    return Address(
      addressLevel: 'PRIMARY',
      street: street,
      city: city,
      state: state,
      zipCode: zipCode,
      latitude: latitude,
      longitude: longitude,
      details: addressText,
    );
  }




  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
            labelText: 'Farm Location',
            border: const OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter farm location';
            }
            return null;
          },
          onChanged: _onChanged,
        ),
        if (_suggestions.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 4),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(4),
              color: Colors.white,
            ),
            height: 150,
            child: ListView.builder(
              itemCount: _suggestions.length,
              itemBuilder: (context, index) {
                final place = _suggestions[index];
                return ListTile(
                  title: Text(place['display_name'] ?? ''),
                  onTap: () => _onSuggestionTap(place),
                );
              },
            ),
          ),
      ],
    );
  }

  
}