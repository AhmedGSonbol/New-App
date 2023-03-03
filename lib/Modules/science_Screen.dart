import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/components/components.dart';
import 'package:newsapp/cubit/cubit.dart';
import 'package:newsapp/cubit/states.dart';

class Science_Screen extends StatelessWidget {
  const Science_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (c , state){},
        builder: (c , state)
        {
          var list = NewsCubit.get(context).science;

          return buildArticle(list, context);
        }
    );
  }
}
