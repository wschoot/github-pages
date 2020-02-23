#!/bin/bash
set -x
cd /root/project
if [[ $# -gt 0 ]]; then
	jekyll $@ 
else
	if [[ ! -e _config.yml ]] ; then
		jekyll new .
	fi
	while [ 1 ] ; do
		rm -rf _site/*
		jekyll serve --incremental --host=0.0.0.0 # --verbose
		set -e
		echo 'Press CTRL+C now to quit'
		sleep 1
		set +e
		echo 'Restarting...'
	done
fi

