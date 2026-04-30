# new-website

```txt
NAME

  new-website - A shell script to create new website projects 
                with boilerplate.

SYNOPSIS
  new-website [-f, -b] <project-name>

DESCRIPTION

  Generates a new website project with boilerplate files and 
  structure. Works with the assumption that projects are stored 
  in the ~/Projects directory. If that path does not exist, it 
  will be created.

  Without any options, it creates a basic website project with a 
  single index.html file.

  -f    Create a "full" website project
        with additional pages and assets.
        
  -b    Create a bootstrap project

  new-website my-website
  new-website -f my-full-website
  new-website -b my-bootstrap-website

AUTHOR

  NeighborhoodNerd21
  
```
