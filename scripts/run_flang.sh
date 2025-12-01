# - continue on error, print errors and keep going

set -u
SRC_DIR="./src"
# If OUT_SUBDIR is set, put outputs under ./out/<OUT_SUBDIR>
OUT_DIR="./out"
if [ -n "${OUT_SUBDIR-}" ]; then
  OUT_DIR="./out/${OUT_SUBDIR}"
fi
FLANG="${FLANG:-./install/bin/flang}"
LOGFILE="$OUT_DIR/run_flang.log"

mkdir -p "$OUT_DIR"
touch "$LOGFILE" # keep log, don't truncate

printf "Outputs and logs will be written to: %s\n" "$OUT_DIR" | tee -a "$LOGFILE"

# run cmd, log stdout+stderr, continue on error
run_cmd() {
  # util: prefix each line with timestamp and print
  prefix_and_append() {
    # first arg: output fd (default stdout)
    local out_fd=${1:-1}
    # read lines, prefix timestamp, send onward
    while IFS= read -r _line; do
      printf "[%s] %s\n" "$(date '+%Y-%m-%d %H:%M:%S')" "$_line"
    done
  }

  # log header and cmd with timestamp
  printf "[%s] %s\n" "$(date '+%Y-%m-%d %H:%M:%S')" "================================================================" | tee -a "$LOGFILE"
  printf "[%s] ==> %s\n" "$(date '+%Y-%m-%d %H:%M:%S')" "$*" | tee -a "$LOGFILE"

  tmpfile=$(mktemp 2>/dev/null || printf "%s" "$OUT_DIR/run_flang.$$")
  if "$@" >"$tmpfile" 2>&1; then
    # on success: print to stdout and append to log
    prefix_and_append < "$tmpfile" | tee -a "$LOGFILE"
    rm -f "$tmpfile" 2>/dev/null || true
    return 0
  else
    rc=$?
    # on failure: print to stderr and append to log
    prefix_and_append < "$tmpfile" | tee -a "$LOGFILE" >&2
    printf "[%s] ERROR: command exited with code %d: %s\n" "$(date '+%Y-%m-%d %H:%M:%S')" "$rc" "$*" | tee -a "$LOGFILE" >&2
    rm -f "$tmpfile" 2>/dev/null || true
    return $rc
  fi
}

# commands to run
run_cmd "$FLANG" -###
run_cmd "$FLANG" "$SRC_DIR/main.f08" -o "$OUT_DIR/main-f"
run_cmd "$FLANG" -c "$SRC_DIR/foo.f08" -o "$OUT_DIR/foo.o"
run_cmd "$FLANG" "$SRC_DIR/main.f08" "$OUT_DIR/foo.o" -o "$OUT_DIR/main-f" -###
run_cmd "$FLANG" "$SRC_DIR/main.f08" "$OUT_DIR/foo.o" -o "$OUT_DIR/main-f"
# run_cmd gfortran "$SRC_DIR/main.f08" "$OUT_DIR/foo.o" -o "$OUT_DIR/main-f"
# run_cmd "$FLANG" "$SRC_DIR/main.f08" "$OUT_DIR/foo.o" -o "$OUT_DIR/main-f" --target=x86_64-unknown-linux-musl

# run binary if exists and executable
if [ -x "$OUT_DIR/main-f" ]; then
  run_cmd "$OUT_DIR/main-f"
else
  echo "Skipping execution: $OUT_DIR/main-f not found or not executable" | tee -a "$LOGFILE" >&2
fi

run_cmd cc "$SRC_DIR/main.c" "$OUT_DIR/foo.o" -o "$OUT_DIR/main-c"
if [ -x "$OUT_DIR/main-c" ]; then
  run_cmd "$OUT_DIR/main-c"
else
  echo "Skipping execution: $OUT_DIR/main-c not found or not executable" | tee -a "$LOGFILE" >&2
fi

echo "Done. Full log: $LOGFILE"
