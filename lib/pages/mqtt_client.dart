import 'dart:convert';
import 'dart:io';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:advnet/pages/cert.dart';

//TODO: Function setup the client
//TODO: Function publishes the message
//TODO: Publish message with each new state
late MqttServerClient client;
ClientWrapper mqttClient = ClientWrapper();
MqttCurrentConnectionState connectionState = MqttCurrentConnectionState.idle;
MqttSubscriptionState subscriptionState = MqttSubscriptionState.idle;

void startClient() => mqttClient.prepareMqttClient();

void motorDriver(String speedLevel) => mqttClient.publish(speedLevel);

enum MqttCurrentConnectionState {
  idle,
  connecting,
  connected,
  disconnected,
  errorWhenConnecting,
}

enum MqttSubscriptionState { idle, subscribed }

void _onDisconnected() {
  print('OnDisconnected client callback - Client disconnection');
  connectionState = MqttCurrentConnectionState.disconnected;
}

void _onConnected() {
  connectionState = MqttCurrentConnectionState.connected;
  print('OnConnected client callback - Client connection was sucessful');
}

class ClientWrapper {
  //TODO: There needs to be a separate Function.
  //TODO: Prepare function, publish function.
  void prepareMqttClient() async {
    _setupMqttClient();
    await _connectClient();
  }

  //TODO: Publish should be the value sent to the motor.
  void publish(String msg) {
    _publishMessage(msg);
  }

  void _publishMessage(String message) {
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(message);

    print('Publishing message "$message" to topic ${'test/1'}');
    client.publishMessage('test/1', MqttQos.exactlyOnce, builder.payload!);
  }

  Future<void> _connectClient() async {
    try {
      print('client connecting....');
      connectionState = MqttCurrentConnectionState.connecting;
      await client.connect("AliHussein", "HelloWorld123");
    } on NoConnectionException catch (e) {
      print('client exception - $e');
      connectionState = MqttCurrentConnectionState.errorWhenConnecting;
      client.disconnect();
    }
    if (client.connectionStatus?.state == MqttConnectionState.connected) {
      connectionState = MqttCurrentConnectionState.connected;
      print('client connected');
    } else {
      print(
        'ERROR client connection failed - disconnecting, status is ${client.connectionStatus}',
      );
      connectionState = MqttCurrentConnectionState.errorWhenConnecting;
      client.disconnect();
    }
  }

  Future<void> _setupMqttClient() async {
    final SecurityContext secContext;
    try {
      /*
   This can only work for Android/IOS because
   It relyes on the native TLS/SSL Support for the android/IOS
   It can't work on a web application.
   */
      secContext = SecurityContext();
      final List<int> caBytes = utf8.encode(cert);
      secContext.setTrustedCertificatesBytes(caBytes);
      client.securityContext = secContext;
    } catch (e) {
      print("Failed to create context: $e");
    }

    client = MqttServerClient.withPort(
      '125d87cdd33b4aaea537aa38aaab1e63.s1.eu.hivemq.cloud',
      'SliderApp',
      8883,
    );
    client.secure = true;
    client.keepAlivePeriod = 20;
    client.onDisconnected = _onDisconnected;
    client.onConnected = _onConnected;
  }
}
