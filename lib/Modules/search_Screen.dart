import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/components/components.dart';
import 'package:newsapp/cubit/cubit.dart';
import 'package:newsapp/cubit/states.dart';

class Search_Screen extends StatelessWidget {

  var searchControllre = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<NewsCubit , NewsStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state)
      {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: searchControllre,
                  keyboardType: TextInputType.text,
                  validator: (String? val)
                  {
                    if(val!.isEmpty)
                    {
                      return 'Search Must Not Be Empty';
                    }
                    return null;
                  },
                  onChanged: (vall)
                  {
                     NewsCubit.get(context).getSearch(vall);
                  },
                  decoration: InputDecoration(
                      labelText: 'Search',
                      prefixIcon: Icon(Icons.search_rounded),
                      border: OutlineInputBorder()
                  ),
                ),
              ),
              Expanded(child: buildArticle(list,context , isSearch: true))

            ],
          ),
        );
      },

    );
  }
}
