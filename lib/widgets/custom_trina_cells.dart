import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trina_grid/trina_grid.dart';
import 'package:url_launcher/url_launcher.dart';

TrinaCell trinaCellLinks(List<String> links) {
  return TrinaCell(
    value: '1234567890',
    renderer: (rendererContext) {
      if (links.first == 'N/A') {
        return Container();
      }
      final rowChildren = <Widget>[];
      for (final link in links) {
        final icon = IconButton(
          onPressed: () async {
            final Uri url = Uri.parse(link);
            if (!await launchUrl(url)) {
              throw Exception('Could not launch $url');
            }
          },
          icon: getCorrectLinkIcon(link),
        );
        rowChildren.add(icon);
      }

      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: rowChildren,
      );
    },
  );
}

TrinaCell trinaCellDetail(
  BuildContext context,
  String name,
  String detail,
  String image,
) {
  return TrinaCell(
    value: '12345',
    renderer: (rendererContext) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () => showAlertDialog(context, name, detail, image),
            icon: const Icon(Icons.info),
          ),
        ],
      );
    },
  );
}

FaIcon getCorrectLinkIcon(String link) {
  if (link.contains('apps.apple.com')) {
    return const FaIcon(FontAwesomeIcons.appStoreIos);
  }
  if (link.contains('play.google.com')) {
    return const FaIcon(FontAwesomeIcons.googlePlay);
  }
  if (link.contains('github.com')) {
    return const FaIcon(FontAwesomeIcons.github);
  }

  return const FaIcon(FontAwesomeIcons.question);
}

void showAlertDialog(
  BuildContext context,
  String name,
  String detail,
  String image,
) {
  final list = <Widget>[];

  if (image.trim().isNotEmpty) {
    final imageWidget = Expanded(
      child: Image.asset(
        image,
        height: MediaQuery.of(context).size.height * 0.55,
        width: MediaQuery.of(context).size.width * 0.55,
      ),
    );
    list.add(imageWidget);
  }

  if (detail.trim().isNotEmpty) {
    final text = Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Text(detail),
      ),
    );
    list.add(text);
  }

  final Widget closeButton = TextButton(
    onPressed: () => Navigator.pop(context),
    child: const Text('Close'),
  );

  final AlertDialog dialog = AlertDialog.adaptive(
    title: Text(name, textAlign: TextAlign.center),
    content: Row(mainAxisSize: MainAxisSize.min, children: list),
    actions: [closeButton],
  );

  showDialog(
    context: context,
    builder: (context) {
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.55,
        child: dialog,
      );
    },
  );
}
