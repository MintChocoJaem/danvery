import 'package:danvery/modules/orb/components/components.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utils/exception_handler.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final String content;
  final String imagePath;
  final String url;

  const MenuItem({
    super.key,
    required this.title,
    required this.content,
    required this.imagePath,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return OrbCardTile(
      title: Text(
        title,
        textAlign: TextAlign.start,
        style: themeData.textTheme.bodySmall?.copyWith(
          color: themeData.colorScheme.onSurface.withOpacity(0.8),
        ),
      ),
      content: Text(
        content,
        style: themeData.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      subContent: Align(
        alignment: Alignment.centerRight,
        child: Image.asset(
          imagePath,
          scale: 3,
        ),
      ),
      onTap: () async {
        if (!await launchUrl(Uri.parse(url))) {
          throw const ExceptionDto(
            code: 'CANNOT_LAUNCH_URL',
            message: '링크를 열 수 없어요',
          );
        }
      },
    );
  }
}

class ExtraMenu extends StatelessWidget {
  final List<MenuItem> items;

  const ExtraMenu({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final item in items)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: item,
            ),
        ],
      ),
    );
  }
}
