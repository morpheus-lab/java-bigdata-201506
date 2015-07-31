
import java.io.IOException;
import java.util.StringTokenizer;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.input.KeyValueTextInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.mapreduce.lib.output.TextOutputFormat;

public class WordCount2 {
	
	public static class MyMapper extends Mapper<Text, Text, Text, LongWritable> {
		private Text word = new Text();
		private static LongWritable ONE = new LongWritable(1L);
		
		private static int i = 0;
		
		@Override
		public void setup(
				Mapper<Text, Text, Text, LongWritable>.Context context)
				throws IOException, InterruptedException {
			System.out.println(i++);
			super.setup(context);
		}
		
		@Override
		public void map(Text key, Text value,
				Mapper<Text, Text, Text, LongWritable>.Context context)
				throws IOException, InterruptedException {
			String content = value.toString();		// 텍스트 파일 내 문서 내용
			StringTokenizer tokenizer = new StringTokenizer(content, " \t\r\n\f|,.<>{}\"'~!@#$%^&*()`-=");
			while (tokenizer.hasMoreTokens()) {
				word.set(tokenizer.nextToken());	// 대소문자 구분 O
//				word.set(tokenizer.nextToken().toLowerCase());	// 대소문자 구분 X
				context.write(word, ONE);
			}
		}
	}
	
	public static class MyReducer extends Reducer<Text, LongWritable, Text, LongWritable> {
		
		private LongWritable count = new LongWritable();
		
		@Override
		public void reduce(Text key, Iterable<LongWritable> values,
				Reducer<Text, LongWritable, Text, LongWritable>.Context context)
				throws IOException, InterruptedException {
			// (key, values) = (word, {1, 1, 1, 1, 1, 1})
			long sum = 0;
			for (LongWritable value : values) {
				sum += value.get();
			}
			count.set(sum);
			context.write(key, count);
			context.getCounter("Word Stats", "Unique Words").increment(1L);
		}
	}
	
	public static void main(String[] args) throws Exception {
		Configuration conf = new Configuration();
		Job job = new Job(conf, "WordCount2");
		
		// 각종 초기화 설정
		job.setJarByClass(WordCount2.class);
		job.setMapperClass(WordCount2.MyMapper.class);		// 맵퍼 클래스 지정
		job.setCombinerClass(WordCount2.MyReducer.class);	// 컴바이너 클래스 지정
		job.setReducerClass(WordCount2.MyReducer.class);	// 리듀서 클래스 지정
		
		// 최종 출력물 키-밸류 형식 지정
		job.setOutputKeyClass(Text.class);
		job.setOutputValueClass(LongWritable.class);
		
		// 입력 데이터 처리 클래스 지정
		job.setInputFormatClass(KeyValueTextInputFormat.class);
		
		// 출력 데이터 처리 클래스 지정
		job.setOutputFormatClass(TextOutputFormat.class);
		
		// 입력 파일 위치 지정
		FileInputFormat.addInputPath(job, new Path(args[0]));
		
		// 출력 파일 위치 지정
		FileOutputFormat.setOutputPath(job, new Path(args[1]));
		
		// 잡 실행
		job.waitForCompletion(true);
	}
	
}



























