#!/usr/bin/env roundup

describe "realpath"

it_displays_usage() {
	out="$(./realpath -h | head -n 1)"
	test "$out" = "Usage: realpath [options] path [...]"
}

it_converts_absolute_paths_without_change() {
	rel_path="/usr/local/bin"
	out_path="$(./realpath "$rel_path")"
	
	test "$out_path" = "$rel_path"
}

it_converts_relative_home_paths() {
	user="$(whoami)"
	
	rel_path="~/Desktop/"
	abs_path="/Users/${user}/Desktop/"
	out_path="$(./realpath "$rel_path")"
	
	test "$out_path" = "$abs_path"
}

it_converts_dotted_relative_paths() {
	cwd="$(pwd)"
	cur_dir="$(basename "$cwd")"
	
	rel_path="../${cur_dir}/"
	abs_path="$cwd"
	out_path="$(./realpath "$rel_path")"
	
	test "$out_path" = "$abs_path"
}

it_converts_dot_path_to_cwd() {
	rel_path="."
	abs_path="$(pwd)/"
	out_path="$(./realpath "$rel_path")"
	
	test "$out_path" = "$abs_path"
}

it_converts_local_paths() {
	cwd="$(pwd)"
	
	rel_path="README.md"
	abs_path="${cwd}/README.md"
	out_path="$(./realpath "$rel_path")"
	
	test "$out_path" = "$abs_path"
}

it_converts_local_paths_which_exist_in_root_path() {
	false
}

it_fails_for_nonexistent_paths() {
	false
}