# In ~/.bash_profile :
#   - define a PROJECT_PARENT_DIRS array.  e.g. 
#     PROJECT_PARENT_DIRS[0]="~/src"
#     PROJECT_PARENT_DIRS[1]="~/work"
#   - execute this file.  e.g.
#     source ~/.project_aliases.sh

if [ -z "${PROJECT_PARENT_DIRS[*]}" ]; then
	echo "Define a PROJECT_PARENT_DIRS array in ~/.bash_profile"
fi

for PARENT_DIR in ${PROJECT_PARENT_DIRS[@]} ; do
  if [ -d "$PARENT_DIR" ]; then
    for PROJECT_DIR in $(ls $PARENT_DIR); do
			if [ -d "$PARENT_DIR/$PROJECT_DIR" ]; then
	      alias "$PROJECT_DIR"="cd $PARENT_DIR/$PROJECT_DIR"
			fi
    done
  fi
done
