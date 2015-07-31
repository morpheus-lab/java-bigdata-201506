import java.io.DataInput;
import java.io.DataOutput;
import java.io.IOException;
import java.util.ArrayList;
import java.util.PriorityQueue;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.io.WritableComparable;
import org.apache.hadoop.io.WritableUtils;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.input.KeyValueTextInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.mapreduce.lib.output.TextOutputFormat;


public class TopN {
	
	public static class Item implements WritableComparable<TopN.Item> {
		private String word;
		private Long count;
		
		public Item() {}
		public Item(String word, Long count) { this.word = word; this.count = count; }
		
		public void readFields(DataInput in) throws IOException {	// deserialize 때 사용되는 메소드
			word = WritableUtils.readString(in);
			count = in.readLong();
		}
		public void write(DataOutput out) throws IOException {	// serialize 때 사용되는 메소드
			WritableUtils.writeString(out, word);
			out.writeLong(count);
		}
		public int compareTo(Item o) {	// Item 순위 비교 시 사용되는 메소드
			return (int)(this.count - o.count);
		}
		public String getWord() {
			return word;
		}
		public void setWord(String word) {
			this.word = word;
		}
		public Long getCount() {
			return count;
		}
		public void setCount(Long count) {
			this.count = count;
		}
	}
	
	public static class MyMapper extends Mapper<Text, Text, Text, LongWritable> {
		private int topN;
		private PriorityQueue<TopN.Item> queue;
		
		@Override
		public void setup(
				Mapper<Text, Text, Text, LongWritable>.Context context)
				throws IOException, InterruptedException {
			topN = context.getConfiguration().getInt("topN", 10);
			queue = new PriorityQueue<TopN.Item>(topN);
		}
		
		@Override
		public void map(Text key, Text value,
				Mapper<Text, Text, Text, LongWritable>.Context context)
				throws IOException, InterruptedException {
			// 새로 들어온 데이터
			String word = key.toString();
			Long count = Long.parseLong(value.toString());
			
			Item head = queue.peek();	// 기존 단어 중 빈도 수가 가장 작은 놈
			
			if (queue.size() < topN || head.count < count) {
				Item item = new Item(word, count);
				queue.add(item);
			}
			if (queue.size() > topN) {
				queue.remove();
			}
		}
		
		@Override
		public void cleanup(
				Mapper<Text, Text, Text, LongWritable>.Context context)
				throws IOException, InterruptedException {
			ArrayList<Item> list = new ArrayList<TopN.Item>();
			while (queue.size() != 0) {
				list.add(queue.remove());
			}
			Text key = new Text();
			LongWritable value = new LongWritable();
			for (int i = list.size() - 1; i > -1; i--) {
				Item item = list.get(i);
				key.set(item.getWord());
				value.set(item.getCount());
				context.write(key, value);
			}
		}
	}
	
	public static class MyReducer extends Reducer<Text, LongWritable, Text, LongWritable> {
		
	}
	
	public static void main(String[] args) throws Exception {
		Configuration conf = new Configuration();
		Job job = new Job(conf, "TopN");
		
		// 각종 초기화 설정
		job.setJarByClass(TopN.class);
		job.setMapperClass(TopN.MyMapper.class);	// 맵퍼 클래스 지정
		job.setReducerClass(TopN.MyReducer.class);	// 리듀서 클래스 지정
		job.setNumReduceTasks(1);	// 리듀스 태스크가 1개가 되도록 설정
		
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
		
		// N을 입력 받아 설정
		job.getConfiguration().setInt("topN", Integer.parseInt(args[2]));
		
		// 잡 실행
		job.waitForCompletion(true);
	}
	
}





























