#!/bin/bash
cd /srv/jekyll
if [[ -e Gemfile ]]; then
	echo "*** Installing Gems in Gemfile ***"
	bundle install 
	EXEC="bundle exec"
fi

if [[ $# -gt 0 ]]; then
	$EXEC jekyll $@ 
else
	if [[ ! -e _config.yml ]] ; then
		$EXEC jekyll new .
	fi
	while [ 1 ] ; do
		rm -rf _site/*
		$EXEC jekyll serve --incremental --host=0.0.0.0 # --verbose
		set -e
		echo 'Press CTRL+C now to quit'
		sleep 1
		set +e
		echo 'Restarting...'
	done
fi

