# Copyright (c) 2021-2025 Andy Maleh
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# require 'puts_debuggerer'
require 'fileutils'
require 'etc'

require_relative '../lib/glimmer-dsl-libui'

include Glimmer

GIRB_RUNNER_EXIT_FILE = "#{Dir.home}/.girb_runner_exit"
FileUtils.rm_rf GIRB_RUNNER_EXIT_FILE

@exit_method = method(:exit)

@exit_girb_block = lambda do
  FileUtils.touch GIRB_RUNNER_EXIT_FILE
end

def self.exit(*args)
  @exit_girb_block.call
  @exit_method.call(*args)
end

def self.quit(*args)
  @exit_girb_block.call
  @exit_method.call(*args)
end
