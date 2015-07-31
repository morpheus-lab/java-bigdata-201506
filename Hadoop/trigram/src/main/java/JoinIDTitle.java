import java.io.IOException;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.*;
import org.apache.hadoop.mapreduce.lib.input.*;
import org.apache.hadoop.mapreduce.lib.output.*;


public class JoinIDTitle {
	
	// 인용 횟수 파일 처리용 맵퍼
	public static class MyMapper1 extends Mapper<Text, Text, Text, Text> {
		@Override
		public void map(Text key, Text value,
				Mapper<Text, Text, Text, Text>.Context context)
				throws IOException, InterruptedException {
			String citation = value.toString();	// {인용 횟수}
			value.set(citation + "\t1");	// {인용 횟수}\t1
			context.write(key, value);
		}
	}
	
	// 제목 파일 처리용 맵퍼
	public static class MyMapper2 extends Mapper<Text, Text, Text, Text> {
		@Override
		public void map(Text key, Text value,
				Mapper<Text, Text, Text, Text>.Context context)
				throws IOException, InterruptedException {
			String title = key.toString();
			key.set(title + "\t2");
			context.write(value, key);
		}
	}
	
	// 리듀서 (조인 처리)
	public static class MyReducer extends Reducer<Text, Text, Text, Text> {
		
		private Text outputValue = new Text();
		
		@Override
		protected void reduce(Text key, Iterable<Text> values,
				Reducer<Text, Text, Text, Text>.Context context)
				throws IOException, InterruptedException {
			String title = null;
			String citation = null;
			
			for (Text val : values) {
				String[] tokens = val.toString().split("\\t", 2);
				if ("1".equals(tokens[1])) {
					citation = tokens[0];
				} else if ("2".equals(tokens[1])) {
					title = tokens[0];
				}
			}
			if (citation != null) {
				outputValue.set(title + "\t" + citation);
				context.write(key, outputValue);
			}
		}
	}
	
	public static void main(String[] args) throws Exception {
		
		// 인자 개수 체크
		if (args.length < 3) {
			System.err.println("USAGE: JoinIDTitle {citation file} {title file} {output path}");
			return;
		}
		
		Configuration conf = new Configuration();
		Job job = new Job(conf, "Join ID and Title");	// Job 이름
		
		// 각종 초기화 설정
		job.setJarByClass(JoinIDTitle.class);
		job.setReducerClass(JoinIDTitle.MyReducer.class);	// 리듀서 클래스 지정
		job.setNumReduceTasks(1);	// 리듀스 태스크가 1개가 되도록 설정
		
		// 최종 출력물 키-밸류 형식 지정 => 리듀서가 출력하는 포맷
		// {문서ID}\t{문서 제목}\t{인용 횟수}
		job.setOutputKeyClass(Text.class);
		job.setOutputValueClass(Text.class);
		
		// 입력 데이터 처리 클래스 지정
		// 인용 횟수 파일
		MultipleInputs.addInputPath(job, new Path(args[0]),
				KeyValueTextInputFormat.class, JoinIDTitle.MyMapper1.class);
		// 제목 파일
		MultipleInputs.addInputPath(job, new Path(args[1]),
				KeyValueTextInputFormat.class, JoinIDTitle.MyMapper2.class);
		
		// 출력 데이터 처리 클래스 지정
		job.setOutputFormatClass(TextOutputFormat.class);
		
		// 입력 파일 위치 지정 => 입력 데이터 처리 클래스 지정 시 이미 설정했음
		
		// 출력 파일 위치 지정
		FileOutputFormat.setOutputPath(job, new Path(args[2]));
		
		// 잡 실행
		job.waitForCompletion(true);
	}
	
}
