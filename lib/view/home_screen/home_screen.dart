import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rive/rive.dart';
import '../../controller/user_controller.dart';
import '../../model/user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Job Task"),
      ),

      body:isLoading==false? const Center(child: Text("No Data")): Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FutureBuilder<UserModel>(
                future: UserController().getData(),
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    return Center(
                      child: Container(
                        height: 300,
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey
                        ),child: Column(
                        children: [
                          Image.network(
                            snapshot.data!.avatar??'',
                            height: 150,
                            width: 150,
                            errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(snapshot.data!.firstName!.toString()),
                              const SizedBox(width: 5,),
                              Text(snapshot.data!.lastName!.toString()),
                            ],
                          ),
                          const SizedBox(height: 5,),
                          Text(snapshot.data!.phoneNumber!.toString()),
                          const SizedBox(height: 5,),
                          Text(DateFormat.yMMMd().format(snapshot.data!.dateOfBirth!)),

                        ],
                      ),
                      ),
                    );
                  }else{
                    // return const Center(child:CircularProgressIndicator(),);
                    return const SizedBox(
                        height: 100,
                        child: RiveAnimation.asset(
                          'assets/loading_new.riv',
                           alignment: Alignment.center,
                        ),
                    );
                  }
                }),
          ],
        ),
      ) ,


      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isLoading=true;
            UserController().getData();

             });
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

