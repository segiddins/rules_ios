def _is_apple_resource_file(file, extensions_to_filter):
    if file.extension in extensions_to_filter:
        return False

    return True

# Remvoe files whose parent folders are already in the list. E.g., when both "foo/" and "foo/bar"
# are in the files list, we should only return "foo/". This de-duplication is needed after this
# rules-apple PR: https://github.com/bazelbuild/rules_apple/pull/1311. Otherwise 'clonefile' will
# raise exceptions when both "foo/" and "foo/bar" are copied.
def _deduplicate_paths(files):
    unique_files = []
    prev_file = None
    for file in sorted(files):
        if prev_file and file.path.startswith(prev_file.path):
            # prev_file, i.e., some parent directories have already been added, skipped this file
            continue
        else:
            unique_files.append(file)
            prev_file = file

    return unique_files

def _resources_filegroup_impl(ctx):
    files = []
    launch_screen_storyboard = None
    for f in ctx.files.srcs:
        if not _is_apple_resource_file(file = f, extensions_to_filter = ctx.attr.extensions_to_filter):
            continue

        if f.basename == "LaunchScreen.storyboard":
            if launch_screen_storyboard:
                fail(
                    "Specified multiple %s files in %s:\n  %s\n  %s" % (f.basename, launch_screen_storyboard.path, f.path),
                )
            launch_screen_storyboard = f
        else:
            files.append(f)

    if not launch_screen_storyboard:
        launch_screen_storyboard = ctx.file.default_launch_screen_storyboard

    providers = [
        DefaultInfo(
            files = depset(direct = _deduplicate_paths(files)),
        ),
    ]

    if launch_screen_storyboard:
        providers.append(
            OutputGroupInfo(
                launch_screen_storyboard = [launch_screen_storyboard],
            ),
        )

    return providers

resources_filegroup = rule(
    implementation = _resources_filegroup_impl,
    attrs = {
        "srcs": attr.label_list(allow_files = True, allow_empty = True),
        "extensions_to_filter": attr.string_list(mandatory = True, allow_empty = True),
        "default_launch_screen_storyboard": attr.label(
            mandatory = False,
            allow_single_file = ["storyboard", "xib"],
            default = Label("//rules/test_host_app:LaunchScreen.storyboard"),
        ),
    },
    doc = """Wraps a set of srcs for use as `data` in an `objc_library` or `swift_library`,
or `resources` in an `apple_resource_bundle`.
""",
)

def wrap_resources_in_filegroup(name, srcs, extensions_to_filter = [], **kwargs):
    extensions_to_filter = list(extensions_to_filter)
    for x in ("xcdatamodeld", "xcdatamodel", "xcmappingmodel", "xcassets", "xcstickers"):
        if x not in extensions_to_filter:
            extensions_to_filter.append(x)
    resources_filegroup(
        name = name,
        srcs = srcs,
        extensions_to_filter = extensions_to_filter,
        **kwargs
    )
    return name
