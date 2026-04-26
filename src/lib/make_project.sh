## function that takes project_dirs and project_files as arguments and creates the directories and files
function make_dirs {
  for dir in "${project_dirs[@]}"; do
    mkdir -p "$PROJECT_ROOT/$dir"
  done
}

(cd $PROJECT_ROOT && make_dirs && make_files && exit 0) || {
  echo "Error: Failed to create project structure." >&2
  exit 1
}
