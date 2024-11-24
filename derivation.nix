{ python3Packages }:
with python3Packages;
buildPythonApplication {
  pname = "brightness-watcher";
  version = "1.0";
  propagatedBuildInputs = [ watchdog ];
  src = ./.;
}
