#!/bin/sh

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
bin=${DIR}/../bin
lib=${DIR}/../lib

ES_HOST="192.168.99.100"
DB_HOST="192.168.1.3"

curl -XDELETE "${ES_HOST}:9200/dos/"
curl -XPOST "${ES_HOST}:9200/dos/"

echo '{
    "type" : "jdbc",
    "jdbc" : {
        "url" : "jdbc:postgresql://'${DB_HOST}':5432/localgravity?loglevel=0",
        "user" : "postgres",
        "password" : "pwd",
        "sql" : "select lgl_lsku as \"_id\", * from lg.venues_point_3857",
        "elasticsearch" : {
             "cluster" : "lg_es_001",
             "host" : "'${ES_HOST}'",
             "port" : 9300
        },
        "index": "dos",
        "type": "venue",
        "index_settings" : {
            "index" : {
                "number_of_shards" : 1
            }
        }
    }
}
' | java \
    -cp "${lib}/*" \
    -Dlog4j.configurationFile=${bin}/log4j2.xml \
    org.xbib.tools.Runner \
    org.xbib.tools.JDBCImporter
