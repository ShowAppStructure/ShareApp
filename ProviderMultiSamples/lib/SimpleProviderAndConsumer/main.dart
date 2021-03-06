import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_stream/SimpleProviderAndConsumer/provider/bread_crumb_provider.dart';
import 'package:provider_stream/SimpleProviderAndConsumer/widgets/bread_crumb_widget.dart';
import 'package:provider_stream/SimpleProviderAndConsumer/widgets/new_bread_crumb_widget.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => BreadCrumbProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: "bread crumbs"),
        routes: {
          '/new': (context) => NewBreadCrumbWidget()},
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("home"),
        ),
        body: Column(
          children: [
            Consumer<BreadCrumbProvider>(builder:(context, value, child) {
              return BreadCrumbWidget(breadCrumbs: value.items);
            },),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/new');
                },
                child: Text('Add new bread cumber')),
            TextButton(onPressed: () {
              context.read<BreadCrumbProvider>().reset();
            }, child: Text('Reset')),
          ],
        ));
  }
}
