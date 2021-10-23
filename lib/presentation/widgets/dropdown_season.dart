import 'package:ditonton/data/models/tv/tv_season_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DropdownSeason extends StatelessWidget {
  final int selectedSeason;
  final List<SeasonModel> seasons;
  final Function onSelected;

  DropdownSeason({ 
      required this.selectedSeason, 
      required this.seasons,
      required this.onSelected
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: EdgeInsets.symmetric(vertical: 0.3, horizontal: 8),
      decoration: BoxDecoration(
          color: Theme.of(context).secondaryHeaderColor,
          borderRadius: BorderRadius.circular(8)),
      child: DropdownButton<String>(
        onChanged: (value) {
          onSelected(int.parse(value.toString()));
        },
        value: selectedSeason.toString(),
        // Hide the default underline
        underline: Container(),
        hint: Center(
            child: Text(
          'Select Season',
          style: TextStyle(color: Colors.white),
        )),
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.white,
        ),
        isExpanded: true,

        // The list of options
        items: seasons
            .map((e) => DropdownMenuItem(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      e.name ?? "-",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  value: e.seasonNumber.toString(),
                ))
            .toList(),

        // Customize the selected item
        selectedItemBuilder: (BuildContext context) => seasons
            .map((e) => Center(
                  child: Text(
                    e.name ?? "",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ))
            .toList(),
      ),
    );
  }
}