#! /bin/bash
docker-compose --env-file docker-compose.env -f docker-compose.yaml build
docker-compose --env-file docker-compose.env -f docker-compose.yaml up -d
