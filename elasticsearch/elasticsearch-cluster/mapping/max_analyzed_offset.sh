#!/usr/bin/env bash
curl -XPUT "http://localhost:9200/_settings" -H 'Content-Type: application/json' -d' {
    "index" : {
        "highlight.max_analyzed_offset" : 100000000
    }
}'