import 'package:flutter/material.dart';
import 'package:news/Core/model/category_model.dart';
import 'package:news/Core/style/theme.dart';
import 'package:news/Providers/lang_provider.dart';
import 'package:news/View/Category/category_list_widget.dart';
import 'package:news/View/home/custom_widgets/lang_bottom_sheet.dart';
import 'package:news/View/search/search_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../Category/category_widget.dart';

class HomePage extends StatefulWidget {
  static const String routeName = 'home-page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late LanguageProvider languageProvider;



  @override
  Widget build(BuildContext context) {
    List<CategoryMD> categories = [
      CategoryMD(
          categoryBackGroundColor: const Color.fromARGB(255, 201, 28, 34),
          categoryID: 'sports',
          categoryImage: 'assets/images/sports.png',
          categoryTitle: AppLocalizations.of(context)!.sports),
      CategoryMD(
          categoryBackGroundColor: const Color.fromARGB(255, 0, 62, 144),
          categoryID: 'general',
          categoryImage: 'assets/images/Politics.png',
          categoryTitle: AppLocalizations.of(context)!.general),
      CategoryMD(
          categoryBackGroundColor: const Color.fromARGB(255, 237, 30, 121),
          categoryID: 'health',
          categoryImage: 'assets/images/health.png',
          categoryTitle: AppLocalizations.of(context)!.health),
      CategoryMD(
          categoryBackGroundColor: const Color.fromARGB(255, 207, 126, 72),
          categoryID: 'business',
          categoryImage: 'assets/images/bussines.png',
          categoryTitle: AppLocalizations.of(context)!.business),
      CategoryMD(
          categoryBackGroundColor: const Color.fromARGB(255, 72, 130, 207),
          categoryID: 'technology',
          categoryImage: 'assets/images/environment.png',
          categoryTitle: AppLocalizations.of(context)!.technology),
      CategoryMD(
          categoryBackGroundColor: const Color.fromARGB(255, 242, 211, 82),
          categoryID: 'science',
          categoryImage: 'assets/images/science.png',
          categoryTitle: AppLocalizations.of(context)!.science ),
    ];
    languageProvider = Provider.of(context);
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
          backgroundColor: Colors.transparent,
            appBar: AppBar(
              actions:
              [
                if(selectedCategory != null)
                  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, SearchPage.routeName);
                      },
                      icon: const Icon(Icons.search_outlined,size: 28,)),
                )
              ],
              title: Text(
                selectedCategory == null
                    ? AppLocalizations.of(context)!.app_title
                    : selectedCategory!.categoryTitle,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            drawer: Drawer(
              child: Column(
                children: [
                  Container(
                    color: MyTheme.green,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context)!.drawer_title,
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(fontSize: 28),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedCategory = null;
                          Navigator.pop(context);
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
                            AppLocalizations.of(context)!.categories,
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
                      onTap: (){
                        showThemeButtonSheet();
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.language,
                            size: 40,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            AppLocalizations.of(context)!.lang,
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
            body: selectedCategory == null ?
            Container(
              padding: const EdgeInsets.all(6),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      AppLocalizations.of(context)!.pick_cat,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(color: Colors.black87),
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal:10),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                              childAspectRatio: 6 / 7,
                              mainAxisSpacing: 8),
                      itemBuilder: (context, index) => CategoryListWidget(
                          categoryMD: categories[index],
                          index: index,
                          onCategoryClick: onCategoryClick),
                      itemCount: categories.length,
                    ),
                  ),
                ],
              ),
            )
                : CategoryWidget(selectedCategory!),
        ),
      ],
    );
  }
  void showThemeButtonSheet() {
    showModalBottomSheet(
      context: context,
      builder: (builderContext) => LanguageBottomSheet(),
    );
  }

  CategoryMD? selectedCategory = null;

  void onCategoryClick(CategoryMD categoryMD) {
    setState(() {
      selectedCategory = categoryMD;
    });
  }
}
