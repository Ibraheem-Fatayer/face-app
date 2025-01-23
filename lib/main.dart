import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const FaceRecognition(),
    );
  }
}

class FaceRecognition extends StatefulWidget {
  const FaceRecognition({super.key});

  @override
  State<FaceRecognition> createState() => _FaceRecognitionState();
}

class _FaceRecognitionState extends State<FaceRecognition> {
  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    initWebViewController();
  }

  void initWebViewController() {
    _webViewController = WebViewController()
      ..clearCache()
      ..enableZoom(false)
      ..setOnConsoleMessage(
        (message) {
          print("message: ${message.message}");
        },
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) async {
            await Permission.camera.request();
          },
          onNavigationRequest: (NavigationRequest request) {
            print("URL: ${request.url}");

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse("https://ibraheem-fatayer.github.io/face"));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: WebViewWidget(controller: _webViewController),
      ),
    );
  }
}


// class FaceRecognition extends StatelessWidget {
//   const FaceRecognition({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: InAppWebView(
//         initialUrlRequest:
//             URLRequest(url: Uri.parse('http://192.168.3.211:5000')),
//         initialOptions: InAppWebViewGroupOptions(
//           crossPlatform: InAppWebViewOptions(
//             mediaPlaybackRequiresUserGesture: false,
//             javaScriptEnabled: true,
//             useShouldOverrideUrlLoading: true,
//           ),
//           // android: AndroidInAppWebViewOptions(
//           //   useHybridComposition: true,
//           //   domStorageEnabled: true,
//           //   allowContentAccess: true,
//           //   allowFileAccess: true,
//           //   useWideViewPort: false,
//           //   loadWithOverviewMode: true,
//           //   databaseEnabled: true,
//           //   supportMultipleWindows: true,
//           // ),
//           // ios: InAppWebViewSettings (),
//         ),
//         onWebViewCreated: (controller) async {
//           // Request camera permission when WebView is created
//           await Permission.camera.request();
//         },
//         onPermissionRequest: (controller, permissionRequest) async {
//           return PermissionResponse(
//             resources: controller.,
//             action: PermissionResponseAction.GRANT,
//           );
//         },
//       ),
//     );
//   }
// }
