import 'package:flutter/material.dart';

import '../services/api_service.dart';
import '../utils/colors.dart';


class FinancialScoreScreen
    extends StatefulWidget {

  const FinancialScoreScreen({
    super.key
  });


  @override
  State<FinancialScoreScreen>
      createState()
      =>
      _FinancialScoreScreenState();

}


class _FinancialScoreScreenState
    extends State<FinancialScoreScreen> {

  bool isLoading = true;

  int score = 0;

  String rating = "";

  double spent = 0;

  double saving = 0;

  double income = 0;

  String topCategory =
      "No data";

  double averageTransaction =
      0;


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


    if (data == null) {

      setState(() {

        isLoading = false;

      });

      return;

    }


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


      rating =
          data["rating"]
              ?.toString()
          ?? "";


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


      income =
          double.tryParse(
            data["income"]
                .toString(),
          )
          ?? 0;


      topCategory =
          analysis[
                  "top_category"]
              ?.toString()
          ?? "No data";


      averageTransaction =
          double.tryParse(
            analysis[
                    "average_transaction"]
                .toString(),
          )
          ?? 0;


      isLoading =
          false;

    });

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
          "Financial Health",
        ),

        backgroundColor:
            AppColors.primary,

        foregroundColor:
            Colors.white,

      ),


      body:
          isLoading

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
                      20,
                    ),

                    children: [

                      Container(

                        padding:
                            const EdgeInsets.all(
                          25,
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
                            Column(

                          children: [

                            const Text(

                              "Your Financial Score",

                              style:
                                  TextStyle(

                                color:
                                    Colors.white,

                                fontSize:
                                    20,

                              ),

                            ),


                            const SizedBox(
                              height:
                                  12,
                            ),


                            Text(

                              "$score / 100",

                              style:
                                  const TextStyle(

                                color:
                                    Colors.white,

                                fontSize:
                                    42,

                                fontWeight:
                                    FontWeight.bold,

                              ),

                            ),


                            Text(

                              rating,

                              style:
                                  const TextStyle(

                                color:
                                    Colors.white,

                              ),

                            ),

                          ],

                        ),

                      ),


                      const SizedBox(
                        height: 25,
                      ),


                      infoCard(

                        "Monthly Income",

                        "₹${income.toStringAsFixed(0)}",

                        Icons.account_balance_wallet,

                      ),


                      infoCard(

                        "Total Spending",

                        "₹${spent.toStringAsFixed(0)}",

                        Icons.shopping_cart,

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


                      infoCard(

                        "Average Transaction",

                        "₹${averageTransaction.toStringAsFixed(0)}",

                        Icons.receipt,

                      ),

                    ],

                  ),

                ),

    );

  }

}