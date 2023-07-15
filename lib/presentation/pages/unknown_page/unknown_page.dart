import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/core/utils/my_colors.dart';
import 'package:todo/core/utils/my_text_styles.dart';

class UnknownPage extends StatelessWidget {
  const UnknownPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: MyColors.labelPrimary),
        title: Text(
          AppLocalizations.of(context)!.unknownPage,
          style: MyTextStyles.title,
        ),
      ),
    );
  }
}
