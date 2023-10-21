# Copyright (c) 2007-2023 Andy Maleh
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

require 'facets'
require 'text-table'

module Glimmer
  module RakeTask
    # Lists Glimmer related gems to use in rake_task.rb
    class List
      class << self
        REGEX_GEM_LINE = /^([^\(]+) \(([^\)]+)\)$/
        
        def custom_control_gems(query=nil)
          list_gems('glimmer-libui-cc-', query) do |result|
            puts
            puts "  Glimmer DSL for LibUI Custom Control Gems#{" matching [#{query}]" if query} at rubygems.org:"
            puts result
          end
        end

        def custom_window_gems(query=nil)
          list_gems('glimmer-libui-cw-', query) do |result|
            puts
            puts "  Glimmer DSL for LibUI Custom Window Gems#{" matching [#{query}]" if query} at rubygems.org:"
            puts result
          end
        end

        def custom_shape_gems(query=nil)
          list_gems('glimmer-libui-cs-', query) do |result|
            puts
            puts "  Glimmer DSL for LibUI Custom Shape Gems#{" matching [#{query}]" if query} at rubygems.org:"
            puts result
          end
        end

        def dsl_gems(query=nil)
          list_gems('glimmer-dsl-', query) do |result|
            puts
            puts "  Glimmer DSL Gems#{" matching [#{query}]" if query} at rubygems.org:"
            puts result
          end
        end
        
        def list_gems(gem_prefix, query=nil, &printer)
          lines = `gem search -d #{gem_prefix}`.split("\n")
          gems = lines.slice_before {|l| l.match(REGEX_GEM_LINE) }.to_a
          gems = gems.map do |gem|
            {
              name: gem[0].match(REGEX_GEM_LINE)[1],
              version: gem[0].match(REGEX_GEM_LINE)[2],
              author: gem[1].strip,
              description: gem[4..-1]&.map(&:strip)&.join(' ').to_s
            }
          end.select do |gem|
            query.nil? || "#{gem[:name]} #{gem[:author]} #{gem[:description]}".downcase.include?(query.to_s.downcase)
          end
          printer.call(tablify(gem_prefix, gems))
        end
        
        def tablify(gem_prefix, gems)
          array_of_arrays = gems.map do |gem|
            name, namespace = gem[:name].sub(gem_prefix, '').underscore.titlecase.split
            human_name = name
            human_name += " (#{namespace})" unless namespace.nil?
            [
              human_name,
              gem[:name],
              gem[:version],
              gem[:author].sub('Author: ', ''),
              gem[:description],
            ]
          end
          Text::Table.new(
            :head => %w[Name Gem Version Author Description],
            :rows => array_of_arrays,
            :horizontal_padding    => 1,
            :vertical_boundary     => ' ',
            :horizontal_boundary   => ' ',
            :boundary_intersection => ' '
          )
        end
      end
    end
  end
end
