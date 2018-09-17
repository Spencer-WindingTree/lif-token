mkdir -p docs .flattened
rm docs/*.md
for f in $(find contracts -name *.sol)
  do if [ `basename $f` != "Migrations.sol" ] \
    && [ `basename $f` != "LifTokenTest.sol" ] \
    && [ `basename $f` != "Message.sol" ] \
    && [ `basename $f` != "TGEDeployer.sol" ] \
    && [ `basename $f` != "Imports.sol" ] \
    && [ `basename $f` != "LifTokenMock.sol" ]; then
    file=`basename $f`
    filename="${file%.*}"
    node_modules/.bin/truffle-flattener "$f" > .flattened/"$file"
    node_modules/.bin/solmd .flattened/"$file" --dest docs/"$filename".md
  fi
done
rm -r .flattened
