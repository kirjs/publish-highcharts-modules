#!/bin/bash
#
# This scripts collects all highcharts modules, and for each publishes an npm module.
#
# e.g. highcharts-more
#
#

dir="./modules/"
node_modules_dir="../node_modules/"

# Clean up first
echo "clean up."
rm -rf $dir
mkdir $dir
cd $dir
echo "folder created."


# Generate list of modules
list="../modules.md"
echo "# List of generated modules " > $list
echo "" >> $list

function generate {

  # Iterate ove a list of files
  for path in $@ ; do

    # only get filename e.g. file.js
    file="${path##*/}"
    # Get rid of .src e.g file.src.js -> file.js
    file=${file/.src/}
    # Get rid of 'highcharts-' prefix e.g highcharts-more.js -> more.js
    file=${file/highcharts-/}



    name="highcharts-${file/.js/}";

    if [ ! -e "./$name" ]; then
      echo "Adding $name";

      # extract module name from path, e.g. highcharts-release
      module=${path/$node_modules_dir/}
      module=${module/modules\//}
      module="${module%/*}"

      version="0.0.3" # $(npm info $module version)


      mkdir $name


      # Copy the actual JS file
      cp $path $name/$file

      # Copy package.json and replace the variables
      packageFile="$name/package.json"
      cp ../package.json.tpl $packageFile
      sed -i '' "s/{name}/$name/" $packageFile
      sed -i '' "s/{version}/$version/" $packageFile
      sed -i '' "s/{module}/$module/" $packageFile

      # Copy README and replace the variables
      readmeFile="$name/README.md"
      cp ../README.md.tpl $readmeFile
      sed -i '' "s/{name}/$name/" $readmeFile
      sed -i '' "s/{version}/$version/" $readmeFile
      sed -i '' "s/{module}/$module/" $readmeFile

      cd $name
      npm publish
      cd ..

      echo "## $name" >> $list
      echo "[npm link](https://www.npmjs.com/package/$name)"@$version >> $list
      echo '`npm install $name`' >> $list
      echo "" >> $list

    fi
  done
}

generate "${node_modules_dir}highcharts-release/modules/*"
generate "${node_modules_dir}highstock-release/modules/*"
generate "${node_modules_dir}highmaps-release/modules/*"
generate "${node_modules_dir}highcharts-release/highcharts-*.js"
