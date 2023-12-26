# Description

A simple script for my needs. Allows you to manage project URLs and open them conveniently.

# Installation

1. Clone repository to a directory of your choice

2. Add the following lines to `.zshrc`:
    ```shell
    source path/to/urls_autocomplete.sh  # for auto completions
    alias urls=path/to/urls.sh
    ```

# Usage

1. Open your project's directory

2. Run `urls add` to create `.urls` file in the directory

3. Edit `.urls` to add base URLs of your project. Example:
    ```shell
    # URL_KEY=base_url
    GOOGLE=google.com  # NOT `http://google.com`
    ```

    You can also add base URLs using the `add` command:
    ```shell
    % urls add GOOGLE=google.com OTHER=example.com ...
    % urls  # this command basically calls `cat` for `.urls`
    GOOGLE=google.com
    OTHER=example.com
    ...
    ```

4. Run `urls` to see base URLs of your project. This command basically calls `cat` for `.urls` file. `urls` looks for `.urls` file in the working directory. If there is no such file, it looks recursively for it in the parent directories.

5. Run `urls %URL_KEY%` to open the URL with `URL_KEY` key in `.urls`. Example:
    ```shell
    % urls GOOGLE
    http://google.com
    ```

    It will open `http://google.com`.

6. Specify modifier argument to modify the base URL. Now there are three modifiers, namely `admin`, `api` and `django`
    ```
    % urls GOOGLE
    http://google.com
    % urls GOOGLE admin
    http://admin.google.com
    % urls GOOGLE api
    http://api.google.com/docs
    % urls GOOGLE django
    http://api.google.com/admin
    ```
    
    The logic of base URL modification is defined in `dispatch` function of `urls.sh`. You can modify it to meet your needs.
