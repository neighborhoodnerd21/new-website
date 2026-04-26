function html_vanilla() {
  cat >>index.html <<'EOF'
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

    <script src="script.js"></script>
</body>
</html>
EOF
}

function html_bootstrap() {
  cat >>index.html <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    <link rel="stylesheet" href="style.css">
</head>
<body>

    <!-- Your content goes here -->

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
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
  cat >>script.js <<'EOF'
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
