import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quote_app/data/network/Resource.dart';
import 'package:quote_app/providers/QuoteProvider.dart';
import 'package:quote_app/ui/FavoritePage.dart';
import 'package:quote_app/ui/QuoteDetailsPage.dart';
import 'package:quote_app/utils/CommonStringUtils.dart';
import 'package:quote_app/utils/Strings.dart';
import 'package:quote_app/widgets/CheckBoxWidget.dart';
import 'package:shimmer/shimmer.dart';

class DashBoardPage extends StatefulWidget {
  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  var isSelected = false;

  var width = double.infinity;

  @override
  void initState() {
    context.read<QuoteProvider>().getQuote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Strings.QUOTES,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FavoritePage()));
              },
              icon: Icon(
                Icons.favorite,
                color: Colors.white,
              )),
        ],
      ),
      body: Consumer<QuoteProvider>(builder: (context, myModel, child) {
        if (myModel.quote.status == Status.SUCCESS) {
          return GridView.builder(
            itemCount: myModel.quote.data.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: InkWell(
                  onTap: () {
                    myModel.details(myModel.quote.data[index]);

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
                                  if (myModel.quote.data[index].isSelected) {
                                    myModel
                                        .removeFav(myModel.quote.data[index]);
                                    myModel.quote.data[index].isSelected =
                                        !myModel.quote.data[index].isSelected;
                                  } else {
                                    myModel.addFav(myModel.quote.data[index]);
                                    myModel.quote.data[index].isSelected =
                                        !myModel.quote.data[index].isSelected;
                                  }
                                },
                                isSelected:
                                    myModel.quote.data[index].isSelected,
                              ),
                            ),
                            Text(
                              CommonStringUtils.trimFirst(
                                  myModel.quote.data[index].title),
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
                              myModel.quote.data[index].body,
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
        } else if (myModel.quote.status == Status.ERROR) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.sentiment_dissatisfied_outlined,
                  size: 80,
                ),
                Text(
                  "${Strings.SORRY}\n ${myModel.quote.message}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                MaterialButton(
                  child: Text(Strings.RETRY),
                  onPressed: () {
                    context.read<QuoteProvider>().getQuote();
                  },
                  elevation: 10,
                  color: Colors.blue,
                  textColor: Colors.white,
                ),
              ],
            ),
          );
        } else {
          return GridView.builder(
            itemCount: 10,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey,
                            highlightColor: Colors.grey[300],
                            child: CheckBoxWidget(
                              onPressed: () {},
                              isSelected: false,
                            ),
                          ),
                        ),
                        Shimmer.fromColors(
                          baseColor: Colors.grey,
                          highlightColor: Colors.grey[300],
                          child: Container(
                            color: Colors.black,
                            width: width / 2,
                            height: 20,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey,
                            highlightColor: Colors.grey[300],
                            child: Container(
                              color: Colors.black,
                              width: width,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
