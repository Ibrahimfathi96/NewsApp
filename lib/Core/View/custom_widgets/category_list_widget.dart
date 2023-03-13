import 'package:flutter/material.dart';
import 'package:news/Core/View/models/category_model.dart';
import 'package:news/Providers/lang_provider.dart';
import 'package:provider/provider.dart';

class CategoryListWidget extends StatelessWidget {
CategoryMD categoryMD;
int index;
Function onCategoryClick;

CategoryListWidget({required this.categoryMD, required this.index, required this.onCategoryClick});

@override
  Widget build(BuildContext context) {
  var langProvider = Provider.of<LanguageProvider>(context);
    return InkWell(
      onTap: (){
        onCategoryClick(categoryMD);
        },
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: categoryMD.categoryBackGroundColor,
          borderRadius: BorderRadius.only(
            bottomRight:
            langProvider.currentLang == 'en' ? Radius.circular(index %2 ==0 ?0 :25) :
            Radius.circular(index %2 ==0 ?25 :0),
            bottomLeft:
            langProvider.currentLang == 'en' ? Radius.circular(index %2 ==0 ?25 :0):
            Radius.circular(index %2 ==0 ?0 :25),
            topLeft:const Radius.circular(25),
            topRight:const Radius.circular(25),
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(categoryMD.categoryImage, height: 130,width: 140, fit: BoxFit.fill,),
            const SizedBox(height: 6,),
            Text(categoryMD.categoryTitle, style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: 22),)
          ],
        ),
      ),
    );
  }
}
