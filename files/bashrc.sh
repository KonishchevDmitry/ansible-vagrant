. /etc/skel/.bashrc

if [ -d ~/.bashrc.d ]; then
    nullglob="$(shopt -p nullglob)"
    shopt -s nullglob

    for file in ~/.bashrc.d/*.sh; do
        . $file
    done

    $nullglob
    unset file
    unset nullglob
fi