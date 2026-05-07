# Claude Code Preferences

## Preferred Tools

### Text Operations

- **Text replacement**: Use `sd` instead of `sed` for find-and-replace operations
  - Syntax: `sd 'pattern' 'replacement' file.txt`
  - Better error messages, simpler syntax than sed
  - Use `-p` for preview mode before applying changes

- **Code search/refactor**: Use `ast-grep` (alias `sg`) for structural code searches
  - Syntax: `sg -p 'pattern'` or `ast-grep --pattern 'pattern'`
  - Use for: finding code patterns across syntax trees, automated refactoring
  - Better than regex for code structure - understands language semantics
  - Examples:
    - `sg -p 'function $NAME() { $$$ }'` - find all functions
    - `sg -p 'if ($COND) { $$$ }' --rewrite 'if ($COND) {\n  logger.debug($COND)\n  $$$\n}'` - add logging

### Development Workflow

- **File watching**: Use `entr` to re-run commands on file changes
  - Syntax: `ls *.py | entr pytest` or `find . -name "*.py" | entr pytest`
  - Use for: continuous testing, auto-reload workflows, watch-and-rebuild
  - More reliable than language-specific watch tools
  - Use `-c` flag to clear screen between runs: `ls *.py | entr -c pytest`
  - Use `-r` flag to restart long-running processes on change

### Additional Modern Tools Available

These are also installed and can be preferred over traditional alternatives:

- `fd` over `find` - simpler syntax, respects .gitignore
- `rg` (ripgrep) over `grep` - faster, better defaults
- `bat` over `cat` - syntax highlighting
- `delta` over `diff` - better diff formatting
- `jq` for JSON processing
- `yq` for YAML processing
- `tokei` for code statistics

## Testing Practices

### Test-Driven Development (TDD)
- **Always write tests first** when adding new features or fixing bugs
- Write the test that demonstrates the bug or requirement
- Implement the minimal code to make the test pass
- Refactor as needed while keeping tests green
- Only skip TDD for throwaway prototypes or exploratory code

### Test Execution Strategy
- **Run small focused tests** during development (e.g., `pytest tests/test_specific.py::test_function`)
- Only run full test suite if:
  - Small tests are slow (> 2-3 seconds)
  - You need to verify no regressions
  - Before committing/pushing code
- If full suite is fast (< 5 seconds), just run the full suite each time
- **CRITICAL: ALWAYS run the full test suite before declaring work complete**
  - Running a subset of tests is NOT sufficient to verify no regressions
  - Run the full test suite (e.g., `pytest`, `npm test`, `go test ./...`)
  - Work is NOT complete until you see 100% test success - ZERO failures, ZERO errors
  - Do not report work as done if there are ANY test failures
  - This has been a recurring issue - test thoroughly and verify complete success
- **Only run full test suite when expecting 100% success**
  - If there are massive known failures (e.g., 1600+ of 1850 tests), DON'T run full suite
  - Fix the root cause first, verify with targeted tests, then run full suite
  - Full suite runs are for final verification, not debugging
- **When running tests in background**: Immediately provide the user with the command to monitor progress
  - Example: "Monitor with: `tail -f /path/to/output`"
  - This allows user to catch failures early rather than waiting for completion
  - I cannot see intermediate output from background tasks, only completion notification
- **When analyzing test output, save to /tmp first**
  - BAD: `pytest 2>&1 | tail -3` (throws away failure details)
  - GOOD: `pytest > /tmp/test-output.txt 2>&1 && tail -10 /tmp/test-output.txt`
  - Then analyze: `rg "FAILED" /tmp/test-output.txt` or `tail -50 /tmp/test-output.txt`
  - Preserves full output for diagnosis while showing what we need

### Analysis and Output Management
- **Export command outputs to /tmp** for analysis instead of re-running commands
  - Example: `pytest --cov > /tmp/coverage.txt` then analyze the file
- When tests fail, export the full failure output to /tmp first
- For logs, metrics, or reports that need interpretation, save to /tmp/[descriptive-name].txt

### Test Creation for Verification
- **Create automated tests for manual verification steps**
  - When you manually verify something works (e.g., `python -c "import foo"`), immediately create a unit/integration test for it
  - This ensures the verification is repeatable and catches regressions
  - Add tests to the appropriate test directory (e.g., `minerva/tests/` for unit tests)
  - Example: After manually verifying lazy loading works, create `test_settings_lazy_loading.py`
- **Don't just validate once - codify the validation**
  - Manual checks are forgotten and not run in CI
  - Tests become documentation of expected behavior
  - Tests catch regressions when refactoring
