import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quote_app/providers/QuoteProvider.dart';
import 'package:quote_app/utils/CommonStringUtils.dart';
import 'package:quote_app/utils/Strings.dart';
import 'package:quote_app/widgets/CheckBoxWidget.dart';

import 'QuoteDetailsPage.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text(Strings.FAVORITES, style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Consumer<QuoteProvider>(builder: (context, myModel, child) {
        if (myModel.quoteFav.isNotEmpty) {
          return GridView.builder(
            itemCount: myModel.quoteFav.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: InkWell(
                  onTap: () {
                    myModel.details(myModel.quoteFav[index]);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QuoteDetailsPage()));
                  },
                  child: Card(
                      color: CommonStringUtils.picColors(),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: CheckBoxWidget(
                                onPressed: () {
                                  myModel.quoteFav[index].isSelected =
                                      !myModel.quoteFav[index].isSelected;
                                  myModel.removeFav(myModel.quoteFav[index]);
                                },
                                isSelected: myModel.quoteFav[index].isSelected,
                              ),
                            ),
                            Text(
                              CommonStringUtils.trimFirst(
                                  myModel.quoteFav[index].title),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              myModel.quoteFav[index].body,
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )),
                ),
              );
            },
          );

          return GridView.builder(
            itemCount: myModel.quoteFav.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  myModel.details(myModel.quote.data[index]);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => QuoteDetailsPage()));
                },
                child: Card(
                    child: Column(
                  children: [
                    Text(myModel.quoteFav[index].title),
                    Text(myModel.quoteFav[index].body),
                    CheckBoxWidget(
                      onPressed: () {
                        myModel.quoteFav[index].isSelected =
                            !myModel.quoteFav[index].isSelected;
                        myModel.removeFav(myModel.quoteFav[index]);
                      },
                      isSelected: myModel.quoteFav[index].isSelected,
                    ),
                  ],
                )),
              );
            },
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.sentiment_dissatisfied_outlined,
                  size: 80,
                ),
                Text(
                  Strings.PLEASE_ADD_FAV,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
