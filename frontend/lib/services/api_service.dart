import 'dart:convert';

import 'package:http/http.dart'
    as http;


class ApiService {

  // Chrome / Flutter Web
  static const String baseUrl =
      "http://127.0.0.1:8000";


  // ==============================
  // ADD TRANSACTION
  // ==============================

  static Future<bool>
      addTransaction({

    required String userId,

    required double amount,

    required String category,

    required String type,

    required String description,

  }) async {

    final url = Uri.parse(
      "$baseUrl/add-transaction",
    );

    try {

      final response =
          await http.post(

        url,

        headers: {
          "Content-Type":
              "application/json",
        },

        body: jsonEncode({

          "user_id": userId,

          "amount": amount,

          "category": category,

          "type": type,

          "description":
              description,

        }),

      );


      return response.statusCode
          == 200;

    }

    catch (e) {

      print(
        "Transaction error: $e",
      );

      return false;

    }

  }


  // ==============================
  // GET TRANSACTIONS
  // ==============================

  static Future<List<dynamic>>
      getTransactions(
          String userId) async {

    final url = Uri.parse(
      "$baseUrl/transactions/$userId",
    );

    try {

      final response =
          await http.get(url);


      if (response.statusCode
          == 200) {

        final data =
            jsonDecode(
                response.body);

        return data[
                "transactions"]
            ?? [];

      }


      return [];

    }

    catch (e) {

      print(
        "Transaction fetch error: $e",
      );

      return [];

    }

  }


  // ==============================
  // FINANCIAL SCORE
  // ==============================

  static Future<
      Map<String, dynamic>?>
      getFinancialScore(
          String userId) async {

    final url = Uri.parse(
      "$baseUrl/financial-score/$userId",
    );

    try {

      final response =
          await http.get(url);


      if (response.statusCode
          == 200) {

        return jsonDecode(
          response.body,
        );

      }


      print(
        "Score API error: "
        "${response.body}",
      );

      return null;

    }

    catch (e) {

      print(
        "Score connection error: $e",
      );

      return null;

    }

  }


  // ==============================
  // AI
  // ==============================

  static Future<String>
      askAI({

    required String userId,

    required String question,

  }) async {

    final url = Uri.parse(
      "$baseUrl/ask-ai",
    );


    try {

      final response =
          await http.post(

        url,

        headers: {
          "Content-Type":
              "application/json",
        },

        body: jsonEncode({

          "user_id":
              userId,

          "question":
              question,

        }),

      );


      if (response.statusCode
          == 200) {

        final data =
            jsonDecode(
                response.body);

        return data[
                "response"]
            ?.toString()
            ?? "No response";

      }


      return "AI request failed.";

    }

    catch (e) {

      print(
        "AI error: $e",
      );

      return
          "Could not connect to AI.";

    }

  }


  // ==============================
  // PAYMENT WARNING
  // ==============================

  static Future<List<String>>
      checkPayment({

    required String userId,

    required double amount,

    required String category,

    required String description,

  }) async {

    final url = Uri.parse(
      "$baseUrl/check-payment",
    );


    try {

      final response =
          await http.post(

        url,

        headers: {
          "Content-Type":
              "application/json",
        },

        body: jsonEncode({

          "user_id":
              userId,

          "amount":
              amount,

          "category":
              category,

          "type":
              "debit",

          "description":
              description,

        }),

      );


      if (response.statusCode
          == 200) {

        final data =
            jsonDecode(
                response.body);

        final warning =
            data["warning"];


        if (warning is List) {

          return warning
              .map(
                (e) =>
                    e.toString(),
              )
              .toList();

        }


        if (warning is String) {

          return [
            warning
          ];

        }

      }


      return [];

    }

    catch (e) {

      print(
        "Warning API error: $e",
      );

      return [];

    }

  }

}