import 'package:flutter/material.dart';

import '../services/api_service.dart';
import '../utils/colors.dart';

import 'financial_score_screen.dart';
import 'send_money_screen.dart';


class HomeScreen
    extends StatefulWidget {

  const HomeScreen({
    super.key
  });


  @override
  State<HomeScreen>
      createState()
      =>
      _HomeScreenState();

}


class _HomeScreenState
    extends State<HomeScreen> {

  int score = 0;

  double income = 0;

  double spent = 0;

  double saving = 0;

  bool isLoading = true;


  @override
  void initState() {

    super.initState();

    loadData();

  }


  Future<void> loadData() async {

    final data =
        await ApiService
            .getFinancialScore(
      "user1",
    );


    if (!mounted) return;


    if (data != null) {

      setState(() {

        score =
            int.tryParse(
              data["score"]
                  .toString(),
            )
            ?? 0;


        income =
            double.tryParse(
              data["income"]
                  .toString(),
            )
            ?? 0;


        spent =
            double.tryParse(
              data["spent"]
                  .toString(),
            )
            ?? 0;


        saving =
            double.tryParse(
              data["saving"]
                  .toString(),
            )
            ?? 0;


        isLoading =
            false;

      });

    }

    else {

      setState(() {

        isLoading =
            false;

      });

    }

  }


  Color get scoreColor {

    if (score >= 80) {

      return Colors.green;

    }

    if (score >= 60) {

      return Colors.orange;

    }

    return Colors.red;

  }


  @override
  Widget build(
      BuildContext context) {

    return Scaffold(

      backgroundColor:
          AppColors.background,


      appBar:
          AppBar(

        title:
            const Text(
          "FinGuard AI",
        ),

        backgroundColor:
            AppColors.primary,

        foregroundColor:
            Colors.white,


        actions: [

          Padding(

            padding:
                const EdgeInsets.only(
              right: 12,
            ),


            child:
                GestureDetector(

              onTap:
                  () async {

                await Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder:
                        (_) =>
                            const FinancialScoreScreen(),

                  ),

                );


                loadData();

              },


              child:
                  Container(

                padding:
                    const EdgeInsets.symmetric(
                  horizontal:
                      12,
                  vertical:
                      7,
                ),

                decoration:
                    BoxDecoration(

                  color:
                      scoreColor,

                  borderRadius:
                      BorderRadius.circular(
                    20,
                  ),

                ),

                child:
                    Row(

                  children: [

                    const Icon(

                      Icons.analytics,

                      color:
                          Colors.white,

                      size:
                          18,

                    ),


                    const SizedBox(
                      width: 5,
                    ),


                    Text(

                      isLoading
                          ? "..."
                          : "$score",

                      style:
                          const TextStyle(

                        color:
                            Colors.white,

                        fontWeight:
                            FontWeight.bold,

                      ),

                    ),

                  ],

                ),

              ),

            ),

          ),

        ],

      ),


      body:
          RefreshIndicator(

        onRefresh:
            loadData,


        child:
            ListView(

          padding:
              const EdgeInsets.all(
            16,
          ),


          children: [

            const Text(

              "Good Morning 👋",

              style:
                  TextStyle(

                fontSize:
                    24,

                fontWeight:
                    FontWeight.bold,

              ),

            ),


            const SizedBox(
              height: 20,
            ),


            Container(

              width:
                  double.infinity,

              padding:
                  const EdgeInsets.all(
                20,
              ),

              decoration:
                  BoxDecoration(

                color:
                    AppColors.primary,

                borderRadius:
                    BorderRadius.circular(
                  20,
                ),

              ),


              child:
                  Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  const Text(

                    "Monthly Overview",

                    style:
                        TextStyle(

                      color:
                          Colors.white,

                      fontSize:
                          18,

                    ),

                  ),


                  const SizedBox(
                    height:
                        15,
                  ),


                  Text(

                    "Income: ₹${income.toStringAsFixed(0)}",

                    style:
                        const TextStyle(

                      color:
                          Colors.white,

                      fontSize:
                          18,

                    ),

                  ),


                  const SizedBox(
                    height: 6,
                  ),


                  Text(

                    "Spent: ₹${spent.toStringAsFixed(0)}",

                    style:
                        const TextStyle(

                      color:
                          Colors.white,

                      fontSize:
                          22,

                      fontWeight:
                          FontWeight.bold,

                    ),

                  ),


                  const SizedBox(
                    height: 6,
                  ),


                  Text(

                    "Remaining: ₹${saving.toStringAsFixed(0)}",

                    style:
                        const TextStyle(

                      color:
                          Colors.white70,

                    ),

                  ),

                ],

              ),

            ),


            const SizedBox(
              height: 30,
            ),


            const Text(

              "Quick Actions",

              style:
                  TextStyle(

                fontSize:
                    20,

                fontWeight:
                    FontWeight.bold,

              ),

            ),


            const SizedBox(
              height: 20,
            ),


            GestureDetector(

              onTap:
                  () async {

                await Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder:
                        (_) =>
                            const SendMoneyScreen(),

                  ),

                );


                loadData();

              },


              child:
                  Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  CircleAvatar(

                    radius:
                        30,

                    backgroundColor:
                        AppColors.secondary,

                    child:
                        const Icon(

                      Icons.send,

                      color:
                          Colors.white,

                    ),

                  ),


                  const SizedBox(
                    height: 8,
                  ),


                  const Text(
                    "Send",
                  ),

                ],

              ),

            ),

          ],

        ),

      ),

    );

  }

}