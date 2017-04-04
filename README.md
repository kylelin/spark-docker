# Spark In Action

These docker images is used for quick constructing Spark 2.1.0 and Hadoop 2.6.5 base test environment.   
Spark and Hadoop cluster is assembled by `docker-compose` (v2.1).

#### Three images.

 - `ypenglyn/hadoop:2.6.5`, Hadoop
 - `ypenglyn/spark:2.1.0`, Spark
 - `ypenglyn/env:0.0.1`, test client environment for connecting Spark and Hadoop

#### Howto

If you installed make in system, then hit `make`.

```
$  make
up:     ## docker-compose up to background
logs:   ## docker-compose tail container logs
ps:     ## docker container list
down:   ## docker-compose down
client: ## docker attach with client where you can play with hdfs and spark
scale:  ## make scale type=datanode size=3 or make scale type=sparkslave size=2
```

#### Example

##### 1. Start cluster

```
make up
```
##### 2. Start client

```
make client
```

use CTRL-p & CTRL-q to detach from client.

##### 3. Update file to HDFS

```
$ make client
docker-compose exec client bash
root@spark-in-action:/workspace# hdfs dfs -put ./volume/smart_email_training.txt /
```

Check file from http://localhost:50070/explorer.html#/

##### 4. Use Spark shell

```
$ make client
docker-compose exec client bash
root@spark-in-action:/workspace# spark-shell --master spark://spark-master:7077
```

Check spark job from http://localhost:8080/

Now, try the following word count example from spark-shell.
```
val textFile = sc.textFile("hdfs://hdfs-namenode:9000/smart_email_training.txt")
val counts = textFile.flatMap(line => line.split(" ")).map(word => (word, 1)).reduceByKey(_ + _)
counts.top(5)
```

##### 5. Scale out cluster

```
# scale out hadoop to 3 datanode (default: 1)
make scale type=datanote size=3

# scale out spark to 3 slave (defalut: 1)
make scale type=sparkslave size=3
```

##### 6. Clean up cluster

```
make down
```
