import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components.dart';
import '../view_model.dart';

bool isLoading = true;

class ExpenseViewWeb extends HookConsumerWidget {
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
        appBar: AppBar(
          centerTitle: true,
          title: Poppins(text: "Dashboard", size: 20.0, color: Colors.white),
          iconTheme: IconThemeData(color: Colors.white, size: 30.0),
          backgroundColor: Colors.blue,
          actions: [
            GestureDetector(
              onTap: () async {
                await viewModelProvider.reset();
              },
              child: Icon(Icons.refresh),
            ),
          ],
        ),
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DrawerHeader(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 1.0, color: Colors.blue),
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
                color: Colors.blue,
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
                      color: Colors.blue,
                      width: 35.0,
                    ),
                  ),
                  IconButton(
                    onPressed: () async => await launchUrl(
                      Uri.parse("https//twitter.com/tomcruise"),
                    ),
                    icon: SvgPicture.asset(
                      "assets/twitter.svg",
                      color: Colors.blue,
                      width: 35.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: ListView(
          children: [
            SizedBox(height: 50.0),
            //// image + addincome, + total calculations
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage("assets/login_image.png"),
                  width: deviceheight / 1.6,
                ),
                SizedBox(
                  height: 300.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 45.0,
                        width: 160.0,
                        child: MaterialButton(
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          splashColor: Colors.grey,
                          onPressed: () async {
                            await viewModelProvider.addExpense(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.add, color: Colors.white, size: 14.0),
                              Opensans(
                                text: "Add Expense",
                                size: 14.0,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      SizedBox(
                        height: 45.0,
                        width: 160.0,
                        child: MaterialButton(
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          splashColor: Colors.grey,
                          onPressed: () async {
                            await viewModelProvider.addIncome(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.add, color: Colors.white, size: 14.0),
                              Opensans(
                                text: "Add Income",
                                size: 14.0,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Container(
                      // height: 200,
                        width: 260.0,
                        padding: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(
                            Radius.circular(25.0),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Poppins(
                                  text: 'Budget Left',
                                  size: 17.0,
                                  color: Colors.white,
                                ),
                                Poppins(
                                  text: 'Total Budget',
                                  size: 17.0,
                                  color: Colors.white,
                                ),
                                Poppins(
                                  text: 'Total Income',
                                  size: 17.0,
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
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Poppins(
                                  text: Leftebudget.toString(),
                                  size: 17.0,
                                  color: Colors.white,
                                ),
                                Poppins(
                                  text: totalExpence.toString(),
                                  size: 17.0,
                                  color: Colors.white,
                                ),
                                Poppins(
                                  text: totalIncom.toString(),
                                  size: 17.0,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.0),
            Divider(
              indent: devicewidth / 4,
              endIndent: devicewidth / 4,
              thickness: 3.0,
            ),
            SizedBox(height: 50.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ////expense
                Container(
                  width: 260.0,
                  height: 320.0,
                  padding: EdgeInsets.all(15.0),

                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: Poppins(
                          text: "Expenses",
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                      Divider(
                        indent: 30.0,
                        endIndent: 30.0,
                        color: Colors.white,
                      ),
                      SizedBox(height: 15.0),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        height: 210,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                          border: Border.all(width: 1.0, color: Colors.white),
                        ),
                        child: ListView.builder(
                          itemCount: viewModelProvider.expenseAmount.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Poppins(
                                  text: viewModelProvider.expenseName[index],
                                  size: 15.0,
                                  color: Colors.white,
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Poppins(
                                    text:
                                        viewModelProvider.expenseAmount[index],
                                    size: 15.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                ///incomes
                Container(
                  width: 260.0,
                  height: 320.0,
                  padding: EdgeInsets.all(15.0),

                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: Poppins(
                          text: "Incomes",
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                      Divider(
                        indent: 30.0,
                        endIndent: 30.0,
                        color: Colors.white,
                      ),
                      SizedBox(height: 15.0),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        height: 210,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                          border: Border.all(width: 1.0, color: Colors.white),
                        ),
                        child: ListView.builder(
                          itemCount: viewModelProvider.incomeAmount.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Poppins(
                                  text: viewModelProvider.incomeName[index],
                                  size: 15.0,
                                  color: Colors.white,
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Poppins(
                                    text:
                                    viewModelProvider.incomeAmount[index],
                                    size: 15.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
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
