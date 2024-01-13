# Settings


## Installation

Clone the project and execute the installation script. It makes a copy of your original `.bashrc` and `.gitconfig` 
files that will be replaced with the local ones. You can find them in `~/old_files` (if necessary, set another name).

```bash
git clone git@github.com:ok-42/settings.git
cd settings/
bash setup.sh
```


## Functions

| Name  | Params               | Action                                          | Project-level only |
|-------|----------------------|-------------------------------------------------|--------------------|
| `gre` | Search term / Number | Search with grep / Open the n-th search result  |                    |
| `noc` | File name            | Print file without `#`-comments and blank lines |                    |
| `db`  | Container name       | Start bash in the Docker container              |                    |
| `a`   |                      | Activate Python venv and add its name to `PS1`  | +                  |
| `s`   |                      | `source .bashrc` and copy to `~/`               |                    |
| `m`   | New directory name   | `mkdir` and `cd`                                |                    |
| `new` | New project name     | Setup a template for a Python project           | `~/projects`       |
| `r`   |                      | Navigate to the project root                    | +                  |
| `e`   |                      | `source` aliases in the project root            | +                  |
| `de`  |                      | `unalias` aliases from `e` func                 |                    |
| `len` | String               | Print length of the string                      |                    |
| `ch`  |                      | Print commits count by hours (0 &ndash; 23)     | +                  |
| `gw`  | [Number]             | Print most used commit message words            | +                  |
| `chh` |                      | Visualise `ch` output                           | +                  |
| `gh`  |                      | Open the project on GitHub                      | +                  |
