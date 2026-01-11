import 'package:BudgetApp/view_model.dart';
import 'package:BudgetApp/web/expense_view_web.dart';
import 'package:BudgetApp/web/login_view_web.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'mobile/expense_view.dart';
import 'mobile/login_view.dart';

class ResponsiveHandler extends HookConsumerWidget{
  @override
  Widget build(BuildContext context, WidgetRef ref){
    final viewModelProvider=ref.watch(viewmodel);
    viewModelProvider.isLogedin();

    if(viewModelProvider.isLogin==true){
      return LayoutBuilder(builder: (context, constraints){
        if(constraints.maxWidth>600){
          return ExpenseViewWeb();
        }
        else return ExpenseViewMobile();
      });
    }
    else{
      return LayoutBuilder(builder: (context,constraints){
     if(constraints.maxWidth>600){
       return LoginViewWeb();
     }
     else{
       return LoginViewMobile();
     }
      });
    }

  }
}