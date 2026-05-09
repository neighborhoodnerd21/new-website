## set global variables

declare -g PROJECTS="$HOME/Projects"
declare -g -a project_dirs=()
declare -g PROJECT_NAME=""
declare -g -a projects=()

declare -g -a basic_dirs=(
  "assets"
  "assets/css"
  "assets/js"
  "assets/images"
  "assets/icons"
  "assets/fonts"
)

declare -g -a full_dirs=(
  "assets"
  "assets/css"
  "assets/js"
  "assets/html"
  "assets/images"
  "assets/icons"
  "assets/fonts"
)

# functions for boilerplate

function html_vanilla() {
  cat <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Title</title>
    <link rel="stylesheet" href="./assets/css/style.css">
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
    <link rel="stylesheet" href="./assets/css/style.css">
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
  cat <<'EOF'
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
  cat <<'EOF'
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
  cat <<'EOF'
# Project Title
# A brief description of your project.

EOF
}

function gitignore_starter() {
  cat <<'EOF'
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
    mkdir -p "${PROJECT_PATH}/${dir}" || {
      echo "Error: Failed to create directory '${PROJECT_PATH}/${dir}'." >&2
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

function common_sitefiles() {
  make_html >>"${PROJECT_PATH}/index.html"
  html_404 >>"${PROJECT_PATH}/404.html"
  readme_starter >>"${PROJECT_PATH}/README.md"
  gitignore_starter >>"${PROJECT_PATH}/.gitignore"
  prettier_config >>"${PROJECT_PATH}/.prettierrc"
}

function extended_sitefiles() {
  declare -a files=(about.html contact.html gallery.html)
  for file in "${files[@]}"; do
    local path
    path="${PROJECT_PATH}/${full_dirs[3]}/$file"
    make_html >>"${path}"
  done
}

function basic_sitefiles() {
  common_sitefiles
  css_starter >>"${PROJECT_PATH}/assets/css/style.css"
  js_starter >>"${PROJECT_PATH}/assets/js/script.js"
}

function full_sitefiles() {
  basic_sitefiles
  extended_sitefiles
}

# main
function main() {
  local PROJECT_PATH="${PROJECTS}/${PROJECT_NAME}"
  echo "Creating project '${PROJECT_NAME}' at '${PROJECT_PATH}'..."
  # check if projects directory exists, create if not

  # check if project directory already exists
  if [ -d "${PROJECT_PATH}" ]; then
    echo "Directory '${PROJECT_PATH}' already exists. Exiting."
    exit 1
  fi

  # create project directory and subdirectories
  mkdir -p "${PROJECT_PATH}" || {
    echo "Error: Failed to create directory '${PROJECT_PATH}'." >&2
    exit 1
  }
  cd "${PROJECT_PATH}" || {
    echo "Error: Failed to change directory to '${PROJECT_PATH}'." >&2
    exit 1
  }

  # set project subdirectories and choose files based on --full flag
  if [ "${args[--full]}" ]; then
    project_dirs=("${full_dirs[@]}")
    make_dirs || {
      echo "Error: Failed to create subdirectories." >&2
      exit 1
    }
    full_sitefiles || {
      echo "Error: Failed to create site files." >&2
      exit 1
    }
  else
    project_dirs=("${basic_dirs[@]}")
    make_dirs || {
      echo "Error: Failed to create subdirectories." >&2
      exit 1
    }
    basic_sitefiles || {
      echo "Error: Failed to create site files." >&2
      exit 1
    }
  fi
}

if [ ! -d "${PROJECTS}" ]; then
  echo "Projects directory not found. Creating now..."
  mkdir "${PROJECTS}" || {
    echo "Error: Failed to create projects directory '${PROJECTS}'." >&2
    exit 1
  }
fi

if [ -p /dev/stdin ]; then
  readarray -t projects
elif [[ -n "${args[name]}" ]]; then
  IFS=',' read -ra projects <<<"${args[name]}"
else
  echo "Error: No valid input provided. Please provide a project name."
  exit 1
fi

for p in "${projects[@]}"; do
  if [[ -z "$p" ]]; then
    echo "Error: project names cannot be empty." >&2
    exit 1
  elif [[ "$p" == *"/"* ]]; then
    echo "Error: '$p' contains a forward slash (/)." >&2
    exit 1
  else
    PROJECT_NAME="$p"
    main
  fi
done

exit 0
