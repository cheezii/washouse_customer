// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';

import 'package:washouse_customer/components/constants/color_constants.dart';
import 'package:washouse_customer/components/constants/text_constants.dart';

class SearchBar extends StatefulWidget {
  final Function(String z) onChanged;
  const SearchBar({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool showSearchField = false;
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  final searchScaffoldKey = GlobalKey<ScaffoldState>();
  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 1),
      alignment: showSearchField ? Alignment.topCenter : Alignment.topRight,
      padding: const EdgeInsets.only(top: 20, bottom: 20, left: 16, right: 16),
      child: Material(
        elevation: showSearchField ? 12 : 4,
        borderRadius: BorderRadius.circular(360),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 1),
          width: showSearchField ? 400 : 50,
          decoration: BoxDecoration(
            color: showSearchField ? kBackgroundColor : kPrimaryColor,
            borderRadius: BorderRadius.circular(360),
          ),
          child: showSearchField ? searchField() : searchButton(),
        ),
      ),
    );
  }

  Widget searchField() {
    return AnimatedOpacity(
      opacity: showSearchField ? 1 : 0,
      duration: const Duration(microseconds: 3),
      child: TextFormField(
        onChanged: widget.onChanged,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'Tìm vị trí...',
          border: InputBorder.none,
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Icon(Icons.search_rounded),
          ),
          suffixIcon: clearButton(),
        ),
      ),
    );
  }

  Widget searchButton() {
    return IconButton(
      autofocus: true,
      onPressed: () {
        if (mounted) setState(() => showSearchField = true);
        handleSearchButton;
      },
      icon: const Icon(
        Icons.search_rounded,
        color: Colors.white,
      ),
      tooltip: 'Tìm kiếm',
    );
  }

  Widget clearButton() {
    return AnimatedOpacity(
      opacity: showSearchField ? 1 : 0,
      duration: const Duration(microseconds: 3),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: kPrimaryColor.withOpacity(.6),
          borderRadius: BorderRadius.circular(360),
        ),
        child: IconButton(
          onPressed: () {
            if (mounted) setState(() => showSearchField = false);
            widget.onChanged('');
            FocusScope.of(context).unfocus();
          },
          icon: const Icon(
            Icons.close_rounded,
            color: Colors.white,
          ),
          tooltip: 'Tìm kiếm',
        ),
      ),
    );
  }

  Future<void> handleSearchButton() async {
    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      apiKey: apiKey,
      mode: Mode.overlay, // Mode.fullscreen
      language: "vi",
      onError: onError,
      decoration: InputDecoration(
        hintText: 'Tìm vị trí...',
        border: InputBorder.none,
        prefixIcon: const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Icon(Icons.search_rounded),
        ),
        suffixIcon: clearButton(),
      ),
      components: [Component(Component.country, "fr")],
    );

    displayPrediction(p!, homeScaffoldKey.currentState!);
  }

  void onError(PlacesAutocompleteResponse response) {
    homeScaffoldKey.currentState!.showBottomSheet((BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(16),
        height: 90,
        decoration: const BoxDecoration(
          color: Color(0xffc72c41),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Oops',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              Text(
                response.errorMessage!,
                style: TextStyle(fontSize: 12, color: Colors.white),
                maxLines: 2,
                overflow: TextOverflow.clip,
              )
            ],
          ),
        ),
      );
    });
  }

  Future<void> displayPrediction(Prediction p, ScaffoldState scaffold) async {
    if (p != null) {
      // get detail (lat/lng)
      GoogleMapsPlaces _places = GoogleMapsPlaces(
        apiKey: apiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders(),
      );
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId!);
      final lat = detail.result.geometry?.location.lat;
      final lng = detail.result.geometry?.location.lng;
    }
  }
}
