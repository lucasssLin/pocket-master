package com.ruoyi.recommender



case class Product( productId: Int, name: String, imageUrl: String, categories: String, tags: String )

case class Rating( userId: Int, productId: Int, score: Double, timestamp: Int )

case class MongoConfig( uri: String, db: String )

object DataLoader {
  def main(args: Array[String]): Unit = {
    val sparkConf = null
    val spark = null


    // 加载数据
    val productRDD = null
    val ratingRDD = null

    storeDataToMongoDB()

    //spark.stop()
  }

  def storeDataToMongoDB(): Unit = {
  }

}
