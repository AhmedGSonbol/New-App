import 'package:flutter/Material.dart';
import 'package:goold/navCubit/cubit.dart';

Widget ItemTaskBuilder(Map model , context) => Dismissible(
  key: Key(model['id'].toString()),

  onDismissed: (direction)
  {
    AppCubit.get(context).DeleteData(id: model['id']);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Item Deleted Sucessfully !')));
  },

  child:   Padding(
  
    padding: const EdgeInsets.all(20.0),
  
    child: SingleChildScrollView(
  
      scrollDirection: Axis.horizontal,
  
      child: Row(
  
        children: [
  
          CircleAvatar(
  
            radius: 40.0,
  
            child: Text(model['time']),
  
          ),
  
          SizedBox(width: 20.0,),
  
          Column(
  
            crossAxisAlignment: CrossAxisAlignment.start,
  
            mainAxisSize: MainAxisSize.min,
  
            children:
  
            [
  
  
  
              Text(model['title'],style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
  
              Text(model['date'],style: TextStyle(color: Colors.grey),),
  
            ],
  
          ),
  
          SizedBox(width: 20.0,),
  
          IconButton(
  
            icon: Icon(Icons.check_box , color: Colors.green,),
  
            onPressed: ()
  
            {
  
                AppCubit.get(context).UpdateData(status: 'done', id: model['id']) ;
  
            },
  
          ),
  
          IconButton(
  
            icon: Icon(Icons.archive , color: Colors.black45,),
  
            onPressed: ()
  
            {
  
              AppCubit.get(context).UpdateData(status: 'archive', id: model['id']) ;
  
            },
  
          ),
  
        ],
  
      ),
  
    ),
  
  ),
);