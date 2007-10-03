## Sets up an environmental variable for the cache directory
export CACHE_BASE_DIR="${HOME}/.homedir/cache"

function getHomedirCache() {
    set -eu
    PROGRAM="$1"
    shift
    DIR="${CACHE_BASE_DIR}/${PROGRAM}"
    if [ ! -d "${DIR}" ]; then
        mkdir "${DIR}"
    fi
    echo "${DIR}"
}

# Fetches a file
function homedirFetcher() {
    set -eu
    URL="$1"
    shift
    OUTFILE="$1"
    shift
    AGE="$1"
    shift
    
    md5sum='none'
    if [ -e "${OUTFILE}" ]; then
        doFetch=$(find "${OUTFILE}" -ctime +${AGE} -print)
        if [ -n "${doFetch}" ]; then
            md5sum=$(md5sum "${OUTFILE}")
        fi
    else
        doFetch=1
    fi

    if [ -n "${doFetch}" ]; then
        wget -q -O "${OUTFILE}" "${URL}"
        #curl -o "${OUTFILE}" "${URL}"
        #lynx -source "${URL}" > "${OUTFILE}"
        newmd5sum=$(md5sum "${OUTFILE}")
        if [ "${md5sum}" = "${newmd5sum}" ]; then
            echo "cached"
        else
            echo "fetched"
        fi
    else
        echo "cached"
    fi
}

#EOF
