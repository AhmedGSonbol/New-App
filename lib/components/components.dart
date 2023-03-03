import 'package:flutter/Material.dart';
import 'package:newsapp/Modules/web_View.dart';

Widget buildArticleItem(article,context) => InkWell(
  onTap: ()
  {
    navTo(context, webVieww(article['url']));
  },
  child:   Padding(

        padding: const EdgeInsets.all(20.0),

        child: Row(

          children: [

            Container(

              width: 120.0,

              height: 120.0,

              decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(10.0),

                  image: DecorationImage(

                      image: NetworkImage(

                          '${article['urlToImage']}'),

                      fit: BoxFit.cover)),

            ),

            SizedBox(

              width: 20.0,

            ),

            Expanded(

              child: Container(

                height: 120.0,

                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [

                    Expanded(

                      child: Text(

                        '${article['title']}',

                        maxLines: 3,

                        overflow: TextOverflow.ellipsis,

                        style: Theme.of(context).textTheme.bodyText1,

                      ),

                    ),

                    Text(

                      '${article['publishedAt']}',

                      style: TextStyle(color: Colors.grey),

                    )

                  ],

                ),

              ),

            )

          ],

        ),

      ),
);

Widget buildArticle(list , context,{isSearch = false}) {
  return list.length == 0
      ? isSearch ? Container() :
   Center(
    child: CircularProgressIndicator(),
  )
      : ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (c, index) => buildArticleItem(list[index] , context),
      separatorBuilder: (c, index) => MyDivider(),
      itemCount: list.length);
}

Widget MyDivider() => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 15.0),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[400],
  ),
);

void navTo(context , route) {
  Navigator.of(context).push(MaterialPageRoute(builder: (c) => route));
}


