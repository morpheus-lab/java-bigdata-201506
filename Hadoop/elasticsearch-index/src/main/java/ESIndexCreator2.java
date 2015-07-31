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
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.KeyValueTextInputFormat;
import org.apache.hadoop.mapreduce.lib.input.MultipleInputs;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.mapreduce.lib.output.TextOutputFormat;

import com.google.gson.Gson;


public class ESIndexCreator2 {
	
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
	
	public static class ContentMapper extends Mapper<Text, Text, Text, Text> {
		
		@Override
		public void map(Text key, Text value,
				Mapper<Text, Text, Text, Text>.Context context)
				throws IOException, InterruptedException {
			value.set("1\t" + value.toString());
			context.write(key, value);
		}
		
	}
	
	public static class TitleMapper extends Mapper<Text, Text, Text, Text> {
		
		@Override
		public void map(Text key, Text value,
				Mapper<Text, Text, Text, Text>.Context context)
				throws IOException, InterruptedException {
			key.set("2\t" + key.toString());
			context.write(value, key);
		}
		
	}
	
	public static class MyReducer extends Reducer<Text, Text, Text, Text> {
		private String baseURL;
		private Gson gson;
		
		@Override
		public void setup(Reducer<Text, Text, Text, Text>.Context context)
				throws IOException, InterruptedException {
			String host = context.getConfiguration().get("host", "localhost");
			baseURL = "http://" + host + ":9200/wikipedia/doc/";
			
			gson = new Gson();
		}
		
		@Override
		public void reduce(Text key, Iterable<Text> values,
				Reducer<Text, Text, Text, Text>.Context context)
				throws IOException, InterruptedException {
			// 조인
			String title = null;
			String content = null;
			
			for (Text val : values) {
				String[] tokens = val.toString().split("\\t", 2);
				if ("1".equals(tokens[0])) {
					content = tokens[1];
				}
				else if ("2".equals(tokens[0])) {
					title = tokens[1];
				}
					
			}
			
			if (title != null && content != null) {
				// ES 데이터 전송
				URL url = new URL(baseURL + key.toString());	// 전송 URL
				
				WikiDoc doc = new WikiDoc();
				doc.setTitle(title);
				doc.setBody(content);
				
				String json = gson.toJson(doc);	// 전송할 데이터
				
				HttpURLConnection conn = (HttpURLConnection) url.openConnection();
				conn.setRequestMethod("PUT");
				conn.setDoInput(true);
				conn.setDoOutput(true);
				
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
			}
		}
		
	}
	
	public static void main(String[] args) throws Exception {
		
		Configuration conf = new Configuration();
		Job job = new Job(conf, "ESIndexCreator");
		
		job.setJarByClass(ESIndexCreator2.class);
		job.setOutputKeyClass(Text.class);
		job.setOutputValueClass(Text.class);
		
		job.setReducerClass(ESIndexCreator2.MyReducer.class);
		job.setNumReduceTasks(1);
		
		MultipleInputs.addInputPath(job, new Path(args[0]),
				KeyValueTextInputFormat.class, ESIndexCreator2.ContentMapper.class);
		MultipleInputs.addInputPath(job, new Path(args[1]),
				KeyValueTextInputFormat.class, ESIndexCreator2.TitleMapper.class);
		
		job.setOutputFormatClass(TextOutputFormat.class);
		
		// 프로그램 인자
		// 0: 입력 파일 1 경로 (10K.ID.CONTENTS)
		// 1: 입력 파일 2 경로 (2M.TITLE.ID)
		// 2: 출력 파일 경로
		// 3: elastic search server's host name
		FileOutputFormat.setOutputPath(job, new Path(args[2]));
		
		job.getConfiguration().set("host", args[3]);
		
		job.waitForCompletion(true);
		
	}
	
}




























