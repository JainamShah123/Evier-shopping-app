import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        children: [
          InkWell(
            onTap: () {
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (ctx) => ShowerPage()));
            },
            child: Container(
              ////decoration: CustomBoxDecoration(),
              child: Center(
                child: Text(
                  "Shower",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              // Navigator.push(
              // context, MaterialPageRoute(builder: (ctx) => HealthFacuet()));
            },
            child: Container(
              ////decoration: CustomBoxDecoration(),
              child: Center(
                child: Text(
                  "Health Facuet",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              // Navigator.push(
              // context, MaterialPageRoute(builder: (ctx) => WaterTap()));
            },
            child: Container(
              ////decoration: CustomBoxDecoration(),
              child: Center(
                  child: Text(
                "Water Tap",
                style: TextStyle(
                  color: Colors.white,
                ),
              )),
            ),
          ),
          InkWell(
            onTap: () {
              //   Navigator.push(
              //       context, MaterialPageRoute(builder: (ctx) => Floortap()));
              //
            },
            child: Container(
              ////decoration: CustomBoxDecoration(),
              child: Center(
                  child: Text(
                "Floor Trap",
                style: TextStyle(
                  color: Colors.white,
                ),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
