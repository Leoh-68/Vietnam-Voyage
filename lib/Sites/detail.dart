import 'package:flutter/material.dart';

class SitesState extends StatelessWidget{
  @override
  
  List<String> title=[
    "Vịnh Hạ Long.",
    "Vịnh Hạ Long.",
    
  ];
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: height / 1,
            child: Image.network("https://statics.vinpearl.com/du-lich-vinh-Ha-Long-hinh-anh1_1625911963.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 50.0,
            left: 20.0,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 40.0,
                width: 40.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                child: Icon(Icons.arrow_back),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: height / 2.4),
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              color: Colors.white,
            ),
            child: ListView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(top: 20.0),
              children: [
                Text(
                 title[1],
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                 title[1],
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 20.0),
                
                SizedBox(height: 20.0),
                Text(
                  title[1],
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Divider(
                  thickness: 1,
                  height: 40.0,
                ),
                Text(
                  'detail',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  title[0],
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 50.0),
              ],
            ),
          ),
          Positioned(
            top: height / 2.55,
            right: 20.0,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: 40.0,
                width: 40.0,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20.0,
                      offset: Offset(0, 10),
                      color: Colors.black.withOpacity(0.15),
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
     
    );
  }

  
}