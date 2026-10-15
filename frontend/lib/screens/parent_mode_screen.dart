import 'package:flutter/material.dart';

import '../services/api_service.dart';
import '../utils/colors.dart';


class ParentModeScreen
    extends StatefulWidget {

  const ParentModeScreen({
    super.key
  });


  @override
  State<ParentModeScreen>
      createState()
      =>
      _ParentModeScreenState();

}


class _ParentModeScreenState
    extends State<ParentModeScreen> {

  int score = 0;

  double spent = 0;

  double saving = 0;

  String topCategory =
      "No data";

  bool loading = true;


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

      final analysis =
          data["analysis"]
              ?? {};


      setState(() {

        score =
            int.tryParse(
              data["score"]
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


        topCategory =
            analysis[
                    "top_category"]
                ?.toString()
            ?? "No data";


        loading =
            false;

      });

    }

    else {

      setState(() {

        loading =
            false;

      });

    }

  }


  Widget infoCard(
      String title,
      String value,
      IconData icon) {

    return Card(

      child:
          ListTile(

        leading:
            CircleAvatar(

          backgroundColor:
              AppColors.secondary,

          child:
              Icon(
            icon,
            color:
                Colors.white,
          ),

        ),

        title:
            Text(title),

        trailing:
            Text(

          value,

          style:
              const TextStyle(

            fontWeight:
                FontWeight.bold,

          ),

        ),

      ),

    );

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
          "Parent Dashboard",
        ),

        backgroundColor:
            AppColors.primary,

        foregroundColor:
            Colors.white,

      ),


      body:
          loading

              ? const Center(
                  child:
                      CircularProgressIndicator(),
                )

              : RefreshIndicator(

                  onRefresh:
                      loadData,


                  child:
                      ListView(

                    padding:
                        const EdgeInsets.all(
                      16,
                    ),

                    children: [

                      Container(

                        padding:
                            const EdgeInsets.all(
                          22,
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

                          children: [

                            const Text(

                              "Student Financial Score",

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
                                  10,
                            ),


                            Text(

                              "$score / 100",

                              style:
                                  const TextStyle(

                                color:
                                    Colors.white,

                                fontSize:
                                    38,

                                fontWeight:
                                    FontWeight.bold,

                              ),

                            ),

                          ],

                        ),

                      ),


                      const SizedBox(
                        height: 20,
                      ),


                      infoCard(

                        "Monthly Spending",

                        "₹${spent.toStringAsFixed(0)}",

                        Icons.account_balance_wallet,

                      ),


                      infoCard(

                        "Remaining",

                        "₹${saving.toStringAsFixed(0)}",

                        Icons.savings,

                      ),


                      infoCard(

                        "Top Category",

                        topCategory,

                        Icons.category,

                      ),


                      const SizedBox(
                        height: 20,
                      ),


                      Container(

                        padding:
                            const EdgeInsets.all(
                          16,
                        ),

                        decoration:
                            BoxDecoration(

                          color:
                              Colors.green.shade100,

                          borderRadius:
                              BorderRadius.circular(
                            15,
                          ),

                        ),


                        child:
                            Text(

                          "AI Summary\n\n"
                          "Financial score: $score/100\n"
                          "Total spending: ₹${spent.toStringAsFixed(0)}\n"
                          "Highest spending category: $topCategory\n\n"
                          "This dashboard is intended to support financial guidance rather than control every transaction.",

                        ),

                      ),

                    ],

                  ),

                ),

    );

  }

}