package sparkkafkaproducertfm

import java.util.Properties

import org.apache.kafka.clients.producer.{KafkaProducer, ProducerRecord}
import org.apache.log4j.{Level, LogManager}
import org.apache.spark.SparkConf
import org.apache.spark.sql.SparkSession
import org.apache.spark.streaming.kafka010.ConsumerStrategies.Subscribe
import org.apache.spark.streaming.kafka010.KafkaUtils
import org.apache.spark.streaming.kafka010.LocationStrategies.PreferConsistent
import org.apache.spark.streaming.{Seconds, StreamingContext}
import sparkkafkaproducertfm.App.{metaInfoTopic, props}


object App extends App {
  //set log4j programmatically
  LogManager.getLogger("org").setLevel(Level.ERROR)
  LogManager.getLogger("akka").setLevel(Level.ERROR)

  val sparkConf = new SparkConf()
    //Testing with local Spark
    //.setMaster("local[*]")
    //.setMaster("spark://172.16.8.234:7077")
    .setAppName("Spark-producer-demo")

  val ssc = new StreamingContext(sparkConf, Seconds(5))

  //KAFKA-SPARK
  val kafkaServer = "172.16.8.233:31092"
  val metaInfoTopic = "tfm-demo-topic"

  val  props = new Properties()
  props.put("bootstrap.servers", "172.16.8.233:31092")
  props.put("key.serializer", "org.apache.kafka.common.serialization.StringSerializer")
  props.put("value.serializer", "org.apache.kafka.common.serialization.StringSerializer")

  /*
  //For testing with local client and cluster executors
  val sc = ssc.sparkContext
  sc.addJar("target/sparkkafkaproducertfm-1.0-SNAPSHOT-jar-with-dependencies.jar")
  //End of testing
  */

  startMetaInfoPublisher(ssc,props,  metaInfoTopic)

  // Start Spark Streaming jobs and await until they finish
  ssc.start()
  ssc.awaitTermination()
  ssc.stop(stopSparkContext = true, stopGracefully = true)


  def startMetaInfoPublisher(ssc: StreamingContext, props: Properties, metaInfoTopic: String) {

    val producer = new KafkaProducer[String, String](props)

    var cont = 0

    while(true){
      try {
        println("intentando mandar mensaje " + cont + "...")
        val valor_a_envia = "TFM Demo Message " + cont
        val record = new ProducerRecord[String,String](metaInfoTopic, valor_a_envia)
        producer.send(record)
        println("\tMensaje " + cont + " enviado")

        cont += 1

        //Thread.sleep(1)

      } catch {
        case ex:InterruptedException => println("Error in log generating sleeping process: ")
        case a:Throwable => a.printStackTrace()
      }
    }
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
