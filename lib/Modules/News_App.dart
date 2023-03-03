import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Modules/search_Screen.dart';
import 'package:newsapp/components/components.dart';
import 'package:newsapp/cubit/cubit.dart';
import 'package:newsapp/cubit/states.dart';

class NewsApp extends StatelessWidget
{
  const NewsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<NewsCubit , NewsStates>(

      listener: (context , state){},

      builder: (context , state)
      {

        var cubit = NewsCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text('News App'),
            actions:
            [
              IconButton(icon: Icon(Icons.search_rounded),onPressed: ()
              {
                navTo(context, Search_Screen());
              },
              ),
              IconButton(onPressed: ()
              {
                cubit.changeDarkMode();
              },
                  icon: Icon(Icons.brightness_4_outlined)),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items: cubit.bottomItems,
            onTap: (index)
            {
              cubit.changeBottomNavBar(index);
            },
          ),


          );
      },
    );
  }
}
