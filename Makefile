watch_urls:
	./helpers/url_watcher.sh &

ssh:
	vagrant ssh

start: watch_urls ssh
	echo "Starting"

