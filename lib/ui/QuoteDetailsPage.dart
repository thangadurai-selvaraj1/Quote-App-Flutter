import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quote_app/providers/QuoteProvider.dart';
import 'package:quote_app/utils/CommonStringUtils.dart';
import 'package:quote_app/utils/ImagePaths.dart';
import 'package:quote_app/utils/Strings.dart';
import 'package:share/share.dart';

class QuoteDetailsPage extends StatefulWidget {
  @override
  _QuoteDetailsPageState createState() => _QuoteDetailsPageState();
}

class _QuoteDetailsPageState extends State<QuoteDetailsPage> {
  var quote = "";
  var author = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            iconTheme: IconThemeData(
              color: Colors.white, //change your color here
            ),
            expandedHeight: 180,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                Strings.DETAILS,
                style: TextStyle(color: Colors.white),
              ),
              background: Image.asset(
                ImagePaths.QUOTE_BG,
                fit: BoxFit.fill,
              ),
              centerTitle: true,
            ),
          ),
          SliverFillRemaining(
            child: Center(
              child:
                  Consumer<QuoteProvider>(builder: (context, myModel, child) {
                if (myModel.quotDetails != null) {
                  author = myModel.quotDetails.title;
                  quote = myModel.quotDetails.body;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Strings.AUTHOR,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            fontStyle: FontStyle.italic),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        CommonStringUtils.trimFirst(myModel.quotDetails.title),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Text(
                        myModel.quotDetails.body,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      Text(
                        Strings.SORRY,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  );
                }
              }),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.share, color: Colors.white),
        onPressed: () {
          setState(() {
            share(
                context,
                "$quote \n\n - ${Strings.AUTHOR} : ${CommonStringUtils.trimFirst(author)}",
                Strings.QUOTES);
          });
        },
      ),
    );
  }

  share(BuildContext context, String text, String subject) {
    final RenderBox box = context.findRenderObject();
    Share.share(text,
        subject: subject,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
}
