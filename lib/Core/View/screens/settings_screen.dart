import 'package:flutter/material.dart';
import 'package:news/Core/View/screens/home_page.dart';
import 'package:news/Core/style/theme.dart';

class SettingsScreen extends StatefulWidget {
  static const String routeName = 'settings-screen';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
          child: Image.asset(
            'assets/images/pattern.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text('Settings'),
          ),
          drawer: Drawer(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(70),
                  color: MyTheme.green,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Text(
                    'News App!',
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(fontSize: 28),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        Navigator.pushReplacementNamed(context, HomePage.routeName);
                      });
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.view_list,
                          size: 40,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          'Categories',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(color: Colors.black),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.settings,
                          size: 40,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          'Settings',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(color: Colors.black),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
