#!/bin/bash

read -p "Update Framework and Dev Tools [no]: " updateFramework
if [ "$updateFramework" == "" ]; then
	updateFramework="no"
fi

if [ "$updateFramework" != "no" ]; then
	## update product repository
	echo "Aurora Platform";
	cd ../
	git fetch --all;
	git reset --hard origin/master;
	echo "";

	## update framework repository
	cd ./system
	echo "Aurora Framework";
	git fetch --all;
	git reset --hard origin/master;
	cd ../
	echo "";
	
	cd ./dev
fi

## update module repositories
cd ../modules
echo "Aurora Modules";
echo "";
for dir in $(find . -name ".git");
do
    cd ${dir%/*} > /dev/null;
    echo ${dir%/*};
    git fetch --all;
	git reset --hard origin/master;
	echo "";
    cd -  > /dev/null;
done
cd ../

## update dev-tools repository
cd ./dev
echo "Aurora Dev Tools";
git fetch --all;
git reset --hard origin/master;
echo "";

chmod +x build.sh;
chmod +x update.sh;
chmod +x update-reset.sh;
chmod +x pack.sh;
chmod +x ./docs/build-apidoc.sh;
chmod +x ./docs/build-apigen.sh;

./build.sh

read -p "Generate documentation [no]: " buildDocs
if [ "$buildDocs" == "" ]; then
	buildDocs="no"
fi

if [ "$buildDocs" != "no" ]; then
	cd ./docs
	./build-apidoc.sh
	./build-apigen.sh
fi
