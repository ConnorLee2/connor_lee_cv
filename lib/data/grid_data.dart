import 'dart:convert';

import 'package:connor_lee_cv/model/project.dart';
import 'package:connor_lee_cv/widgets/custom_trina_cells.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:trina_grid/trina_grid.dart';

final List<TrinaColumn> columns = [
  TrinaColumn(
    title: 'Name',
    field: 'name',
    type: TrinaColumnType.text(),
    enableColumnDrag: false,
    enableContextMenu: false,
  ),
  TrinaColumn(
    title: 'Type',
    field: 'type',
    type: TrinaColumnType.select(['Personal', 'Work', 'Learning']),
    enableColumnDrag: false,
    enableContextMenu: false,
  ),
  TrinaColumn(
    title: 'Link',
    field: 'link',
    type: TrinaColumnType.text(),
    enableColumnDrag: false,
    enableContextMenu: false,
  ),
  TrinaColumn(
    title: 'Language',
    field: 'language',
    type: TrinaColumnType.text(),
    enableColumnDrag: false,
    enableContextMenu: false,
  ),
  TrinaColumn(
    title: 'IDE',
    field: 'ide',
    type: TrinaColumnType.text(),
    enableColumnDrag: false,
    enableContextMenu: false,
  ),

  TrinaColumn(
    title: 'Detail',
    field: 'detail',
    type: TrinaColumnType.text(),
    enableColumnDrag: false,
    enableContextMenu: false,
  ),
];

Future<String> readJson() async {
  return rootBundle.loadString('assets/data/data.json');
}

Future<List<Project>> parseJson() async {
  final parsed = json.decode(await readJson());
  final parsedList = List<Project>.from(parsed.map((i) => Project.fromJson(i)));

  return parsedList;
}

Future<List<TrinaRow>> getRows(BuildContext context) async {
  final rows = <TrinaRow>[];
  final projectList = await parseJson();
  if (!context.mounted) return [];

  for (final project in projectList) {
    final row = TrinaRow(
      cells: {
        'name': TrinaCell(value: project.name),
        'type': TrinaCell(value: project.type.name.capitalize()),
        'link': trinaCellLinks(project.links),
        'language': TrinaCell(value: project.language),
        'ide': TrinaCell(value: project.ide),
        'detail': trinaCellDetail(
          context,
          project.name,
          project.detail,
          project.image,
        ),
      },
    );
    rows.add(row);
  }
  return rows;
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
