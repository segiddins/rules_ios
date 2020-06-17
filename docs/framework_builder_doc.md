<!-- Generated with Stardoc: http://skydoc.bazel.build -->

<a name="#build_carthage_frameworks"></a>

## build_carthage_frameworks

<pre>
build_carthage_frameworks(<a href="#build_carthage_frameworks-name">name</a>, <a href="#build_carthage_frameworks-carthage_version">carthage_version</a>, <a href="#build_carthage_frameworks-git_repository_url">git_repository_url</a>, <a href="#build_carthage_frameworks-directory">directory</a>, <a href="#build_carthage_frameworks-files">files</a>, <a href="#build_carthage_frameworks-cmd">cmd</a>,
                          <a href="#build_carthage_frameworks-verbose">verbose</a>)
</pre>

    Builds the frameworks for the libraries specified in a Cartfile

**PARAMETERS**


| Name  | Description | Default Value |
| :-------------: | :-------------: | :-------------: |
| name |  the rule name   |  none |
| carthage_version |  the carthage version to use   |  none |
| git_repository_url |  the carthage repository to use   |  <code>"https://github.com/Carthage/Carthage.git"</code> |
| directory |  the path to the directory containing the carthage setup   |  <code>""</code> |
| files |  the files required for carthage to run   |  <code>["Cartfile"]</code> |
| cmd |  the command to run and install carthage   |  <code>"\n        git clone --branch %s --depth 1 %s carthage_repo\n        swift run --package-path carthage_repo carthage bootstrap --no-use-binaries --platform iOS\n        "</code> |
| verbose |  if true, it will show the output of running carthage in the command line   |  <code>False</code> |


<a name="#build_cocoapods_frameworks"></a>

## build_cocoapods_frameworks

<pre>
build_cocoapods_frameworks(<a href="#build_cocoapods_frameworks-name">name</a>, <a href="#build_cocoapods_frameworks-directory">directory</a>, <a href="#build_cocoapods_frameworks-files">files</a>, <a href="#build_cocoapods_frameworks-cmd">cmd</a>, <a href="#build_cocoapods_frameworks-verbose">verbose</a>)
</pre>

    Builds the frameworks for the pods specified in a Podfile that are using the [cocoapods-binary plugin](https://github.com/leavez/cocoapods-binary)

**PARAMETERS**


| Name  | Description | Default Value |
| :-------------: | :-------------: | :-------------: |
| name |  the rule name   |  none |
| directory |  the path to the directory containing the cocoapods setup   |  <code>""</code> |
| files |  the files required for cocoapods to run   |  <code>["Podfile", "Gemfile"]</code> |
| cmd |  the command to install and run cocoapods   |  <code>"\n        bundle install\n        bundle exec pod install\n        "</code> |
| verbose |  if true, it will show the output of running cocoapods in the command line   |  <code>False</code> |

