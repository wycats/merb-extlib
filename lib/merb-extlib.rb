corelib_path = File.join(File.dirname(__FILE__))
$LOAD_PATH.unshift corelib_path unless $LOAD_PATH.include?(corelib_path)

require "merb-extlib/version"

require "merb-extlib/string"
require "merb-extlib/time"
require "merb-extlib/class"
require "merb-extlib/hash"
require "merb-extlib/mash"
require "merb-extlib/object"
require "merb-extlib/object_space"
require "merb-extlib/rubygems"
require "merb-extlib/set"
require "merb-extlib/virtual_file"
require "merb-extlib/logger"
