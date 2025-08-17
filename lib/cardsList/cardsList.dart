import 'package:flutter/material.dart';
import 'package:prog_lazy_f/imagesW/imagesForW.dart';

class MoviCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 100,
      itemExtent: 164,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 10),
          child: Stack(
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,

                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadiusGeometry.circular(10),
                ),
                child: Row(
                  children: [
                    Image(image: AssetImage(ImagesWidg.heidiImageAdres)),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Text(
                            'Pitch Perfect 2',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Text('2007', style: TextStyle(color: Colors.black45)),
                          SizedBox(height: 20),
                          Text(
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(),
                            'Musical comedy sequel starring Anna Kendrick and Rebel Wilson. After a humiliating show in front of the President, the Barden Bellas a cappella group attempt to redeem themselves.',
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 6),
                  ],
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    print('tapapa');
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
