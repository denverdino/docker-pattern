#!/bin/bash

if [ ! -d "$dest" ]; then
	 mkdir "$dest"
fi 

cp ./ServletApp.war $dest/ServletApp.war