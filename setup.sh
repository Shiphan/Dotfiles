# system config directory
configDir="$HOME/.config"
# new config directory
dotconfigDir="./dotconfig"

ls $dotconfigDir
echo
find ./dotconfig/ -type f

echo
echo "$(find ./dotconfig/ -type f | wc -l) file(s) will be copy to $configDir"

echo
echo "this process may replace some file."
echo "make sure to bake up important files in $configDir."
echo

read -p ":: Proceed with copying? [y/N] " yn
case $yn in
    [Yy]* ) ;;
    * ) exit;;
esac

echo "copying $((replaceCount + newCount)) file(s) from $dotconfigDir to $configDir..."

# copy to config directory
cp -r $dotconfigDir $configDir

echo "not copying"
echo "done"
