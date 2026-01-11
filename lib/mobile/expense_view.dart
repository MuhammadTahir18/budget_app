import 'package:BudgetApp/components.dart';
import 'package:BudgetApp/view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
bool isLoading=true;
class ExpenseViewMobile extends HookConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProvider = ref.watch(viewmodel);
    double devicewidth = MediaQuery.of(context).size.width;
    double deviceheight = MediaQuery.of(context).size.height;
    
    useEffect(() {
      viewModelProvider.ExpenseStream();
      viewModelProvider.IncomeStream();
      return null;
    }, []);

    int totalIncom = 0;
    int totalExpence = 0;
    void Calculate() {
      for (int i = 0; i < viewModelProvider.expenseAmount.length; i++) {
        totalExpence =
            totalExpence + int.parse(viewModelProvider.expenseAmount[i]);
      }
      for (int i = 0; i < viewModelProvider.incomeAmount.length; i++) {
        totalIncom = totalIncom + int.parse(viewModelProvider.incomeAmount[i]);
      }
    }

    Calculate();
    int Leftebudget = totalIncom - totalExpence;


    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DrawerHeader(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 1.0, color: Colors.black),
                  ),
                  child: CircleAvatar(
                    radius: 180.0,
                    backgroundColor: Colors.white,
                    child: Image(
                      height: 100.0,
                      image: AssetImage("assets/logo.png"),
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              MaterialButton(
                onPressed: () async {
                  await viewModelProvider.logout();
                },
                child: Opensans(text: "Logout", size: 20, color: Colors.white),
                color: Colors.black,
                splashColor: Colors.grey,
                height: 50.0,
                minWidth: 200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                elevation: 20.0,
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () async => await launchUrl(
                      Uri.parse("https//instagram.com/tomcruise"),
                    ),
                    icon: SvgPicture.asset(
                      "assets/instagram.svg",
                      color: Colors.black,
                      width: 35.0,
                    ),
                  ),
                  IconButton(
                    onPressed: () async => await launchUrl(
                      Uri.parse("https//twitter.com/tomcruise"),
                    ),
                    icon: SvgPicture.asset(
                      "assets/twitter.svg",
                      color: Colors.black,
                      width: 35.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Poppins(text: "Dashboard", size: 20.0, color: Colors.white),
          iconTheme: IconThemeData(color: Colors.white, size: 30.0),
          backgroundColor: Colors.black,
          actions: [
            GestureDetector(
                onTap: ()async{
             await     viewModelProvider.reset();
                },
                child: Icon(Icons.refresh))
          ],
        ),
        body: ListView(
          children: [
            SizedBox(height: 40.0),
            Column(
              children: [
                Container(
                  height: 240.0,
                  width: devicewidth / 1.5,
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Poppins(
                            text: "Budget Left",
                            size: 14.0,
                            color: Colors.white,
                          ),
                          Poppins(
                            text: "Total  Expense",
                            size: 14.0,
                            color: Colors.white,
                          ),
                          Poppins(
                            text: "Total  income",
                            size: 14.0,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      RotatedBox(
                        quarterTurns: 1,
                        child: Divider(
                          indent: 40.0,
                          endIndent: 40.0,
                          color: Colors.grey,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Poppins(text: Leftebudget.toString(), size: 14.0,color: Colors.white,),
                          Poppins(text: totalExpence.toString(), size: 14.0,color: Colors.white,),
                          Poppins(text: totalIncom.toString(), size: 14.0,color: Colors.white,),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 40.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(height: 50.0,
                    width: 155.0,
                      child: MaterialButton(
                          onPressed: ()async{
                    await    viewModelProvider.addExpense(context);
                          },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.add, color: Colors.white,size: 15.0,),
                            Opensans(text: "Add Expense", size: 14.0,color: Colors.white,)

                          ],
                        ),
                        splashColor: Colors.grey,
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)
                        ),
                      ),
                    ),
                    SizedBox(width: 20.0,),
                    SizedBox(height: 50.0,
                      width: 155.0,
                      child: MaterialButton(
                        onPressed: ()async{
                      await    viewModelProvider.addIncome(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.add, color: Colors.white,size: 15.0,),
                            Opensans(text: "Add Incom", size: 14.0,color: Colors.white,)

                          ],
                        ),
                        splashColor: Colors.grey,
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.0,),
                Padding(padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Opensans(text: "Expanse", size: 15.0),
                        Container(
                          padding: EdgeInsets.all(7.0),
                          height: 210.0,
                          width: 180.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15.0),
                            ),
                            border: Border.all(color: Colors.black,width: 1.0),

                          ),
                          child: ListView.builder(
                            itemCount: viewModelProvider.expenseAmount.length,
                              itemBuilder: (BuildContext context,int  index){
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Poppins(text: viewModelProvider.expenseName[index], size: 15.0),
                                   Align(
                                     alignment: Alignment.centerRight,
                                     child: Poppins(text: viewModelProvider.expenseAmount[index], size: 12.0),

                                   ),
                                  ],
                                );
                              },

                          ),

                        )
                      ],
                    ),
                    Column(
                      children: [
                        Opensans(text: "Income", size: 15.0),
                        Container(
                          padding: EdgeInsets.all(7.0),
                          height: 210.0,
                          width: 180.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15.0),
                            ),
                            border: Border.all(color: Colors.black,width: 1.0),

                          ),
                          child: ListView.builder(
                            itemCount: viewModelProvider.incomeAmount.length,
                            itemBuilder: (BuildContext context,int  index){
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Poppins(text: viewModelProvider.incomeName[index], size: 15.0),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Poppins(text: viewModelProvider.incomeAmount[index], size: 12.0),

                                  ),
                                ],
                              );
                            },

                          ),

                        )
                      ],
                    ),

                  ],
                ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
