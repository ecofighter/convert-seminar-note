#!/bin/bash

latex_dir="$1"
latex_filename="$2"
outdir="$3"

latex_filename_noext="${latex_filename%.tex}"

pushd "${latex_dir}" || (echo "failed to move to ${latex_dir} with pushd"; exit 1);
if [[ ! -f $latex_filename ]]; then
    echo "${latex_filename} not found" >&2;
    exit 1;
fi

pandoc -f latex -t gfm -i "${latex_filename}" -o "${latex_filename_noext}".md
result=$?
if [[ $result -ne 0 ]]; then
    echo "pandoc failed" >&2;
    exit 1;
fi
popd || (echo "failed to move back with popd"; exit 1);

if [[ ! -d $outdir ]]; then
    mkdir -p "${outdir}";
fi
mv "${latex_dir}/${latex_filename_noext}.md" "${outdir}/";

pushd "${outdir}" || (echo "failed to move to ${outdir} with pushd"; exit 1);
csplit --prefix="${latex_filename_noext}-" --suffix-format='%02d.md' "${latex_filename_noext}.md" '/#[^#]/' "{*}"
result=$?
if [[ $result -ne 0 ]]; then
    echo "csplit failed" >&2;
    exit 1;
fi
popd || (echo "failed to move back with popd"; exit 1);
ls "${outdir}/*.md"