import 'package:connor_lee_cv/data/grid_data.dart';
import 'package:flutter/material.dart';
import 'package:trina_grid/trina_grid.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connor Lee'),
        bottom: const PreferredSize(
          preferredSize: Size.zero,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                'A collection of apps that I have worked on over the years.',
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: getRows(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: TrinaGrid(
                columns: columns,
                rows: snapshot.data!,
                mode: TrinaGridMode.readOnly,
                onLoaded: (event) {
                  for (var col in event.stateManager.columns) {
                    event.stateManager.autoFitColumn(context, col);
                  }
                },
                rowColorCallback: (rowColorContext) {
                  switch (rowColorContext.row.cells.entries
                      .elementAt(3)
                      .value
                      .value) {
                    case 'Flutter/Dart':
                      return const Color(0xff9fc5e8);
                    case 'Swift':
                      return const Color(0xfff9cb9c);
                    case 'Java':
                      return const Color(0xffb6d7a8);
                    default:
                      return Colors.white;
                  }
                },
              ),
            );
          } else {
            return const Center(child: Text('No data'));
          }
        },
      ),
    );
  }
}
