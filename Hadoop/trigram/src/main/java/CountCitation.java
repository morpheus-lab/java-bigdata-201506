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


public class CountCitation {
	
	public static class MyMapper extends Mapper<Text, Text, Text, LongWritable> {
		
		private LongWritable ONE = new LongWritable(1L);
		
		@Override
		public void map(Text key, Text value,
				Mapper<Text, Text, Text, LongWritable>.Context context)
				throws IOException, InterruptedException {
			context.write(value, ONE);
		}
	}
	
	public static class MyReducer extends Reducer<Text, LongWritable, Text, LongWritable> {
		
		private LongWritable count = new LongWritable();
		
		@Override
		public void reduce(Text key, Iterable<LongWritable> values,
				Reducer<Text, LongWritable, Text, LongWritable>.Context context)
				throws IOException, InterruptedException {
			long sum = 0;
			for (LongWritable val : values) {
				sum += val.get();
			}
			count.set(sum);
			context.write(key, count);
		}
	}
	
	public static void main(String[] args) throws Exception {
		
		if (args.length < 3) {
			System.err.println("Usage: CountCitation {input path} {ouput path} {topN}");
			return;
		}
		
		// ------------------------- CountCitation Job ----------------------------------
		
		Configuration conf = new Configuration();
		Job job = new Job(conf, "CountCitation");
		
		// 각종 초기화 설정
		job.setJarByClass(CountCitation.class);
		job.setMapperClass(CountCitation.MyMapper.class);		// 맵퍼 클래스 지정
		job.setCombinerClass(CountCitation.MyReducer.class);	// 컴바이너 클래스 지정
		job.setReducerClass(CountCitation.MyReducer.class);	// 리듀서 클래스 지정
		
		// 최종 출력물 키-밸류 형식 지정
		job.setOutputKeyClass(Text.class);				// 문서ID
		job.setOutputValueClass(LongWritable.class);	// 인용 횟수
		
		// 입력 데이터 처리 클래스 지정
		job.setInputFormatClass(KeyValueTextInputFormat.class);
		
		// 출력 데이터 처리 클래스 지정
		job.setOutputFormatClass(TextOutputFormat.class);
		
		// 입력 파일 위치 지정
		FileInputFormat.addInputPath(job, new Path(args[0]));	// 첫 번째 프로그램 인자
		
		// 출력 파일 위치 지정
		FileOutputFormat.setOutputPath(job, new Path(args[1]));	// 두 번째 프로그램 인자
		
		// 잡 실행
		if (!job.waitForCompletion(true)) {
			return;
		}
		
		// ------------------------- TopN Job ----------------------------------
		Configuration conf2 = new Configuration();
		Job job2 = new Job(conf2, "TopN");
		
		// 각종 초기화 설정
		job2.setJarByClass(TopN.class);
		job2.setMapperClass(TopN.MyMapper.class);	// 맵퍼 클래스 지정
		job2.setReducerClass(TopN.MyReducer.class);	// 리듀서 클래스 지정
		job2.setNumReduceTasks(1);	// 리듀스 태스크가 1개가 되도록 설정
		
		// 최종 출력물 키-밸류 형식 지정
		job2.setOutputKeyClass(Text.class);
		job2.setOutputValueClass(LongWritable.class);
		
		// 입력 데이터 처리 클래스 지정
		job2.setInputFormatClass(KeyValueTextInputFormat.class);
		
		// 출력 데이터 처리 클래스 지정
		job2.setOutputFormatClass(TextOutputFormat.class);
		
		// 입력 파일 위치 지정
		FileInputFormat.addInputPath(job2, new Path(args[1] + "/part-r-00000"));
		
		// 출력 파일 위치 지정
		FileOutputFormat.setOutputPath(job2, new Path(args[1] + "/TopN"));
		
		// N을 입력 받아 설정
		job2.getConfiguration().setInt("topN", Integer.parseInt(args[2]));	// 세 번째 프로그램 인자
		
		// 잡 실행
		job2.waitForCompletion(true);
	}
	
}































