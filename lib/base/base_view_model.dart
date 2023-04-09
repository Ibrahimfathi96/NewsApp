import 'package:flutter/material.dart';
import 'package:news/base/base_navigator.dart';

class BaseViewModel<N extends BaseNavigator> extends ChangeNotifier{
  N? navigator;
}