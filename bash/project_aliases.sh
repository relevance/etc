if [ -z "${PROJECT_DIRS[*]}" ]; then
	echo "Define a PROJECT_DIR array in your ~/.bash_profile"
fi

for PROJECT_DIR in ${PROJECT_DIRS[@]} ; do
  if [ -d "$PROJECT_DIR" ]; then
    for PROJECT in $(ls $PROJECT_DIR); do
	    alias $PROJECT="cd $PROJECT_DIR/$PROJECT"
    done
  fi
done
