import 'package:flutter/material.dart';
import 'package:paystack_flutter_pro/paystack_flutter_pro.dart'; // Import your package

void main() {
  runApp(const MyApp());
}
 
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
  int _counter = 0;
  final PaystackFlutterPro _paystackFlutterPro = PaystackFlutterPro('sk_test_658b2e7d7ba05b626f6fdf58892f834fb6829941');

  void _handlePayment(ctx) {
    setState(() {
      _counter+=1;
      debugPrint(' $_counter');
    });
      _paystackFlutterPro.startTransaction( context: ctx, amount: _counter, email: 'customer@mail.com', onSuccess: (){}, onError: (){} );
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
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){_handlePayment(context);},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
