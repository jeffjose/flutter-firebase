// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../stores/index.dart';

class ThemePage extends StatelessWidget {
  const ThemePage();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final body = SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Headline 1', style: textTheme.headline1),
            Text('Headline 2', style: textTheme.headline2),
            Text('Headline 3', style: textTheme.headline3),
            const SizedBox(height: 10),
            Text(
              'Subtitle1',
              style: textTheme.subtitle1,
            ),
            const SizedBox(height: 48),
            Text(
              'Body text 1',
              style: textTheme.bodyText1,
            ),
            Text(
              'Body text 2',
              style: textTheme.bodyText2,
            ),
            Text(
              'Caption',
              style: textTheme.caption,
            ),
            Text(
              'OVERLINE',
              style: textTheme.overline,
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: const AdaptiveAppBar(),
      body: body,
      floatingActionButton: FloatingActionButton(
        heroTag: 'Add',
        onPressed: () {},
        tooltip: "tooltip",
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
      ),
    );
  }
}

class AdaptiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AdaptiveAppBar({Key key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return AppBar(
      automaticallyImplyLeading: true,
      textTheme: themeData.textTheme,
      title: Text(
        "User Settings",
      ),
      bottom: null,
      actions: [
        IconButton(
          icon: const Icon(Icons.invert_colors),
          tooltip: "tooltip search",
          onPressed: () {
            store.darkMode.state = !store.darkMode.state;
          },
        ),
      ],
    );
  }
}
