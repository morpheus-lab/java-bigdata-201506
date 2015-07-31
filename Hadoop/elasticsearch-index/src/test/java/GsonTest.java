import java.util.ArrayList;

import com.google.gson.Gson;


public class GsonTest {
	
	public static void main(String[] args) {
		
		ESIndexCreator.WikiDoc doc = new ESIndexCreator.WikiDoc();
//		doc.setId("101");
//		doc.setTitle("Hello");
		doc.setBody("Gson~!!");
		
		ArrayList<ESIndexCreator.WikiDoc> arr = new ArrayList<ESIndexCreator.WikiDoc>();
		arr.add(doc);
		arr.add(doc);
		arr.add(doc);
		
		Gson gson = new Gson();
		String json = gson.toJson(arr);
		
		System.out.println(json);
		
	}
	
}
