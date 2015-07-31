import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.input.KeyValueTextInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.mapreduce.lib.output.TextOutputFormat;

import com.google.gson.Gson;


public class ESIndexCreator {
	
	public static class WikiDoc {	// Java Bean
		private String id;
		private String title;
		private String body;
		
		public String getId() {
			return id;
		}
		public void setId(String id) {
			this.id = id;
		}
		public String getTitle() {
			return title;
		}
		public void setTitle(String title) {
			this.title = title;
		}
		public String getBody() {
			return body;
		}
		public void setBody(String body) {
			this.body = body;
		}
	}
	
	public static class MyMapper extends Mapper<Text, Text, Text, Text> {
		
		private String baseURL;
		private Gson gson;
		
		@Override
		public void setup(Mapper<Text, Text, Text, Text>.Context context)
				throws IOException, InterruptedException {
			String host = context.getConfiguration().get("host", "localhost");
			baseURL = "http://" + host + ":9200/wikipedia/doc/";
			
			gson = new Gson();
		}
		
		@Override
		public void map(Text key, Text value,
				Mapper<Text, Text, Text, Text>.Context context)
				throws IOException, InterruptedException {
			URL url = new URL(baseURL + key.toString());	// 전송 URL
			
			WikiDoc doc = new WikiDoc();
			doc.setBody(value.toString());
			
			String json = gson.toJson(doc);	// 전송할 데이터
			
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("PUT");
			conn.setDoInput(true);
			conn.setDoOutput(true);
			
//			conn.connect();
			
			OutputStreamWriter writer = new OutputStreamWriter(conn.getOutputStream());
			writer.write(json);
			writer.close();
			
			BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String response = "";
			String line = null;
			while ((line = reader.readLine()) != null) {
				response += line + "\n";
			}
			reader.close();
			
			if (response.indexOf("\"ok\":true") < 0) {
				// 실패
				context.getCounter("Stats", "Failure").increment(1L);
			} else {
				// 성공
				context.getCounter("Stats", "Success").increment(1L);
			}
			
			conn.disconnect();
			
			value.set(json);
			context.write(key, value);
		}
		
	}
	
	public static void main(String[] args) throws Exception {
		
		Configuration conf = new Configuration();
		Job job = new Job(conf, "ESIndexCreator");
		
		job.setJarByClass(ESIndexCreator.class);
		job.setOutputKeyClass(Text.class);
		job.setOutputValueClass(Text.class);
		
		job.setMapperClass(ESIndexCreator.MyMapper.class);
		
		job.setNumReduceTasks(0);	// Skip Reduce Task
		
		job.setInputFormatClass(KeyValueTextInputFormat.class);
		job.setOutputFormatClass(TextOutputFormat.class);
		
		// 프로그램 인자
		// 0: 입력 파일 경로
		// 1: 출력 파일 경로
		// 2: elastic search server's host name
		FileInputFormat.addInputPath(job, new Path(args[0]));
		FileOutputFormat.setOutputPath(job, new Path(args[1]));
		
		job.getConfiguration().set("host", args[2]);
		
		job.waitForCompletion(true);
		
	}
	
}




























