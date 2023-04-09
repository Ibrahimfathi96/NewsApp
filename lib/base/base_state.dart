import 'package:flutter/material.dart';
import 'package:news/Core/style/dialog%20utils.dart';
import 'package:news/base/base_navigator.dart';
import 'package:news/base/base_view_model.dart';


abstract class BaseState<T extends StatefulWidget,VM extends BaseViewModel>
    extends State<T> implements BaseNavigator{
  late VM viewModel;//VM(): not valid syntax//late because it template parameter
  VM initViewModel();

  @override
  void initState() {
    super.initState();
    viewModel = initViewModel();
    viewModel.navigator = this;
  }
  @override
  void hideDialog() {
    DialogUtils.hideDialog(context);
  }

  @override
  void showMessage(String message, {bool isDismissible = true,
    VoidCallback? posAction, VoidCallback? negAction,
    String? posActionTitle, String? negActionTitle, String? posMessage,
    String? negMessage}) {
    DialogUtils.showMessage(context, message,
        isDismissible: isDismissible,
        posAction: posAction,
        posActionTitle: posActionTitle,
        negAction: negAction,
        negActionTitle: negActionTitle,
        negMessage: negMessage);
  }

  @override
  void showProgressDialog(String message, {bool isDismissible = true}) {
    DialogUtils.showProgressDialog(context, message,
        isDismissible: isDismissible);
  }

}