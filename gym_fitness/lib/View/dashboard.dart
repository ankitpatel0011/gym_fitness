import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techsaga/Models/gym_model.dart';
import 'package:techsaga/components/widget.dart';
import 'package:techsaga/const/color_const.dart';
import 'package:techsaga/Repository/Server/gym_api.dart';
import 'package:techsaga/Repository/Provider/gym_provider.dart';
import 'package:techsaga/Repository/Provider/location_provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await locationProvider.checkPermissionsAndGetLocation();
      await gymProvider.getGym();
    });
  }

  @override
  Widget build(BuildContext context) {
    LocationProvider locationProvider = Provider.of<LocationProvider>(context);
    GymProvider gymProvider = Provider.of<GymProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: black,
      ),
      body: gymProvider.isLoding
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              children: [
                Container(
                  width: fullWidth(context),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: grey),
                    borderRadius: BorderRadius.circular(10),
                    // color: grey,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on),
                      Expanded(
                        child: Text(
                          locationProvider.location ?? "No Location",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: black),
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Fitness location for you",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      height: fullHeight(context) / 5,
                      // color: black.withOpacity(0.5),
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        scrollDirection: Axis.horizontal,
                        itemCount: gymProvider.gym.length,
                        itemBuilder: (BuildContext context, int index) {
                          GymMobel ds = gymProvider.gym[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: fullWidth(context) / 3,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: green,
                                  ),
                                  height: 100,
                                  child: Image.network(ds.gymLogo ?? ""),
                                ),
                                const Gap(5),
                                SizedBox(
                                  width: fullWidth(context) / 3,
                                  child: Text(
                                    ds.gymName ?? "",
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
    );
  }
}
