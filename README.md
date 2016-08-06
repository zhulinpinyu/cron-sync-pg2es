update db password in `code/bin/pg2es.sh` when you run in production

elasticserach version: 2.3.4

# 构建image
docker build -t cron-in-docker .

# 控制台输出方式启动
docker run --rm -it cron-in-docker

# 后台运行方式启动
docker run -d --name sync-pg2es cron-in-docker