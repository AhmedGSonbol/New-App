import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/components/components.dart';
import 'package:newsapp/cubit/cubit.dart';
import 'package:newsapp/cubit/states.dart';

class Business_Screen extends StatelessWidget {
  const Business_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (c, state) {},
        builder: (c, state) {
          var list = NewsCubit.get(context).business;

          return buildArticle(list, context);
        }
    );
  }
}
