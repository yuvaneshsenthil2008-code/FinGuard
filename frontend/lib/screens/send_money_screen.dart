import 'package:flutter/material.dart';

import '../services/api_service.dart';
import '../utils/colors.dart';


class SendMoneyScreen
    extends StatefulWidget {

  const SendMoneyScreen({
    super.key
  });


  @override
  State<SendMoneyScreen>
      createState()
      =>
      _SendMoneyScreenState();

}


class _SendMoneyScreenState
    extends State<SendMoneyScreen> {

  final nameController =
      TextEditingController();

  final amountController =
      TextEditingController();


  String selectedCategory =
      "Food";


  bool isPaying = false;


  final categories = [

    "Food",

    "Shopping",

    "Transport",

    "Education",

    "Bills",

    "Entertainment",

    "Other",

  ];


  Future<void>
      makePayment() async {

    final receiver =
        nameController.text
            .trim();

    final amount =
        double.tryParse(
      amountController.text
          .trim(),
    );


    if (receiver.isEmpty ||
        amount == null ||
        amount <= 0) {

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(

        const SnackBar(

          content: Text(
            "Enter valid payment details",
          ),

        ),

      );

      return;

    }


    setState(() {

      isPaying = true;

    });


    // =========================
    // PAYMENT WARNING
    // =========================

    final warnings =
        await ApiService
            .checkPayment(

      userId:
          "user1",

      amount:
          amount,

      category:
          selectedCategory,

      description:
          receiver,

    );


    if (!mounted) return;


    if (
      warnings.isNotEmpty &&
      !warnings.contains(
        "Payment looks safe.",
      )
    ) {

      final continuePayment =
          await showDialog<bool>(

        context:
            context,

        builder:
            (context) {

          return AlertDialog(

            title:
                const Text(
              "⚠ Spending Warning",
            ),

            content:
                Text(

              warnings.join(
                "\n\n",
              ),

            ),

            actions: [

              TextButton(

                onPressed:
                    () {

                  Navigator.pop(
                    context,
                    false,
                  );

                },

                child:
                    const Text(
                  "Cancel",
                ),

              ),


              ElevatedButton(

                onPressed:
                    () {

                  Navigator.pop(
                    context,
                    true,
                  );

                },

                child:
                    const Text(
                  "Continue",
                ),

              ),

            ],

          );

        },

      );


      if (
        continuePayment
        != true
      ) {

        setState(() {

          isPaying =
              false;

        });

        return;

      }

    }


    // =========================
    // PAYMENT
    // =========================

    final success =
        await ApiService
            .addTransaction(

      userId:
          "user1",

      amount:
          amount,

      category:
          selectedCategory,

      type:
          "debit",

      description:
          receiver,

    );


    if (!mounted) return;


    setState(() {

      isPaying = false;

    });


    if (success) {

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(

        SnackBar(

          content: Text(
            "Payment Successful - "
            "₹${amount.toStringAsFixed(0)}",
          ),

        ),

      );


      Navigator.pop(
        context,
      );

    }

    else {

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(

        const SnackBar(

          content: Text(
            "Payment failed",
          ),

        ),

      );

    }

  }


  @override
  void dispose() {

    nameController.dispose();

    amountController.dispose();

    super.dispose();

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
          "Send Money",
        ),

        backgroundColor:
            AppColors.primary,

        foregroundColor:
            Colors.white,

      ),


      body:
          SingleChildScrollView(

        padding:
            const EdgeInsets.all(
          20,
        ),


        child:
            Column(

          children: [

            TextField(

              controller:
                  nameController,

              decoration:
                  InputDecoration(

                labelText:
                    "Receiver Name",

                prefixIcon:
                    const Icon(
                  Icons.person,
                ),

                border:
                    OutlineInputBorder(

                  borderRadius:
                      BorderRadius
                          .circular(
                    12,
                  ),

                ),

              ),

            ),


            const SizedBox(
              height: 20,
            ),


            DropdownButtonFormField<
                String>(

              value:
                  selectedCategory,

              decoration:
                  InputDecoration(

                labelText:
                    "Category",

                prefixIcon:
                    const Icon(
                  Icons.category,
                ),

                border:
                    OutlineInputBorder(

                  borderRadius:
                      BorderRadius
                          .circular(
                    12,
                  ),

                ),

              ),


              items:
                  categories.map(
                (category) {

                  return DropdownMenuItem<
                      String>(

                    value:
                        category,

                    child:
                        Text(
                      category,
                    ),

                  );

                },
              ).toList(),


              onChanged:
                  (value) {

                if (value
                    != null) {

                  setState(() {

                    selectedCategory =
                        value;

                  });

                }

              },

            ),


            const SizedBox(
              height: 20,
            ),


            TextField(

              controller:
                  amountController,

              keyboardType:
                  const TextInputType
                      .numberWithOptions(
                decimal: true,
              ),

              decoration:
                  InputDecoration(

                labelText:
                    "Amount",

                prefixIcon:
                    const Icon(
                  Icons.currency_rupee,
                ),

                border:
                    OutlineInputBorder(

                  borderRadius:
                      BorderRadius
                          .circular(
                    12,
                  ),

                ),

              ),

            ),


            const SizedBox(
              height: 30,
            ),


            SizedBox(

              width:
                  double.infinity,

              height:
                  55,


              child:
                  ElevatedButton(

                onPressed:
                    isPaying
                        ? null
                        : makePayment,


                style:
                    ElevatedButton
                        .styleFrom(

                  backgroundColor:
                      AppColors.primary,

                ),


                child:
                    isPaying

                        ? const
                            CircularProgressIndicator(
                            color:
                                Colors.white,
                          )

                        : const Text(

                            "Pay Now",

                            style:
                                TextStyle(

                              color:
                                  Colors.white,

                              fontSize:
                                  18,

                            ),

                          ),

              ),

            ),

          ],

        ),

      ),

    );

  }

}