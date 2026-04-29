## set global variables

delcare PROJECTS="$HOME/Projects"

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

declare PROJECT_NAME="${args[name]}"

declare PROJECT_PATH="${PROJECTS}/${PROJECT_NAME}"

# functions for boilerplate

function html_vanilla() {
  cat <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Title</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

    <!-- Your content goes here -->

    <script src="assets/js/script.js"></script>
</body>
</html>
EOF
}

function html_bootstrap() {
  cat <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB"
      crossorigin="anonymous">
    <link rel="stylesheet" href="style.css">
</head>
<body>

    <!-- Your content goes here -->

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI"
      crossorigin="anonymous"></script>
    <script src="script.js"></script>
</body>
</html>
EOF
}

function html_404() {
  cat >>404.html <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>404 Not Found</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="container text-center">
        <h1 class="display-1">404</h1>
        <p class="lead">Page Not Found</p>
        <a href="index.html" class="btn btn-primary">Go Home</a>
    </div>
</body>
</html>
EOF
}

function css_starter() {
  cat >>style.css <<'EOF'
/* Basic CSS Reset */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}
EOF
}

function js_starter() {
  cat <<'EOF'
// Basic JavaScript Starter Code
document.addEventListener('DOMContentLoaded', () => {
    console.log('Hello, World!');
});
EOF
}

function readme_starter() {
  cat >>README.md <<'EOF'
# Project Title
# A brief description of your project.

EOF
}

function gitignore_starter() {
  cat >>.gitignore <<'EOF'
.DS_Store
EOF
}

function prettier_config() {
  cat >>.prettierrc <<'EOF'
{
  "semi": true,
  "singleQuote": true,
  "tabWidth": 2,
  "trailingComma": "es5",
  "bracketSameLine": true
}
EOF
}

function make_dirs {
  for dir in "${project_dirs[@]}"; do
    mkdir -p "$PROJECT_ROOT/$dir" || {
      echo "Error: Failed to create directory '$PROJECT_ROOT/$dir'." >&2
      exit 1
    }
  done
}

function make_html() {
  if [ "${args[--bootstrap]}" ]; then
    html_bootstrap
  else
    html_vanilla
  fi
}

function common_files() {
  html_starter >>index.html
  html_404
  readme_starter
  gitignore_starter
  prettier_config
}

function extended_files() {
  local about="${PROJECT_PATH}/${full_dirs[3]}/about.html"
  local contact="${PROJECT_PATH}/${full_dirs[3]}/contact.html"
  local gallery="${PROJECT_PATH}/${full_dirs[3]}/gallery.html"
  make_html >>"${about}"
  make_html >>"${contact}"
  make_html >>"${gallery}"
}

function basic_project() {
  common_files
}

function full_project() {
  common_files
  basic_project
  extended_files
}

# main

# check if project directory already exists
if [ -d "${PROJECT_PATH}" ]; then
  echo "Directory '${PROJECT_PATH}' already exists. Exiting."
  exit 1
fi

# set project subdirectories based on --full flag
if [ "${args[--full]}" ]; then
  project_dirs=("${full_dirs[@]}")
else
  project_dirs=("${basic_dirs[@]}")
fi

# create project directory and subdirectories
mkdir -p "${PROJECT_PATH}"
cd "${PROJECT_PATH}" || exit 1
make_dirs || exit 1
