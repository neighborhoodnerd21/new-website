declare -a basic_dirs=(
  "assets"
  "assets/css"
  "assets/js"
  "assets/images"
  "assets/icons"
  "assets/fonts"
)

declare -a full_dirs=(
  "assets"
  "assets/css"
  "assets/js"
  "assets/html"
  "assets/images"
  "assets/icons"
  "assets/fonts"
)

declare -a project_dirs=()

declare PROJECT_ROOT="${args[name]}"

if [ "${args[--full]}" ]; then
  project_dirs=("${full_dirs[@]}")
  project_files=("${full_files[@]}")
else
  project_dirs=("${basic_dirs[@]}")
  project_files=("${basic_files[@]}")
fi
