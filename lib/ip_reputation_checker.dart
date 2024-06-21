import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class IpReputationChecker extends StatefulWidget {
  const IpReputationChecker({super.key});

  @override
  State<IpReputationChecker> createState() => _IpReputationCheckerState();
}

class _IpReputationCheckerState extends State<IpReputationChecker> {
  String isp = 'N/A';
  String fraudScore = 'N/A';
  bool loading = false;

  Future<String> fetchUserIpAddress() async {
    try {
      final ipResponse =
          await http.get(Uri.parse('https://api.ipify.org?format=json'));
      if (ipResponse.statusCode == 200) {
        final ip = json.decode(ipResponse.body)['ip'];
        return ip;
      } else {
        return Future.error(
            'Failed to fetch IP address. Server responded with status code: ${ipResponse.statusCode}.');
      }
    } on http.ClientException catch (e) {
      return Future.error(
          'Failed to fetch IP address due to a network issue: ${e.message}.');
    } catch (e) {
      return Future.error(
          'An unexpected error occurred while fetching the IP address.');
    }
  }

  Future<Map<String, dynamic>> fetchIpReputation(String ip) async {
    //Provide your API Key usnig --dart-define=API_KEY=YOUR_API_KEY
    const apiKey = String.fromEnvironment('API_KEY');

    try {
      final response = await http
          .get(Uri.parse('https://ipqualityscore.com/api/json/ip/$apiKey/$ip'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return Future.error(
            'Failed to fetch IP reputation. Server responded with status code: ${response.statusCode}.');
      }
    } on http.ClientException catch (e) {
      return Future.error(
          'Failed to fetch IP reputation due to a network issue: ${e.message}.');
    } catch (e) {
      return Future.error(
          'An unexpected error occurred while fetching the IP reputation.');
    }
  }

  Future<void> getIpAddressReputation() async {
    setState(() {
      loading = true;
    });

    try {
      final ip = await fetchUserIpAddress();
      final data = await fetchIpReputation(ip);
      setState(() {
        isp = data['ISP'] ?? 'N/A';
        fraudScore = data['fraud_score']?.toString() ?? 'N/A';
      });
    } catch (e) {
      setState(() {
        isp = 'Error: Unable to retrieve data';
        fraudScore = 'Error: Unable to retrieve data';
      });
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IP Reputation Checker'),
      ),
      body: Center(
        child: loading
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'ISP:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            isp,
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Text(
                            'Fraud Score:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            fraudScore,
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: getIpAddressReputation,
                    child: const Text('GET IP address reputation'),
                  ),
                ],
              ),
      ),
    );
  }
}
