import 'package:flutter/material.dart';
import 'package:ummaku/style/theme.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            ThemeService().switchTheme();
          },
          child: Text(
            'CHANGE MODE',
            style: theme.textTheme.headline5,
          ),
        ),
      ),
    );
  }
}
