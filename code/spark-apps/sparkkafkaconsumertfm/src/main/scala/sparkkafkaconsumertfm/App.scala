package sparkkafkaconsumertfm

import org.apache.commons.lang.RandomStringUtils
import org.apache.spark.SparkConf
import org.apache.spark.sql.SparkSession
import org.apache.log4j.{Level, LogManager}
import org.apache.kafka.common.serialization.StringDeserializer
import org.apache.spark.streaming.{Seconds, StreamingContext}
import org.apache.spark.streaming.kafka010.ConsumerStrategies.Subscribe
import org.apache.spark.streaming.kafka010.KafkaUtils
import org.apache.spark.streaming.kafka010.LocationStrategies.PreferConsistent

object App extends App {
  //System.setProperty("hadoop.home.dir", "C:/Users/agomez/Desktop")
  //set log4j programmatically
  LogManager.getLogger("org").setLevel(Level.ERROR)
  LogManager.getLogger("akka").setLevel(Level.ERROR)

  val sparkConf = new SparkConf()
    //Testing with local Spark
    //.setMaster("local[*]")
    //.setMaster("spark://172.16.8.234:7077")
    .setAppName("Spark-consumer-demo")

  val ssc = new StreamingContext(sparkConf, Seconds(5))

  //KAFKA-SPARK
  val kafkaServer = "172.16.8.233:31092"
  val metaInfoTopic = "tfm-topic"

  val kafkaSubscriberParams: Map[String, Object] = Map[String, Object](
    "bootstrap.servers" -> kafkaServer,
    "key.deserializer" -> classOf[StringDeserializer],
    "value.deserializer" -> classOf[StringDeserializer],
    "auto.offset.reset" -> "latest",
    "enable.auto.commit" -> (false: java.lang.Boolean),
    "group.id" -> RandomStringUtils.randomAlphabetic(10).toUpperCase // Set a unique Kafka group identifier to metaInformationStream (each stream requires a unique group ID)
  )

  /*
  //For testing with local client and cluster executor
  val sc = ssc.sparkContext
  sc.addJar("target/sparkkafkaconsumertfm-1.0-SNAPSHOT-jar-with-dependencies.jar")
  //End of testing
  */
  startMetaInfoSubscriber(ssc,kafkaSubscriberParams,  metaInfoTopic)

  // Start Spark Streaming jobs and await until they finish
  ssc.start()
  ssc.awaitTermination()
  ssc.stop(stopSparkContext = true, stopGracefully = true)


  def startMetaInfoSubscriber(ssc: StreamingContext, kafkaParams: Map[String, Object], metaInfoTopic: String) {
    KafkaUtils.createDirectStream[String, String](
      ssc,
      PreferConsistent,
      Subscribe[String, String](Array(metaInfoTopic), kafkaParams)
    ).foreachRDD(metaInfoRDD =>
      if (!metaInfoRDD.isEmpty()) {
        println("Saving MetaInformation")
        metaInfoRDD.foreach(println)
      } else {
        println("There is not any new message for topic "+metaInfoTopic)
      }
    )
  }

  object SparkSessionSingleton {

    @transient private var instance: SparkSession = _

    def getInstance(sparkConf: SparkConf): SparkSession = {

      if (instance == null) {
        instance = SparkSession
          .builder
          .config(sparkConf)
          .getOrCreate()
      }
      instance
    }
  }

}
