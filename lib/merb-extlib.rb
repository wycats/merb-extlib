require "pathname"

# for Pathname#/
require File.expand_path(File.join(File.dirname(__FILE__), 'merb-extlib', 'pathname'))

dir = Pathname(__FILE__).dirname.expand_path / 'merb-extlib'

require dir / "version"

require dir / "string"
require dir / "time"
require dir / "class"
require dir / "hash"
require dir / "mash"
require dir / "object"
require dir / "object_space"
require dir / "rubygems"
require dir / "set"
require dir / "virtual_file"
require dir / "logger"
