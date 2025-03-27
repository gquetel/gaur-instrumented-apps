# gaur-instrumented-apps

A collection of gaur instrumented applications. Instrumented applications are built using nixpkgs and the patch mechanism. Instrumented application are built using `nix-build`.   
The build phase possess two steps: the building of a custom bison (for which we simply add custom [skeletons](./bison-skeletons/)) and then the building of the instrumented application on which we apply our custom patch which replace the original bison grammar, by an instrumented one.