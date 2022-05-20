# remove the previous generated fv
rm fv.csv
# add the hearder name of each column
python initial_fv_csv.py
# generate new feature vector
for name in /Users/mengzeli/Desktop/BMC_using_ML/array-memsafety/add_last_unsafe.c; do
  # feature vectors from C file
  clang -cc1 -ast-dump $name > ast_tree.txt
  tr '[:space:]' '[\n*]' < ast_tree.txt | grep -i -c IfStmt > fv.txt
  tr '[:space:]' '[\n*]' < ast_tree.txt | grep -i -c WhileStmt >> fv.txt
  tr '[:space:]' '[\n*]' < ast_tree.txt | grep -i -c DoStmt >> fv.txt
  tr '[:space:]' '[\n*]' < ast_tree.txt | grep -i -c ForStmt >> fv.txt
  tr '[:space:]' '[\n*]' < ast_tree.txt | grep -i -c DeclStmt >>fv.txt
  tr '[:space:]' '[\n*]' < ast_tree.txt | grep -i -c VarDecl >>fv.txt
  tr '[:space:]' '[\n*]' < ast_tree.txt | grep -i -c FunctionDecl >>fv.txt
  tr '[:space:]' '[\n*]' < ast_tree.txt | grep -i -c CallExpr >>fv.txt
  tr '[:space:]' '[\n*]' < ast_tree.txt | grep -i -c LabelStmt >>fv.txt

  # feature vectors from benchmarks, one C file has 239 benchmarks
  # in this case, one C file contain 239 feature vectors
  export name
  ./pv.sh
done
