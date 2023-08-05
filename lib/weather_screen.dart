import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/additonal_info_update.dart';
import 'package:weather_app/hourly_update.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Future<Map<String, dynamic>> getUpdateWeather() async {
    try {
      final res = await http.get(Uri.parse(
          'http://api.openweathermap.org/data/2.5/forecast?id=1283613&appid=f432f8eb1d3265c0f14e64f68ef5229e'));

      final data = jsonDecode(res.body);
      if (data['cod'] != '200') {
        throw "Error Occured";
      }

      return data;
      // temp = data['list'][0]["main"]["temp"];
    } catch (e) {
      throw e.toString();
    }
  }

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
          IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: const Icon(Icons.refresh)),
        ],
      ),
      body: FutureBuilder(
        future: getUpdateWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          final data = snapshot.data!;
          final listStore = data['list'][0]["main"];
          final currentTemp = listStore["temp"];
          final currentSky = data['list'][0]["weather"][0]["main"];
          final currentPressure = listStore["pressure"];
          final currentHumidity = listStore["humidity"];
          final currentWindSpeed = data['list'][0]["wind"]["speed"];

          if (snapshot.hasError) {
            return Center(
                child: Text(
              snapshot.error.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ));
          }

          return Center(
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
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  "$currentTemp K",
                                  style: const TextStyle(
                                    fontSize: 33,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text(
                                  "Bharatpur,NP",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Icon(
                                  currentSky == "Clouds" || currentSky == "Rain"
                                      ? Icons.cloud
                                      : Icons.sunny,
                                  size: 64,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  currentSky,
                                  style: const TextStyle(
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
                        "Hourly Forecast",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  const SizedBox(
                    height: 16,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (int i = 0; i < 7; i++)
                          UpdateBox(
                            time: data['list'][i + 1]['dt_txt']
                                .toString()
                                .split(" ")[1],
                            icon: data['list'][i + 1]["weather"][0]["main"] ==
                                        "Clouds" ||
                                    data['list'][i + 1]["weather"][0]["main"] ==
                                        "Rain"
                                ? Icons.cloud
                                : Icons.sunny,
                            value:
                                data["list"][i + 1]["main"]["temp"].toString(),
                          ),
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
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AdditionalInfo(
                        data: Icons.water_drop,
                        label: "Humidity",
                        value: currentHumidity.toString(),
                      ),
                      AdditionalInfo(
                        data: Icons.air,
                        label: "Wind Speed",
                        value: currentWindSpeed.toString(),
                      ),
                      AdditionalInfo(
                        data: Icons.beach_access,
                        label: "Pressure",
                        value: currentPressure.toString(),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
