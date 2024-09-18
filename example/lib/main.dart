import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:paystack_flutter_pro/paystack_flutter_pro.dart'; // Import your package

void main() async{
    await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Paystack Flutter Pro'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PaystackFlutterPro _paystackFlutterPro =
      PaystackFlutterPro(dotenv.env['PAYSTACK_SECRET_KEY'].toString());

  void _handlePayment(ctx) {
    _paystackFlutterPro.startTransaction(
      context: ctx,
      amount: 10,
      email: 'customer@mail.com',
      onSuccess: () {},
      onError: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paystack Pro'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () {
                _handlePayment(context);
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 10.0),
              ),
              child: const Text(
                'Pay GHS10',
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
