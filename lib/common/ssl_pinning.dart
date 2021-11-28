import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class SSLPinning {
  static Future<http.Client> get _instance async =>
      _clientInstance ??= await createLEClient();

  static http.Client? _clientInstance;
  static http.Client get client => _clientInstance ?? http.Client();

  static Future<void> init() async {
    _clientInstance = await _instance;
  }

  static Future<HttpClient> customHttpClient({
    bool isTestMode = false,
  }) async {
    SecurityContext context = SecurityContext(withTrustedRoots: false);
    try {
      List<int> bytes = [];

      if (isTestMode) {
        bytes = utf8.encode(_cert);
      } else {
        bytes = (await rootBundle.load('certificate/certificate.pem')).buffer.asUint8List();
      }
      context.setTrustedCertificatesBytes(bytes);
    } on TlsException catch (e) {
      if (e.osError?.message != null && e.osError!.message.contains('CERT_ALREADY_IN_HASH_TABLE')) {
        log('createHttpClient() - cert already trusted! Skipping.');
      } else {
        log('createHttpClient().setTrustedCertificateBytes EXCEPTION: $e');
        rethrow;
      }
    } catch (e) {
      log('unexpected error $e');
      rethrow;
    }
    HttpClient httpClient = HttpClient(context: context);
    httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => false;

    return httpClient;
  }

  static Future<http.Client> createLEClient({bool isTestMode = false}) async {
    IOClient client = IOClient(await customHttpClient(isTestMode: isTestMode));
    return client;
  }
}


const _cert = """-----BEGIN CERTIFICATE-----
MIIFODCCBCCgAwIBAgISBBxKCtyXSe/b5QAfIMprwA+YMA0GCSqGSIb3DQEBCwUA
MDIxCzAJBgNVBAYTAlVTMRYwFAYDVQQKEw1MZXQncyBFbmNyeXB0MQswCQYDVQQD
EwJSMzAeFw0yMTExMTUxOTE4MThaFw0yMjAyMTMxOTE4MTdaMCQxIjAgBgNVBAMT
GWRldmVsb3BlcnMudGhlbW92aWVkYi5vcmcwggEiMA0GCSqGSIb3DQEBAQUAA4IB
DwAwggEKAoIBAQCi2KGTw1J14Dz3TSDzwnqcDu36c0/rxhAjtOpnrNBMtYL9/5mU
YzBY1OKU3jxyyPRMtUW+OUxXOQpcHG7IAWkvyvu5L/A3SamK0nnqoTRQjBr/91Fg
q/1z86yxEpOfJJ4iC/TZ2o65q1xQJQmNMNRYUNPztMjUG2L1eoQxg12r64Jla5EY
PxjDE7RDxwudQbpg9zZGCRVdNNgnr0rbNimL7e1yxpTA3qa6enT8EYowXkZy5i/e
9p3AbLn0SlBDMzXr2nA2Y7tkxAXFUaroM3cXnknceRAowfO3NLrpg1YOC/Wb2izP
RD6eksB6B7HyTYnWX4SbbA27gCrktXHBqMa7AgMBAAGjggJUMIICUDAOBgNVHQ8B
Af8EBAMCBaAwHQYDVR0lBBYwFAYIKwYBBQUHAwEGCCsGAQUFBwMCMAwGA1UdEwEB
/wQCMAAwHQYDVR0OBBYEFKGEIhIcf4QMJ1MNONJeYbiKw9kkMB8GA1UdIwQYMBaA
FBQusxe3WFbLrlAJQOYfr52LFMLGMFUGCCsGAQUFBwEBBEkwRzAhBggrBgEFBQcw
AYYVaHR0cDovL3IzLm8ubGVuY3Iub3JnMCIGCCsGAQUFBzAChhZodHRwOi8vcjMu
aS5sZW5jci5vcmcvMCQGA1UdEQQdMBuCGWRldmVsb3BlcnMudGhlbW92aWVkYi5v
cmcwTAYDVR0gBEUwQzAIBgZngQwBAgEwNwYLKwYBBAGC3xMBAQEwKDAmBggrBgEF
BQcCARYaaHR0cDovL2Nwcy5sZXRzZW5jcnlwdC5vcmcwggEEBgorBgEEAdZ5AgQC
BIH1BIHyAPAAdgApeb7wnjk5IfBWc59jpXflvld9nGAK+PlNXSZcJV3HhAAAAX0l
QBtiAAAEAwBHMEUCICE5ZtdbwPP0hJc0V/1CzZGvOcigN5jpgfJJ+sx9T2RVAiEA
3rQ7kGHaM9EsiThOgsGK9e3u7HVC56kOIEW2i7LbL7IAdgDfpV6raIJPH2yt7rhf
Tj5a6s2iEqRqXo47EsAgRFwqcwAAAX0lQB1jAAAEAwBHMEUCICHeHP/vT199fNpz
lTXQL8hHniOurmXa/+CNHONySZN+AiEAitseOrp6gwiKlwLHi4WvOp1NpY1dH1Qn
jSaT/ukex+0wDQYJKoZIhvcNAQELBQADggEBAFgdrOadQXOEskBw8CU9/Jd8tRyK
nQgKnW5Gs43gldqPe4PX8J+kb1tn1tTG6+vltQgdYiUnflQ3qrV0fuS1JdUkfXt8
TaspPldoV6rbrX+adQcFLcoKqjW28otP5+UxKcgMUFHU5/um4RAfs/nQwAc4rAij
hSu9jgJIiaceYdgpLJW+pCUyljyZ0GKrbR5HThH6z9wKApmTXNTZIL1PzcX7Eimd
jHof/thovo88ry8jV/Ooaqbr+5Wqci65D1LeZrj9W+UIg9eWcCDC53ZbK7Kq0Jcu
/mAI1o6m3uB3idoq1x2HsZXFxS+eCowC6CuA83NbJ2OeJtz+hOnh20Dorbg=
-----END CERTIFICATE-----""";