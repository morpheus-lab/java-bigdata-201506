import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;


public class HttpTest {
	
	public static void main(String[] args) throws Exception {
		
		URL url = new URL("http://www.google.com/");
		
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		
		conn.setRequestMethod("GET");	// Http 메소드: GET/POST/PUT/DELETE
		
		// 서버에 데이터를 전송하는 메소드 (POST/PUT)인 경우
//		conn.setDoInput(true);
//		conn.setDoOutput(true);	// 데이터를 보낼 수 있는 OutputStream 객체 사용 가능해짐
								// getOutputStream() 사용할 수 있게 해줌
		
		conn.connect();	// 호스트에 연결
		
		BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		String line = null;
		while ((line = reader.readLine()) != null) {
			System.out.println(line);
		}
		
		reader.close();
		
		conn.disconnect();	// 호스트와의 연결 종료
		
	}
	
}
