import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/additonal_info_update.dart';
import 'package:weather_app/hourly_update.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Weather App",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              "300.67°K",
                              style: TextStyle(
                                fontSize: 33,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Icon(
                              Icons.cloud,
                              size: 64,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              "Rain",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Weather Forecast",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              const SizedBox(
                height: 16,
              ),
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    UpdateBox(
                        time: "09:00", icon: Icons.cloud, value: "301.17"),
                    UpdateBox(
                        time: "12:00", icon: Icons.sunny, value: "301.54"),
                    UpdateBox(
                        time: "15:00",
                        icon: Icons.sunny_snowing,
                        value: "301.11"),
                    UpdateBox(
                        time: "18:00",
                        icon: Icons.thunderstorm,
                        value: "301.79"),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Additional Information",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AdditionalInfo(
                    data: Icons.water_drop,
                    label: "Humidity",
                    value: "91",
                  ),
                  AdditionalInfo(
                    data: Icons.air,
                    label: "Wind Speed",
                    value: "7.5",
                  ),
                  AdditionalInfo(
                    data: Icons.beach_access,
                    label: "Pressure",
                    value: "1000",
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
