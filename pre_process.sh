# comment all including library
for name in /Users/mengzeli/Desktop/BMC_using_ML/array-memsafety/*.c; do
  sed -i '' -e 's,#include,//&,g' $name
done
