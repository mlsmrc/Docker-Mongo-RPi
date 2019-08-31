mongod &
sleep 20

for f in /docker-entrypoint-initdb.d/*; do
			case "$f" in
				*.sh) echo "$0: running $f"; . "$f" ;;
				*.js) echo "$0: running $f"; mongo admin "$f"; echo ;;
				*)    echo "$0: ignoring $f" ;;
			esac
			sleep 5
		done

echo "Restarting mongod"
mongod --shutdown
mongod
