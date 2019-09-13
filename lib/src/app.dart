import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/counter_bloc.dart';
import 'ui/index.dart';

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterBloc>(builder: (BuildContext context) => CounterBloc()),
      ],
      child: MaterialApp(
        title: 'Cat Test Application',
        theme: ThemeData(primarySwatch: Colors.blue),
        routes: {
          '/': (context) => Index(),
        },
      ),
    );
  }
}
