import 'package:quiz_backend_client/quiz_backend_client.dart';

/// Global client instance for accessing the backend
late Client quizClient;

/// Initialize the backend client
void initializeQuizClient() {
  // Update this URL if your backend is running on a different address
  // For physical devices, use your computer's IP address instead of localhost
  const serverUrl = 'https://quiz-backend-1-ue6r.onrender.com';

  quizClient = Client(serverUrl);
}
