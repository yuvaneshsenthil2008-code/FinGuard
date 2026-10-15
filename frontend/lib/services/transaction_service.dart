import '../models/transaction.dart';


class TransactionService {


  static List<TransactionModel> transactions = [];


  static void addTransaction(TransactionModel transaction){

    transactions.add(transaction);

  }


}