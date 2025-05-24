#!/bin/bash
### COMMON SETUP; DO NOT MODIFY ###
set -e

# --- CONFIGURE THIS SECTION ---
# Replace this with your command to run all tests
run_all_tests() {
  echo "Running all tests..."
  cd /app
  drivers=(nifake nidcpower nidigital nidmm nifgen nirfsg niscope niswitch nise nimodinst nitclk)
  # Add each driver path so tests can import directly if wheels are missing
  for driver in "${drivers[@]}"; do
    PYTHONPATH="/app/generated/$driver:${PYTHONPATH}"
  done
  export PYTHONPATH
  set +e
  pytest -vv generated/*/*/unit_tests || true
  set -e
}

# Replace this with your command to run specific test files
run_selected_tests() {
  local test_files=("$@")
  echo "Running selected tests: ${test_files[@]}"
  cd /app
  drivers=(nifake nidcpower nidigital nidmm nifgen nirfsg niscope niswitch nise nimodinst nitclk)
  for driver in "${drivers[@]}"; do
    PYTHONPATH="/app/generated/$driver:${PYTHONPATH}"
  done
  export PYTHONPATH
  set +e
  pytest -vv "${test_files[@]}" || true
  set -e
}
# --- END CONFIGURATION SECTION ---


### COMMON EXECUTION; DO NOT MODIFY ###

# No args is all tests
if [ $# -eq 0 ]; then
  run_all_tests
  exit $?
fi

# Handle comma-separated input
if [[ "$1" == *","* ]]; then
  IFS=',' read -r -a TEST_FILES <<< "$1"
else
  TEST_FILES=("$@")
fi

# Run them all together
run_selected_tests "${TEST_FILES[@]}"
