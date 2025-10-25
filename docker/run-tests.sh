#!/usr/bin/env bash
# build and run tests for Dockerfile.* images from the docker/ directory.
# usage (bash / WSL):
#   ./run-tests.sh        # builds & runs all Dockerfile.*
#   ./run-tests.sh fedora # builds & runs Dockerfile.fedora

set -euo pipefail
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
workspace="$(cd "$script_dir/.." && pwd)"

if [ $# -eq 0 ]; then
  files=("$script_dir"/Dockerfile.*)
else
  files=("$script_dir"/Dockerfile.$1*)
fi

out_subdir="${2-}"
out_root="$workspace/out"
if [ -n "$out_subdir" ]; then
  out_dir="$out_root/$out_subdir"
else
  out_dir="$out_root"
fi
mkdir -p "$out_dir"

env_opt=()
if [ -n "$out_subdir" ]; then
  env_opt+=( -e "OUT_SUBDIR=$out_subdir" )
fi

for df in "${files[@]}"; do
  [ -e "$df" ] || continue
  tag="flang-${df##*.}"
  echo "\n==== Building $df -> $tag ===="
  docker build -f "$df" -t "$tag" "$workspace"

  echo "Running tests in $tag (logs -> $out_dir/$tag.log)"
  echo "Artifacts and object files will be created under: $out_dir"

  out_host_root="$out_root"

  mkdir -p "$src_host" "$install_host" "$out_root" "$out_dir"

  run_opts=(--rm)

  run_opts+=( -v "$workspace:/work:ro" )
  run_opts+=( -v "$out_host_root:/work/out" )
  run_opts+=( -w /work )

  # `set -o pipefail` is enabled at the top of the script so the pipeline exit
  # status will reflect the docker run exit code.
  if docker run "${run_opts[@]}" "${env_opt[@]}" "$tag" bash -c "./run_flang.sh" 2>&1 | tee "$out_dir/$tag.log"; then
    echo "Tests passed in $tag (logs: $out_dir/$tag.log)"
  else
    echo "Tests failed in $tag (logs: $out_dir/$tag.log)"
  fi
done
