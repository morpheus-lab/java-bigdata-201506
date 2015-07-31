import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.SequenceFile;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.input.KeyValueTextInputFormat;
import org.apache.hadoop.mapreduce.lib.output.SequenceFileOutputFormat;


public class StringSort {
	
	public static void main(String[] args) throws Exception {
		Configuration conf = new Configuration();
		Job job = new Job(conf, "StringSort");
		
		// 각종 초기화 설정
		job.setJarByClass(StringSort.class);
		job.setMapperClass(Mapper.class);	// 맵퍼 클래스 지정
		job.setReducerClass(Reducer.class);	// 리듀서 클래스 지정
		job.setNumReduceTasks(1);	// 리듀스 태스크가 1개가 되도록 설정
		
		// 맵 출력물 키-밸류 형식 지정
		job.setMapOutputKeyClass(Text.class);
		job.setMapOutputValueClass(Text.class);
		
		// 최종 출력물 키-밸류 형식 지정
		job.setOutputKeyClass(Text.class);
		job.setOutputValueClass(Text.class);
		
		// 입력 데이터 처리 클래스 지정
		job.setInputFormatClass(KeyValueTextInputFormat.class);
		
		// 출력 데이터 처리 클래스 지정
		job.setOutputFormatClass(SequenceFileOutputFormat.class);
		
		// 입력 파일 위치 지정
		FileInputFormat.addInputPath(job, new Path(args[0]));
		
		// 출력 파일 위치 지정
		SequenceFileOutputFormat.setOutputPath(job, new Path(args[1]));
		// 출력 파일을 블록 단위로 압축
		SequenceFileOutputFormat.setOutputCompressionType(job, SequenceFile.CompressionType.BLOCK);
		
		// 잡 실행
		job.waitForCompletion(true);
	}
	
}
