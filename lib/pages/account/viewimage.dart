import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ViewImage extends StatelessWidget {
  final image;

  const ViewImage({Key key, this.image}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 30, left: 10),
          height: MediaQuery.of(context).size.height,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      // BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.HomePageCLickedEvent);
                    },
                  ),
                  // SizedBox(width: MediaQuery.of(context).size.width/5),
                ],
              ),
              Expanded(
                child: CachedNetworkImage(
                  // imageUrl: "http://10.0.2.2:8000/uploads/avatar/" +
                  imageUrl: image,
                  imageBuilder: (context, imageProvider) => Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      
                      // shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.contain),
                    ),
                  ),
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
