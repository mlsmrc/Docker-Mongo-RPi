mongod &
sleep 20

# Running file in entrypoint folder
for f in /docker-entrypoint-initdb.d/*; do
			case "$f" in
				*.sh) echo "$0: running $f"; . "$f" ;;
				*.js) echo "$0: running $f"; mongo admin "$f"; echo ;;
				*)    echo "$0: ignoring $f" ;;
			esac
			echo
			sleep 1
		done

# Initialize the DB with INITDB parameters
[ ! -z "$MONGO_INITDB_DATABASE" ] && \
[ ! -z "$MONGO_INITDB_ROOT_PASSWORD" ] && \
[ ! -z "$MONGO_INITDB_ROOT_USERNAME" ] && cat initDB.mongo 	| sed "s/##DB##/$MONGO_INITDB_DATABASE/g" \
		 						| sed "s/##P##/$MONGO_INITDB_ROOT_PASSWORD/g" \
		 						| sed "s/##U##/$MONGO_INITDB_ROOT_USERNAME/g" | mongo

# Restarting mongod
echo "Restarting mongod"
mongod --shutdown
mongod