import 'package:flutter/material.dart';

import '../services/api_service.dart';
import '../utils/colors.dart';


class TransactionScreen
    extends StatefulWidget {

  const TransactionScreen({
    super.key
  });


  @override
  State<TransactionScreen>
      createState()
      =>
      _TransactionScreenState();

}


class _TransactionScreenState
    extends State<TransactionScreen> {

  List<dynamic> transactions = [];

  bool isLoading = true;


  @override
  void initState() {

    super.initState();

    loadTransactions();

  }


  Future<void>
      loadTransactions() async {

    setState(() {

      isLoading = true;

    });


    final data =
        await ApiService
            .getTransactions(
      "user1",
    );


    if (!mounted) return;


    setState(() {

      transactions =
          data.reversed.toList();

      isLoading =
          false;

    });

  }


  String formatDate(
      dynamic value) {

    if (value == null) {

      return "";

    }


    final date =
        DateTime.tryParse(
      value.toString(),
    );


    if (date == null) {

      return "";

    }


    return
        "${date.day}/${date.month}/${date.year} "
        "${date.hour.toString().padLeft(2, '0')}:"
        "${date.minute.toString().padLeft(2, '0')}";

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
          "Transaction History",
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

              : transactions.isEmpty

                  ? const Center(

                      child:
                          Text(
                        "No Transactions",
                      ),

                    )

                  : RefreshIndicator(

                      onRefresh:
                          loadTransactions,


                      child:
                          ListView.builder(

                        padding:
                            const EdgeInsets.all(
                          12,
                        ),

                        itemCount:
                            transactions.length,


                        itemBuilder:
                            (context,
                                index) {

                          final tx =
                              transactions[
                                  index];


                          final type =
                              tx["type"]
                                  ?.toString();


                          final debit =
                              type
                              == "debit";


                          return Card(

                            margin:
                                const EdgeInsets.only(
                              bottom:
                                  10,
                            ),


                            child:
                                ListTile(

                              leading:
                                  CircleAvatar(

                                backgroundColor:
                                    debit
                                        ? Colors.red.shade50
                                        : Colors.green.shade50,

                                child:
                                    Icon(

                                  debit
                                      ? Icons.arrow_upward
                                      : Icons.arrow_downward,

                                  color:
                                      debit
                                          ? Colors.red
                                          : Colors.green,

                                ),

                              ),


                              title:
                                  Text(

                                tx["description"]
                                        ?.toString()
                                    ??
                                    "Payment",

                                style:
                                    const TextStyle(

                                  fontWeight:
                                      FontWeight.bold,

                                ),

                              ),


                              subtitle:
                                  Text(

                                "${tx["category"] ?? "Other"}\n"
                                "${formatDate(tx["date"])}",

                              ),


                              isThreeLine:
                                  true,


                              trailing:
                                  Text(

                                "${debit ? "-" : "+"} "
                                "₹${tx["amount"]}",

                                style:
                                    TextStyle(

                                  color:
                                      debit
                                          ? Colors.red
                                          : Colors.green,

                                  fontWeight:
                                      FontWeight.bold,

                                ),

                              ),

                            ),

                          );

                        },

                      ),

                    ),

    );

  }

}