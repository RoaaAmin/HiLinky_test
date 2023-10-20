import 'package:flutter/material.dart';

class chooseDesign extends StatefulWidget {
   chooseDesign({super.key});

  @override
  State<chooseDesign> createState() => _chooseDesignState();
}

class _chooseDesignState extends State<chooseDesign> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
          // appBar: AppBar(
          //   title: const Text("MyPosts"),
          //   leading: const Icon(Icons.arrow_back_ios),
          // ),

          body: ListView(
            


       children:[ 
     
        
       Card(
           shape: const RoundedRectangleBorder(
             borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          elevation: 3,
          //color: const Color.fromARGB(255, 255, 255, 255),
          child: Stack(
          //  constraints: const BoxConstraints(minHeight: 0, maxHeight: 200.0)
            alignment :Alignment.centerLeft,
            children: [

           Image(
            fit: BoxFit.cover,
              image: AssetImage("assets/images/bigbig.png"),
             //    height: 190,
                // width: context.width,
            ),
                
                
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
                    
                      
                      children: [
                   
                
                   
                
                        const SizedBox(
            width: 40,
                        ),
                        Column(
              //  mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "nameperson",
                style: const TextStyle(
                    fontSize: 15, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
              ),
              Text(
                "usernameperson",
                  textAlign: TextAlign.start,
              ),
                
              
           Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 40,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                       //   itemCount: Links.length,
                                          itemCount: 20,
                                          itemBuilder: (context, index) {
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                    gradient: LinearGradient(
                                                        colors: [
                                                          Colors.orange,
                                                          Colors.deepOrange
                                                        ],
                                                        end: Alignment.topLeft,
                                                        begin: Alignment
                                                            .bottomRight),
                                                  ),
                                                  width: 35,
                                                  height: 35,
                                                  child: Center(
                                                    child: IconButton(
                                                      isSelected: true,
                                                      iconSize: 20,
                                                      onPressed: () {
                                                        // final Uri url =
                                                        //     Uri.parse(
                                                        //         values[index]);
                                                        // _launchUrl(url);
                                                      },
                                                      icon: Icon(Icons.ac_unit_outlined),
                                                   //   Icon( l[keys[index]]!.icon),
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 15,
                                                )
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),  
             
            ],
                        ),
                      ],
                    ),
          ),
            ],
          )
            
          
            
        ),
       ]

    //    children: const [designList()],
      )),
    );

  }
}
