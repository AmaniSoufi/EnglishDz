import 'package:quiz_backend_client/quiz_backend_client.dart';

/// Global client instance for accessing the backend
late Client quizClient;

/// Initialize the backend client
void initializeQuizClient() {
  
  const serverUrl = 'https://quiz-backend-1-ue6r.onrender.com';

  quizClient = Client(serverUrl);
}
