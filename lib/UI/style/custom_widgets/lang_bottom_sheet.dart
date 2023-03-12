import 'package:flutter/material.dart';
import 'package:news/Providers/lang_provider.dart';
import 'package:provider/provider.dart';


class LanguageBottomSheet extends StatefulWidget {
  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var languageProviders = Provider.of<LanguageProvider>(context);
    return Container(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              languageProviders.getLang('en');
            },
            child: languageProviders.currentLang == 'en'
                ? getSelectedIcon('English')
                : getUnSelectedIcon('English'),
          ),
          const SizedBox(
            height: 12,
          ),
          InkWell(
            onTap: () {
              languageProviders.getLang('ar');
            },
            child: languageProviders.currentLang == 'ar'
                ? getSelectedIcon('العربية')
                : getUnSelectedIcon('العربية'),
          ),
        ],
      ),
    );
  }

  Widget getSelectedIcon(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headlineLarge!.copyWith(color: Colors.black),
        ),
        Icon(
          Icons.check,
          size: 30,
        )
      ],
    );
  }

  Widget getUnSelectedIcon(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.black),
    );
  }
}
