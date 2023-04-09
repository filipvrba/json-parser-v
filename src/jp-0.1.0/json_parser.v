module jp

import os
import json
import rb

pub struct JsonParser {
mut:
	path string
	data Data
}

struct Data {
mut:
	items map[string]string
}

pub fn (mut j JsonParser) get(key string) string {
	j.data = j.get_data()
	return j.data.items[key]
}

pub fn (mut j JsonParser) set(key string, value string) int {
	j.data.items[key] = value
	return j.set_data()
}

pub fn (mut j JsonParser) on(key string, value string) int {
	j.data = j.get_data()
	if !j.is_include(key) {
		return j.set(key, value)
	}
	return -1
}

fn (mut j JsonParser) is_include(key string) bool {
	for j_key in j.data.items.keys() {
		if j_key == key {
			return true
		} 
	}
	return false
}

fn (j JsonParser) get_data() Data {
	abs_path_file := os.expand_tilde_to_home(j.path)
	content := os.read_file(abs_path_file) or {"{}"}
	data := json.decode(Data, content) or { Data{} }
	return data
}

fn (mut j JsonParser) set_data() int {
	content := json.encode_pretty(j.data)
	path_dir := rb.File{j.path}.dirname().to_v()
	abs_path_dir := os.expand_tilde_to_home(path_dir)
	abs_path_file := os.expand_tilde_to_home(j.path)

	if !os.is_dir(abs_path_dir) {
		os.mkdir_all(abs_path_dir) or {
			println("The '$path_dir' folder could not be created.")
		}
	}
	os.write_file(abs_path_file, content) or { return 1 }
	return 0
}