function make_dirs {
  for dir in "${project_dirs[@]}"; do
    mkdir -p "$PROJECT_ROOT/$dir" || {
      echo "Error: Failed to create directory '$PROJECT_ROOT/$dir'." >&2
      exit 1
    }
  done
}
