# Glimmer DSL for LibUI Advanced Examples

- [Glimmer DSL for LibUI Advanced Examples](#glimmer-dsl-for-libui-advanced-examples)
  - [Area Gallery](#area-gallery)
  - [Button Counter](#button-counter)
  - [Color The Circles](#color-the-circles)
  - [Control Gallery](#control-gallery)
  - [CPU Percentage](#cpu-percentage)
  - [Custom Draw Text](#custom-draw-text)
  - [Dynamic Area](#dynamic-area)
  - [Editable Column Table](#editable-column-table)
  - [Editable Table](#editable-table)
  - [Form Table](#form-table)
  - [GPT2 Notepad](#gpt2-notepad)
  - [Paginated Refined Table](#paginated-refined-table)
  - [Grid](#grid)
  - [Histogram](#histogram)
  - [Login](#login)
  - [Method-Based Custom Controls](#method-based-custom-controls)
  - [Class-Based Custom Controls](#class-based-custom-controls)
  - [Area-Based Custom Controls](#area-based-custom-controls)
  - [Midi Player](#midi-player)
  - [Snake](#snake)
  - [Tetris](#tetris)
  - [Tic Tac Toe](#tic-tac-toe)
  - [Timer](#timer)
  - [Shape Coloring](#shape-coloring)
      
## Area Gallery

[examples/area_gallery.rb](/examples/area_gallery.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/area_gallery.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/area_gallery'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-area-gallery.png](/images/glimmer-dsl-libui-mac-area-gallery.png) | ![glimmer-dsl-libui-windows-area-gallery.png](/images/glimmer-dsl-libui-windows-area-gallery.png) | ![glimmer-dsl-libui-linux-area-gallery.png](/images/glimmer-dsl-libui-linux-area-gallery.png)

Version 1:

[examples/area_gallery.rb](/examples/area_gallery.rb)

Version 2 (setting shape properties instead of arguments):

[examples/area_gallery2.rb](/examples/area_gallery2.rb)

Version 3 (semi-declarative `on_draw` dynamic `path` approach):

[examples/area_gallery3.rb](/examples/area_gallery3.rb)

Version 4 (setting shape properties instead of arguments with semi-declarative `on_draw` dynamic `path` approach):

[examples/area_gallery4.rb](/examples/area_gallery4.rb)

## Button Counter

[examples/button_counter.rb](/examples/button_counter.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/button_counter.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/button_counter'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-button-counter.png](/images/glimmer-dsl-libui-mac-button-counter.png) | ![glimmer-dsl-libui-windows-button-counter.png](/images/glimmer-dsl-libui-windows-button-counter.png) | ![glimmer-dsl-libui-linux-button-counter.png](/images/glimmer-dsl-libui-linux-button-counter.png)

## Color The Circles

[examples/color_the_circles.rb](/examples/color_the_circles.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/color_the_circles.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/color_the_circles'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-color-the-circles.png](/images/glimmer-dsl-libui-mac-color-the-circles.png) ![glimmer-dsl-libui-mac-color-the-circles-lost.png](/images/glimmer-dsl-libui-mac-color-the-circles-lost.png) ![glimmer-dsl-libui-mac-color-the-circles-won.png](/images/glimmer-dsl-libui-mac-color-the-circles-won.png) | ![glimmer-dsl-libui-windows-color-the-circles.png](/images/glimmer-dsl-libui-windows-color-the-circles.png) ![glimmer-dsl-libui-windows-color-the-circles-lost.png](/images/glimmer-dsl-libui-windows-color-the-circles-lost.png) ![glimmer-dsl-libui-windows-color-the-circles-won.png](/images/glimmer-dsl-libui-windows-color-the-circles-won.png) | ![glimmer-dsl-libui-linux-color-the-circles.png](/images/glimmer-dsl-libui-linux-color-the-circles.png) ![glimmer-dsl-libui-linux-color-the-circles-lost.png](/images/glimmer-dsl-libui-linux-color-the-circles-lost.png) ![glimmer-dsl-libui-linux-color-the-circles-won.png](/images/glimmer-dsl-libui-linux-color-the-circles-won.png)

## Control Gallery

[examples/control_gallery.rb](/examples/control_gallery.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/control_gallery.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/control_gallery'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-control-gallery.png](/images/glimmer-dsl-libui-mac-control-gallery.png) | ![glimmer-dsl-libui-windows-control-gallery.png](/images/glimmer-dsl-libui-windows-control-gallery.png) | ![glimmer-dsl-libui-linux-control-gallery.png](/images/glimmer-dsl-libui-linux-control-gallery.png)

## CPU Percentage

This example shows CPU usage percentage second by second.

Note that it is highly dependent on low-level OS terminal commands, so if anything changes in their output formatting, the code could break. Please report any issues you might encounter.

[examples/cpu_percentage.rb](/examples/cpu_percentage.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/cpu_percentage.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/cpu_percentage'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-cpu-percentage.png](/images/glimmer-dsl-libui-mac-cpu-percentage.png) | ![glimmer-dsl-libui-windows-cpu-percentage.png](/images/glimmer-dsl-libui-windows-cpu-percentage.png) | ![glimmer-dsl-libui-linux-cpu-percentage.png](/images/glimmer-dsl-libui-linux-cpu-percentage.png)

## Custom Draw Text

[examples/custom_draw_text.rb](/examples/custom_draw_text.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/custom_draw_text.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/custom_draw_text'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-custom-draw-text.png](/images/glimmer-dsl-libui-mac-custom-draw-text.png) ![glimmer-dsl-libui-mac-custom-draw-text-changed.png](/images/glimmer-dsl-libui-mac-custom-draw-text-changed.png) | ![glimmer-dsl-libui-windows-custom-draw-text.png](/images/glimmer-dsl-libui-windows-custom-draw-text.png) ![glimmer-dsl-libui-windows-custom-draw-text-changed.png](/images/glimmer-dsl-libui-windows-custom-draw-text-changed.png) | ![glimmer-dsl-libui-linux-custom-draw-text.png](/images/glimmer-dsl-libui-linux-custom-draw-text.png) ![glimmer-dsl-libui-linux-custom-draw-text-changed.png](/images/glimmer-dsl-libui-linux-custom-draw-text-changed.png)

Version 1:

[examples/custom_draw_text.rb](/examples/custom_draw_text.rb)

Version 2 (perform area redraws manually):

[examples/custom_draw_text2.rb](/examples/custom_draw_text2.rb)

## Dynamic Area

[examples/dynamic_area.rb](/examples/dynamic_area.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/dynamic_area.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/dynamic_area'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-dynamic-area.png](/images/glimmer-dsl-libui-mac-dynamic-area.png) ![glimmer-dsl-libui-mac-dynamic-area-updated.png](/images/glimmer-dsl-libui-mac-dynamic-area-updated.png) | ![glimmer-dsl-libui-windows-dynamic-area.png](/images/glimmer-dsl-libui-windows-dynamic-area.png) ![glimmer-dsl-libui-windows-dynamic-area-updated.png](/images/glimmer-dsl-libui-windows-dynamic-area-updated.png) | ![glimmer-dsl-libui-linux-dynamic-area.png](/images/glimmer-dsl-libui-linux-dynamic-area.png) ![glimmer-dsl-libui-linux-dynamic-area-updated.png](/images/glimmer-dsl-libui-linux-dynamic-area-updated.png)

Version (with [data-binding](#data-binding)):

[examples/dynamic_area.rb](/examples/dynamic_area.rb)

Version 2 (without [data-binding](#data-binding)):

[examples/dynamic_area2.rb](/examples/dynamic_area2.rb)

Version 3 (declarative stable `path` approach with [data-binding](#data-binding)):

[examples/dynamic_area3.rb](/examples/dynamic_area3.rb)

Version 4 (declarative stable `path` approach without [data-binding](#data-binding)):

[examples/dynamic_area4.rb](/examples/dynamic_area4.rb)

## Editable Column Table

[examples/editable_column_table.rb](/examples/editable_column_table.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/editable_column_table.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/editable_column_table'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-editable-column-table-editing.png](/images/glimmer-dsl-libui-mac-editable-column-table-editing.png) ![glimmer-dsl-libui-mac-editable-column-table-edited.png](/images/glimmer-dsl-libui-mac-editable-column-table-edited.png) | ![glimmer-dsl-libui-windows-editable-column-table-editing.png](/images/glimmer-dsl-libui-windows-editable-column-table-editing.png) ![glimmer-dsl-libui-windows-editable-column-table-edited.png](/images/glimmer-dsl-libui-windows-editable-column-table-edited.png) | ![glimmer-dsl-libui-linux-editable-column-table-editing.png](/images/glimmer-dsl-libui-linux-editable-column-table-editing.png) ![glimmer-dsl-libui-linux-editable-column-table-edited.png](/images/glimmer-dsl-libui-linux-editable-column-table-edited.png)

## Editable Table

[examples/editable_table.rb](/examples/editable_table.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/editable_table.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/editable_table'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-editable-table.png](/images/glimmer-dsl-libui-mac-editable-table.png) ![glimmer-dsl-libui-mac-editable-table-editing.png](/images/glimmer-dsl-libui-mac-editable-table-editing.png) ![glimmer-dsl-libui-mac-editable-table-edited.png](/images/glimmer-dsl-libui-mac-editable-table-edited.png) | ![glimmer-dsl-libui-windows-editable-table.png](/images/glimmer-dsl-libui-windows-editable-table.png) ![glimmer-dsl-libui-windows-editable-table-editing.png](/images/glimmer-dsl-libui-windows-editable-table-editing.png) ![glimmer-dsl-libui-windows-editable-table-edited.png](/images/glimmer-dsl-libui-windows-editable-table-edited.png) | ![glimmer-dsl-libui-linux-editable-table.png](/images/glimmer-dsl-libui-linux-editable-table.png) ![glimmer-dsl-libui-linux-editable-table-editing.png](/images/glimmer-dsl-libui-linux-editable-table-editing.png) ![glimmer-dsl-libui-linux-editable-table-edited.png](/images/glimmer-dsl-libui-linux-editable-table-edited.png)

## Form Table

[examples/form_table.rb](/examples/form_table.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/form_table.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/form_table'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-form-table.png](/images/glimmer-dsl-libui-mac-form-table.png) ![glimmer-dsl-libui-mac-form-table-contact-entered.png](/images/glimmer-dsl-libui-mac-form-table-contact-entered.png) ![glimmer-dsl-libui-mac-form-table-filtered.png](/images/glimmer-dsl-libui-mac-form-table-filtered.png) | ![glimmer-dsl-libui-windows-form-table.png](/images/glimmer-dsl-libui-windows-form-table.png) ![glimmer-dsl-libui-windows-form-table-contact-entered.png](/images/glimmer-dsl-libui-windows-form-table-contact-entered.png) ![glimmer-dsl-libui-windows-form-table-filtered.png](/images/glimmer-dsl-libui-windows-form-table-filtered.png) | ![glimmer-dsl-libui-linux-form-table.png](/images/glimmer-dsl-libui-linux-form-table.png) ![glimmer-dsl-libui-linux-form-table-contact-entered.png](/images/glimmer-dsl-libui-linux-form-table-contact-entered.png) ![glimmer-dsl-libui-linux-form-table-filtered.png](/images/glimmer-dsl-libui-linux-form-table-filtered.png)

Version 1 (with explicit [data-binding](#data-binding) and inferred table column attributes):

[examples/form_table.rb](/examples/form_table.rb)

Version 2 (with explicit [data-binding](#data-binding) specifying table `column_attributes` mapping hash):

[examples/form_table2.rb](/examples/form_table2.rb)

Version 3 (with explicit [data-binding](#data-binding) specifying table `column_attributes` array):

[examples/form_table3.rb](/examples/form_table3.rb)

Version 4 (with explicit [data-binding](#data-binding) to raw data):

[examples/form_table4.rb](/examples/form_table4.rb)

Version 5 (with implicit [data-binding](#data-binding)):

[examples/form_table5.rb](/examples/form_table5.rb)

## GPT2 Notepad

[examples/gpt2_notepad.rb](/examples/gpt2_notepad.rb)

This sample requires installing the following additional Ruby gems first:
- [onnxruntime](https://rubygems.org/gems/onnxruntime)
- [blingfire](https://rubygems.org/gems/blingfire)
- [numo-narray](https://rubygems.org/gems/numo-narray)

It will download GPT2 AI (Artificial Intelligence) models on first run.

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/gpt2_notepad.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/gpt2_notepad'"
```

![glimmer-dsl-libui-mac-gpt2-notepad](/images/glimmer-dsl-libui-mac-gpt2-notepad.png) ![glimmer-dsl-libui-mac-gpt2-notepad-predicted](/images/glimmer-dsl-libui-mac-gpt2-notepad-predicted.png)

## Paginated Refined Table

[examples/paginated_refined_table.rb](/examples/paginated_refined_table.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/paginated_refined_table.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/paginated_refined_table'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-paginated-refined-table.png](/images/glimmer-dsl-libui-mac-paginated-refined-table.png)| ![glimmer-dsl-libui-windows-paginated-refined-table.png](/images/glimmer-dsl-libui-windows-paginated-refined-table.png)| ![glimmer-dsl-libui-linux-paginated-refined-table.png](/images/glimmer-dsl-libui-linux-paginated-refined-table.png)

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version:

```ruby
require 'glimmer-dsl-libui'

class PaginatedRefinedTable
  Contact = Struct.new(:name, :email, :phone, :city, :state)
  
  include Glimmer::LibUI::Application
  
  NAMES_FIRST = %w[
    Liam Noah William James Oliver Benjamin Elijah Lucas Mason Logan Alexander Ethan Jacob Michael Daniel Henry Jackson Sebastian
    Aiden Matthew Samuel David Joseph Carter Owen Wyatt John Jack Luke Jayden Dylan Grayson Levi Isaac Gabriel Julian Mateo
    Anthony Jaxon Lincoln Joshua Christopher Andrew Theodore Caleb Ryan Asher Nathan Thomas Leo Isaiah Charles Josiah Hudson
    Christian Hunter Connor Eli Ezra Aaron Landon Adrian Jonathan Nolan Jeremiah Easton Elias Colton Cameron Carson Robert Angel
    Maverick Nicholas Dominic Jaxson Greyson Adam Ian Austin Santiago Jordan Cooper Brayden Roman Evan Ezekiel Xaviar Jose Jace
    Jameson Leonardo Axel Everett Kayden Miles Sawyer Jason Emma Olivia Bartholomew Corey Danielle Eva Felicity
  ]
  
  NAMES_LAST = %w[
    Smith Johnson Williams Brown Jones Miller Davis Wilson Anderson Taylor George Harrington Iverson Jackson Korby Levinson
  ]
  
  CITIES = [
    'Bellesville', 'Lombardia', 'Steepleton', 'Deerenstein', 'Schwartz', 'Hollandia', 'Saint Pete', 'Grandville', 'London',
    'Berlin', 'Elktown', 'Paris', 'Garrison', 'Muncy', 'St Louis',
  ]
  
  STATES = [ 'AK', 'AL', 'AR', 'AZ', 'CA', 'CO', 'CT', 'DC', 'DE', 'FL', 'GA',
             'HI', 'IA', 'ID', 'IL', 'IN', 'KS', 'KY', 'LA', 'MA', 'MD', 'ME',
             'MI', 'MN', 'MO', 'MS', 'MT', 'NC', 'ND', 'NE', 'NH', 'NJ', 'NM',
             'NV', 'NY', 'OH', 'OK', 'OR', 'PA', 'RI', 'SC', 'SD', 'TN', 'TX',
             'UT', 'VA', 'VT', 'WA', 'WI', 'WV', 'WY']
             
  attr_accessor :contacts, :name, :email, :phone, :city, :state, :filter_value, :index
  
  before_body do
    @contacts = 50_000.times.map do |n|
      n += 1
      first_name = NAMES_FIRST.sample
      last_name = NAMES_LAST.sample
      city = CITIES.sample
      state = STATES.sample
      Contact.new("#{first_name} #{last_name}", "#{first_name.downcase}#{n}@#{last_name.downcase}.com", '555-555-5555', city, state)
    end
  end
  
  body {
    window("50,000 Paginated Contacts", 600, 700) {
      margined true
      
      vertical_box {
        form {
          stretchy false
          
          entry {
            label 'Name'
            text <=> [self, :name] # bidirectional data-binding between entry text and self.name
          }
          
          entry {
            label 'Email'
            text <=> [self, :email]
          }
          
          entry {
            label 'Phone'
            text <=> [self, :phone]
          }
          
          entry {
            label 'City'
            text <=> [self, :city]
          }
          
          entry {
            label 'State'
            text <=> [self, :state]
          }
        }
        
        button('Save Contact') {
          stretchy false
          
          on_clicked do
            new_row = [name, email, phone, city, state]
            if new_row.map(&:to_s).include?('')
              msg_box_error('Validation Error!', 'All fields are required! Please make sure to enter a value for all fields.')
            else
              @contacts << Contact.new(*new_row) # automatically inserts a row into the table due to explicit data-binding
              @unfiltered_contacts = @contacts.dup
              self.name = '' # automatically clears name entry through explicit data-binding
              self.email = ''
              self.phone = ''
              self.city = ''
              self.state = ''
            end
          end
        }
        
        refined_table(
          model_array: contacts,
          table_columns: {
            'Name'  => {text: {editable: false}},
            'Email' => :text,
            'Phone' => :text,
            'City'  => :text,
            'State' => :text,
          },
          table_editable: true,
          per_page: 20,
          # page: 1, # initial page is 1
          # visible_page_count: true, # page count can be shown if preferred
        )
      }
    }
  }
end

PaginatedRefinedTable.launch
```

## Grid

[examples/grid.rb](/examples/grid.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/grid.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/grid'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-grid-span.png](/images/glimmer-dsl-libui-mac-grid-span.png) ![glimmer-dsl-libui-mac-grid-expand.png](/images/glimmer-dsl-libui-mac-grid-expand.png) ![glimmer-dsl-libui-mac-grid-align.png](/images/glimmer-dsl-libui-mac-grid-align.png) | ![glimmer-dsl-libui-windows-grid-span.png](/images/glimmer-dsl-libui-windows-grid-span.png) ![glimmer-dsl-libui-windows-grid-expand.png](/images/glimmer-dsl-libui-windows-grid-expand.png) ![glimmer-dsl-libui-windows-grid-align.png](/images/glimmer-dsl-libui-windows-grid-align.png) | ![glimmer-dsl-libui-linux-grid-span.png](/images/glimmer-dsl-libui-linux-grid-span.png) ![glimmer-dsl-libui-linux-grid-expand.png](/images/glimmer-dsl-libui-linux-grid-expand.png) ![glimmer-dsl-libui-linux-grid-align.png](/images/glimmer-dsl-libui-linux-grid-align.png)

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version:

```ruby
require 'glimmer-dsl-libui'

include Glimmer

window('Grid') {
  tab {
    tab_item('Span') {
      grid {
        4.times do |top_value|
          4.times do |left_value|
            label("(#{left_value}, #{top_value}) xspan1\nyspan1") {
              left left_value
              top top_value
              hexpand true
              vexpand true
            }
          end
        end
        label("(0, 4) xspan2\nyspan1 more text fits horizontally") {
          left 0
          top 4
          xspan 2
        }
        label("(2, 4) xspan2\nyspan1 more text fits horizontally") {
          left 2
          top 4
          xspan 2
        }
        label("(0, 5) xspan1\nyspan2\nmore text\nfits vertically") {
          left 0
          top 5
          yspan 2
        }
        label("(0, 7) xspan1\nyspan2\nmore text\nfits vertically") {
          left 0
          top 7
          yspan 2
        }
        label("(1, 5) xspan3\nyspan4 a lot more text fits horizontally than before\nand\neven\na lot\nmore text\nfits vertically\nthan\nbefore") {
          left 1
          top 5
          xspan 3
          yspan 4
        }
      }
    }
    tab_item('Expand') {
      grid {
        label("(0, 0) hexpand/vexpand\nall available horizontal space is taken\nand\nall\navailable\nvertical\nspace\nis\ntaken") {
          left 0
          top 0
          hexpand true
          vexpand true
        }
        label("(1, 0)") {
          left 1
          top 0
        }
        label("(0, 1)") {
          left 0
          top 1
        }
        label("(1, 1)") {
          left 1
          top 1
        }
      }
    }
    tab_item('Align') {
      grid {
        label("(0, 0) halign/valign fill\nall available horizontal space is taken\nand\nall\navailable\nvertical\nspace\nis\ntaken") {
          left 0
          top 0
          hexpand true unless OS.mac? # on Mac, only the first label is given all space, so avoid expanding
          vexpand true unless OS.mac? # on Mac, only the first label is given all space, so avoid expanding
          halign :fill
          valign :fill
        }
        label("(1, 0) halign/valign start") {
          left 1
          top 0
          hexpand true unless OS.mac? # on Mac, only the first label is given all space, so avoid expanding
          vexpand true unless OS.mac? # on Mac, only the first label is given all space, so avoid expanding
          halign :start
          valign :start
        }
        label("(0, 1) halign/valign center") {
          left 0
          top 1
          hexpand true unless OS.mac? # on Mac, only the first label is given all space, so avoid expanding
          vexpand true unless OS.mac? # on Mac, only the first label is given all space, so avoid expanding
          halign :center
          valign :center
        }
        label("(1, 1) halign/valign end") {
          left 1
          top 1
          hexpand true unless OS.mac? # on Mac, only the first label is given all space, so avoid expanding
          vexpand true unless OS.mac? # on Mac, only the first label is given all space, so avoid expanding
          halign :end
          valign :end
        }
      }
    }
  }
}.show
```

## Histogram

[examples/histogram.rb](/examples/histogram.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/histogram.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/histogram'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-histogram.png](/images/glimmer-dsl-libui-mac-histogram.png) | ![glimmer-dsl-libui-windows-histogram.png](/images/glimmer-dsl-libui-windows-histogram.png) | ![glimmer-dsl-libui-linux-histogram.png](/images/glimmer-dsl-libui-linux-histogram.png)

[LibUI](https://github.com/kojix2/LibUI) Original Version:

```ruby
# https://github.com/jamescook/libui-ruby/blob/master/example/histogram.rb

require 'libui'

UI = LibUI

X_OFF_LEFT   = 20
Y_OFF_TOP    = 20
X_OFF_RIGHT  = 20
Y_OFF_BOTTOM = 20
POINT_RADIUS = 5

init         = UI.init
handler      = UI::FFI::AreaHandler.malloc
histogram    = UI.new_area(handler)
brush        = UI::FFI::DrawBrush.malloc
color_button = UI.new_color_button
blue         = 0x1E90FF
datapoints   = []

def graph_size(area_width, area_height)
  graph_width = area_width - X_OFF_LEFT - X_OFF_RIGHT
  graph_height = area_height - Y_OFF_TOP - Y_OFF_BOTTOM
  [graph_width, graph_height]
end

matrix = UI::FFI::DrawMatrix.malloc

def point_locations(datapoints, width, height)
  xincr = width / 9.0 # 10 - 1 to make the last point be at the end
  yincr = height / 100.0

  data = []
  datapoints.each_with_index do |dp, i|
    val = 100 - UI.spinbox_value(dp)
    data << [xincr * i, yincr * val]
    i += 1
  end

  data
end

def construct_graph(datapoints, width, height, should_extend)
  locations = point_locations(datapoints, width, height)
  path = UI.draw_new_path(0) # winding
  first_location = locations[0] # x and y
  UI.draw_path_new_figure(path, first_location[0], first_location[1])
  locations.each do |loc|
    UI.draw_path_line_to(path, loc[0], loc[1])
  end

  if should_extend
    UI.draw_path_line_to(path, width, height)
    UI.draw_path_line_to(path, 0, height)
    UI.draw_path_close_figure(path)
  end

  UI.draw_path_end(path)

  path
end

handler_draw_event = Fiddle::Closure::BlockCaller.new(
  0, [1, 1, 1]
) do |_area_handler, _area, area_draw_params|
  area_draw_params = UI::FFI::AreaDrawParams.new(area_draw_params)
  path = UI.draw_new_path(0) # winding
  UI.draw_path_add_rectangle(path, 0, 0, area_draw_params.AreaWidth, area_draw_params.AreaHeight)
  UI.draw_path_end(path)
  set_solid_brush(brush, 0xFFFFFF, 1.0) # white
  UI.draw_fill(area_draw_params.Context, path, brush.to_ptr)
  UI.draw_free_path(path)
  dsp = UI::FFI::DrawStrokeParams.malloc
  dsp.Cap = 0 # flat
  dsp.Join = 0 # miter
  dsp.Thickness = 2
  dsp.MiterLimit = 10 # DEFAULT_MITER_LIMIT
  dashes = Fiddle::Pointer.malloc(8)
  dsp.Dashes = dashes
  dsp.NumDashes = 0
  dsp.DashPhase = 0

  # draw axes
  set_solid_brush(brush, 0x000000, 1.0) # black
  graph_width, graph_height = *graph_size(area_draw_params.AreaWidth, area_draw_params.AreaHeight)

  path = UI.draw_new_path(0) # winding
  UI.draw_path_new_figure(path, X_OFF_LEFT, Y_OFF_TOP)
  UI.draw_path_line_to(path, X_OFF_LEFT, Y_OFF_TOP + graph_height)
  UI.draw_path_line_to(path, X_OFF_LEFT + graph_width, Y_OFF_TOP + graph_height)
  UI.draw_path_end(path)
  UI.draw_stroke(area_draw_params.Context, path, brush, dsp)
  UI.draw_free_path(path)

  # now transform the coordinate space so (0, 0) is the top-left corner of the graph
  UI.draw_matrix_set_identity(matrix)
  UI.draw_matrix_translate(matrix, X_OFF_LEFT, Y_OFF_TOP)
  UI.draw_transform(area_draw_params.Context, matrix)

  # now get the color for the graph itself and set up the brush
  #  uiColorButtonColor(colorButton, &graphR, &graphG, &graphB, &graphA)
  graph_r = Fiddle::Pointer.malloc(8) # double
  graph_g = Fiddle::Pointer.malloc(8) # double
  graph_b = Fiddle::Pointer.malloc(8) # double
  graph_a = Fiddle::Pointer.malloc(8) # double

  UI.color_button_color(color_button, graph_r, graph_g, graph_b, graph_a)
  brush.Type = 0 # solid
  brush.R = graph_r[0, 8].unpack1('d')
  brush.G = graph_g[0, 8].unpack1('d')
  brush.B = graph_b[0, 8].unpack1('d')

  # now create the fill for the graph below the graph line
  path = construct_graph(datapoints, graph_width, graph_height, true)
  brush.A = graph_a[0, 8].unpack1('d') / 2.0
  UI.draw_fill(area_draw_params.Context, path, brush)
  UI.draw_free_path(path)

  # now draw the histogram line
  path = construct_graph(datapoints, graph_width, graph_height, false)
  brush.A = graph_a[0, 8].unpack1('d')
  UI.draw_stroke(area_draw_params.Context, path, brush, dsp)
  UI.draw_free_path(path)
end

handler.Draw         = handler_draw_event

# Assigning to local variables
# This is intended to protect Fiddle::Closure from garbage collection.
# See https://github.com/kojix2/LibUI/issues/8
handler.MouseEvent   = (c1 = Fiddle::Closure::BlockCaller.new(0, [0]) {})
handler.MouseCrossed = (c2 = Fiddle::Closure::BlockCaller.new(0, [0]) {})
handler.DragBroken   = (c3 = Fiddle::Closure::BlockCaller.new(0, [0]) {})
handler.KeyEvent     = (c4 = Fiddle::Closure::BlockCaller.new(1, [0]) { 0 })

UI.freeInitError(init) unless init.nil?

hbox = UI.new_horizontal_box
UI.box_set_padded(hbox, 1)

vbox = UI.new_vertical_box
UI.box_set_padded(vbox, 1)
UI.box_append(hbox, vbox, 0)
UI.box_append(hbox, histogram, 1)

datapoints = Array.new(10) do
  UI.new_spinbox(0, 100).tap do |datapoint|
    UI.spinbox_set_value(datapoint, Random.new.rand(90))
    UI.spinbox_on_changed(datapoint) do
      UI.area_queue_redraw_all(histogram)
    end
    UI.box_append(vbox, datapoint, 0)
  end
end

def set_solid_brush(brush, color, alpha)
  brush.Type = 0 # solid
  brush.R = ((color >> 16) & 0xFF) / 255.0
  brush.G = ((color >> 8) & 0xFF) / 255.0
  brush.B = (color & 0xFF) / 255.0
  brush.A = alpha
  brush
end

set_solid_brush(brush, blue, 1.0)
UI.color_button_set_color(color_button, brush.R, brush.G, brush.B, brush.A)

UI.color_button_on_changed(color_button) do
  UI.area_queue_redraw_all(histogram)
end

UI.box_append(vbox, color_button, 0)

MAIN_WINDOW = UI.new_window('histogram example', 640, 480, 1)
UI.window_set_margined(MAIN_WINDOW, 1)
UI.window_set_child(MAIN_WINDOW, hbox)

should_quit = proc do |_ptr|
  UI.control_destroy(MAIN_WINDOW)
  UI.quit
  0
end

UI.window_on_closing(MAIN_WINDOW, should_quit)
UI.on_should_quit(should_quit)
UI.control_show(MAIN_WINDOW)

UI.main
UI.quit
```

[Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version (with [data-binding](#data-binding)):

```ruby
# https://github.com/jamescook/libui-ruby/blob/master/example/histogram.rb

require 'glimmer-dsl-libui'

class Histogram
  include Glimmer
  
  X_OFF_LEFT   = 20
  Y_OFF_TOP    = 20
  X_OFF_RIGHT  = 20
  Y_OFF_BOTTOM = 20
  POINT_RADIUS = 5
  COLOR_BLUE   = Glimmer::LibUI.interpret_color(0x1E90FF)
  
  attr_accessor :datapoints, :histogram_color
  
  def initialize
    @datapoints   = 10.times.map {Random.new.rand(90)}
    @histogram_color        = COLOR_BLUE
  end
  
  def graph_size(area_width, area_height)
    graph_width = area_width - X_OFF_LEFT - X_OFF_RIGHT
    graph_height = area_height - Y_OFF_TOP - Y_OFF_BOTTOM
    [graph_width, graph_height]
  end
  
  def point_locations(width, height)
    xincr = width / 9.0 # 10 - 1 to make the last point be at the end
    yincr = height / 100.0
  
    @datapoints.each_with_index.map do |value, i|
      val = 100 - value
      [xincr * i, yincr * val]
    end
  end
  
  # method-based custom control representing a graph path
  def graph_path(width, height, should_extend, &block)
    locations = point_locations(width, height).flatten
    path {
      if should_extend
        polygon(locations + [width, height, 0, height])
      else
        polyline(locations)
      end
      
      # apply a transform to the coordinate space for this path so (0, 0) is the top-left corner of the graph
      transform {
        translate X_OFF_LEFT, Y_OFF_TOP
      }
      
      block.call
    }
  end
  
  def launch
    window('histogram example', 640, 480) {
      margined true
      
      horizontal_box {
        vertical_box {
          stretchy false
          
          10.times do |i|
            spinbox(0, 100) { |sb|
              stretchy false
              value <=> [self, "datapoints[#{i}]", after_write: -> { @area.queue_redraw_all }]
            }
          end
          
          color_button { |cb|
            stretchy false
            color <=> [self, :histogram_color, after_write: -> { @area.queue_redraw_all }]
          }
        }
        
        @area = area {
          on_draw do |area_draw_params|
            rectangle(0, 0, area_draw_params[:area_width], area_draw_params[:area_height]) {
              fill 0xFFFFFF
            }
            
            graph_width, graph_height = *graph_size(area_draw_params[:area_width], area_draw_params[:area_height])
          
            figure(X_OFF_LEFT, Y_OFF_TOP) {
              line(X_OFF_LEFT, Y_OFF_TOP + graph_height)
              line(X_OFF_LEFT + graph_width, Y_OFF_TOP + graph_height)
              
              stroke 0x000000, thickness: 2, miter_limit: 10
            }
          
            # now create the fill for the graph below the graph line
            graph_path(graph_width, graph_height, true) {
              fill @histogram_color.merge(a: 0.5)
            }
            
            # now draw the histogram line
            graph_path(graph_width, graph_height, false) {
              stroke @histogram_color.merge(thickness: 2, miter_limit: 10)
            }
          end
        }
      }
    }.show
  end
end

Histogram.new.launch
```

[Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 2 (without [data-binding](#data-binding)):

```ruby
# https://github.com/jamescook/libui-ruby/blob/master/example/histogram.rb

require 'glimmer-dsl-libui'

include Glimmer

X_OFF_LEFT   = 20
Y_OFF_TOP    = 20
X_OFF_RIGHT  = 20
Y_OFF_BOTTOM = 20
POINT_RADIUS = 5
COLOR_BLUE   = Glimmer::LibUI.interpret_color(0x1E90FF)

@datapoints   = 10.times.map {Random.new.rand(90)}
@color        = COLOR_BLUE

def graph_size(area_width, area_height)
  graph_width = area_width - X_OFF_LEFT - X_OFF_RIGHT
  graph_height = area_height - Y_OFF_TOP - Y_OFF_BOTTOM
  [graph_width, graph_height]
end

def point_locations(width, height)
  xincr = width / 9.0 # 10 - 1 to make the last point be at the end
  yincr = height / 100.0

  @datapoints.each_with_index.map do |value, i|
    val = 100 - value
    [xincr * i, yincr * val]
  end
end

# method-based custom control representing a graph path
def graph_path(width, height, should_extend, &block)
  locations = point_locations(width, height).flatten
  path {
    if should_extend
      polygon(locations + [width, height, 0, height])
    else
      polyline(locations)
    end
    
    # apply a transform to the coordinate space for this path so (0, 0) is the top-left corner of the graph
    transform {
      translate X_OFF_LEFT, Y_OFF_TOP
    }
    
    block.call
  }
end

window('histogram example', 640, 480) {
  margined true
  
  horizontal_box {
    vertical_box {
      stretchy false
      
      10.times do |i|
        spinbox(0, 100) { |sb|
          stretchy false
          value @datapoints[i]
          
          on_changed do
            @datapoints[i] = sb.value
            @area.queue_redraw_all
          end
        }
      end
      
      color_button { |cb|
        stretchy false
        color COLOR_BLUE
        
        on_changed do
          @color = cb.color
          @area.queue_redraw_all
        end
      }
    }
    
    @area = area {
      on_draw do |area_draw_params|
        rectangle(0, 0, area_draw_params[:area_width], area_draw_params[:area_height]) {
          fill 0xFFFFFF
        }
        
        graph_width, graph_height = *graph_size(area_draw_params[:area_width], area_draw_params[:area_height])
      
        figure(X_OFF_LEFT, Y_OFF_TOP) {
          line(X_OFF_LEFT, Y_OFF_TOP + graph_height)
          line(X_OFF_LEFT + graph_width, Y_OFF_TOP + graph_height)
          
          stroke 0x000000, thickness: 2, miter_limit: 10
        }
      
        # now create the fill for the graph below the graph line
        graph_path(graph_width, graph_height, true) {
          fill @color.merge(a: 0.5)
        }
        
        # now draw the histogram line
        graph_path(graph_width, graph_height, false) {
          stroke @color.merge(thickness: 2, miter_limit: 10)
        }
      end
    }
  }
}.show
```

## Login

[examples/login.rb](/examples/login.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/login.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/login'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-login.png](/images/glimmer-dsl-libui-mac-login.png) ![glimmer-dsl-libui-mac-login-logged-in.png](/images/glimmer-dsl-libui-mac-login-logged-in.png) | ![glimmer-dsl-libui-windows-login.png](/images/glimmer-dsl-libui-windows-login.png) ![glimmer-dsl-libui-windows-login-logged-in.png](/images/glimmer-dsl-libui-windows-login-logged-in.png) | ![glimmer-dsl-libui-linux-login.png](/images/glimmer-dsl-libui-linux-login.png) ![glimmer-dsl-libui-linux-login-logged-in.png](/images/glimmer-dsl-libui-linux-login-logged-in.png)

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version (with [data-binding](#data-binding)):

```ruby
require 'glimmer-dsl-libui'

class Login
  include Glimmer
  
  attr_accessor :username, :password, :logged_in
  
  def launch
    window('Login') {
      margined true
      
      vertical_box {
        form {
          entry {
            label 'Username:'
            text <=> [self, :username]
            enabled <= [self, :logged_in, on_read: :!]
          }
          
          password_entry {
            label 'Password:'
            text <=> [self, :password]
            enabled <= [self, :logged_in, on_read: :!]
          }
        }
        
        horizontal_box {
          button('Login') {
            enabled <= [self, :logged_in, on_read: :!]
            
            on_clicked do
              self.logged_in = true
            end
          }
          
          button('Logout') {
            enabled <= [self, :logged_in]
            
            on_clicked do
              self.logged_in = false
              self.username = ''
              self.password = ''
            end
          }
        }
      }
    }.show
  end
end

Login.new.launch
```

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 2 (with [data-binding](#data-binding)):

```ruby
require 'glimmer-dsl-libui'

class Login
  include Glimmer
  
  attr_accessor :username, :password, :logged_in
  
  def logged_out
    !logged_in
  end
  
  def launch
    window('Login') {
      margined true
      
      vertical_box {
        form {
          entry {
            label 'Username:'
            text <=> [self, :username]
            enabled <= [self, :logged_out, computed_by: :logged_in] # computed_by option ensures being notified of changes to logged_in
          }
          
          password_entry {
            label 'Password:'
            text <=> [self, :password]
            enabled <= [self, :logged_out, computed_by: :logged_in]
          }
        }
        
        horizontal_box {
          button('Login') {
            enabled <= [self, :logged_out, computed_by: :logged_in]
            
            on_clicked do
              self.logged_in = true
            end
          }
          
          button('Logout') {
            enabled <= [self, :logged_in]
            
            on_clicked do
              self.logged_in = false
              self.username = ''
              self.password = ''
            end
          }
        }
      }
    }.show
  end
end

Login.new.launch
```

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 3 (with [data-binding](#data-binding)):

```ruby
require 'glimmer-dsl-libui'

class Login
  include Glimmer
  
  attr_accessor :username, :password
  attr_reader :logged_in
  
  def logged_in=(value)
    @logged_in = value
    self.logged_out = !value # calling logged_out= method notifies logged_out observers
  end
  
  def logged_out=(value)
    self.logged_in = !value unless logged_in == !value
  end
  
  def logged_out
    !logged_in
  end
  
  def launch
    window('Login') {
      margined true
      
      vertical_box {
        form {
          entry {
            label 'Username:'
            text <=> [self, :username]
            enabled <= [self, :logged_out]
          }
          
          password_entry {
            label 'Password:'
            text <=> [self, :password]
            enabled <= [self, :logged_out]
          }
        }
        
        horizontal_box {
          button('Login') {
            enabled <= [self, :logged_out]
            
            on_clicked do
              self.logged_in = true
            end
          }
          
          button('Logout') {
            enabled <= [self, :logged_in]
            
            on_clicked do
              self.logged_in = false
              self.username = ''
              self.password = ''
            end
          }
        }
      }
    }.show
  end
end

Login.new.launch
```

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 4 (with [data-binding](#data-binding)):

```ruby
require 'glimmer-dsl-libui'

class Login
  include Glimmer
  
  attr_accessor :username, :password
  attr_reader :logged_in
  
  def logged_in=(value)
    @logged_in = value
    notify_observers(:logged_out) # manually notify observers of logged_out upon logged_in changes; this method comes automatically from enhancement as Glimmer::DataBinding::ObservableModel via data-binding
  end
  
  def logged_out
    !logged_in
  end
  
  def launch
    window('Login') {
      margined true
      
      vertical_box {
        form {
          entry {
            label 'Username:'
            text <=> [self, :username]
            enabled <= [self, :logged_out]
          }
          
          password_entry {
            label 'Password:'
            text <=> [self, :password]
            enabled <= [self, :logged_out]
          }
        }
        
        horizontal_box {
          button('Login') {
            enabled <= [self, :logged_out]
            
            on_clicked do
              self.logged_in = true
            end
          }
          
          button('Logout') {
            enabled <= [self, :logged_in]
            
            on_clicked do
              self.logged_in = false
              self.username = ''
              self.password = ''
            end
          }
        }
      }
    }.show
  end
end

Login.new.launch
```

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 5 (without [data-binding](#data-binding)):

```ruby
require 'glimmer-dsl-libui'

include Glimmer

window('Login') {
  margined true
  
  vertical_box {
    form {
      @username_entry = entry {
        label 'Username:'
      }
      
      @password_entry = password_entry {
        label 'Password:'
      }
    }
    
    horizontal_box {
      @login_button = button('Login') {
        on_clicked do
          @username_entry.enabled = false
          @password_entry.enabled = false
          @login_button.enabled = false
          @logout_button.enabled = true
        end
      }
      
      @logout_button = button('Logout') {
        enabled false
        
        on_clicked do
          @username_entry.text = ''
          @password_entry.text = ''
          @username_entry.enabled = true
          @password_entry.enabled = true
          @login_button.enabled = true
          @logout_button.enabled = false
        end
      }
    }
  }
}.show
```

## Method-Based Custom Controls

[Custom keywords](#custom-keywords) can be defined to represent custom controls (components) that provide new features or act as composites of existing controls that need to be reused multiple times in an application or across multiple applications. Custom keywords save a lot of development time, improving productivity and maintainability immensely.
  
This example defines `form_field`, `address_form`, `label_pair`, and `address` as custom controls (keywords).

The custom keywords are defined via methods (thus are "method-based").

[examples/method_based_custom_controls.rb](/examples/method_based_custom_controls.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/method_based_custom_controls.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/method_based_custom_controls'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-method-based-custom-keyword.png](/images/glimmer-dsl-libui-mac-method-based-custom-keyword.png) | ![glimmer-dsl-libui-windows-method-based-custom-keyword.png](/images/glimmer-dsl-libui-windows-method-based-custom-keyword.png) | ![glimmer-dsl-libui-linux-method-based-custom-keyword.png](/images/glimmer-dsl-libui-linux-method-based-custom-keyword.png)

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version (with [data-binding](#data-binding)):

```ruby
require 'glimmer-dsl-libui'
require 'facets'

include Glimmer

Address = Struct.new(:street, :p_o_box, :city, :state, :zip_code)

def form_field(model, attribute)
  attribute = attribute.to_s
  entry { |e|
    label attribute.underscore.split('_').map(&:capitalize).join(' ')
    text <=> [model, attribute]
  }
end

def address_form(address_model)
  form {
    form_field(address_model, :street)
    form_field(address_model, :p_o_box)
    form_field(address_model, :city)
    form_field(address_model, :state)
    form_field(address_model, :zip_code)
  }
end

def label_pair(model, attribute, value)
  horizontal_box {
    label(attribute.to_s.underscore.split('_').map(&:capitalize).join(' '))
    label(value.to_s) {
      text <= [model, attribute]
    }
  }
end

def address_view(address_model)
  vertical_box {
    address_model.each_pair do |attribute, value|
      label_pair(address_model, attribute, value)
    end
  }
end

address1 = Address.new('123 Main St', '23923', 'Denver', 'Colorado', '80014')
address2 = Address.new('2038 Park Ave', '83272', 'Boston', 'Massachusetts', '02101')

window('Method-Based Custom Controls') {
  margined true
  
  horizontal_box {
    vertical_box {
      label('Address 1') {
        stretchy false
      }
      
      address_form(address1)
      
      horizontal_separator {
        stretchy false
      }
      
      label('Address 1 (Saved)') {
        stretchy false
      }
      
      address_view(address1)
    }
    
    vertical_separator {
      stretchy false
    }
    
    vertical_box {
      label('Address 2') {
        stretchy false
      }
      
      address_form(address2)
      
      horizontal_separator {
        stretchy false
      }
      
      label('Address 2 (Saved)') {
        stretchy false
      }
      
      address_view(address2)
    }
  }
}.show
```

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 2 (without [data-binding](#data-binding)):

```ruby
require 'glimmer-dsl-libui'
require 'facets'

include Glimmer

Address = Struct.new(:street, :p_o_box, :city, :state, :zip_code)

def form_field(model, property)
  property = property.to_s
  entry { |e|
    label property.underscore.split('_').map(&:capitalize).join(' ')
    text model.send(property).to_s

    on_changed do
      model.send("#{property}=", e.text)
    end
  }
end

def address_form(address_model)
  form {
    form_field(address_model, :street)
    form_field(address_model, :p_o_box)
    form_field(address_model, :city)
    form_field(address_model, :state)
    form_field(address_model, :zip_code)
  }
end

def label_pair(model, attribute, value)
  name_label = nil
  value_label = nil
  horizontal_box {
    name_label = label(attribute.to_s.underscore.split('_').map(&:capitalize).join(' '))
    value_label = label(value.to_s)
  }
  observe(model, attribute) do
    value_label.text = model.send(attribute)
  end
end

def address_view(address_model)
  vertical_box {
    address_model.each_pair do |attribute, value|
      label_pair(address_model, attribute, value)
    end
  }
end

address1 = Address.new('123 Main St', '23923', 'Denver', 'Colorado', '80014')
address2 = Address.new('2038 Park Ave', '83272', 'Boston', 'Massachusetts', '02101')

window('Method-Based Custom Controls') {
  margined true
  
  horizontal_box {
    vertical_box {
      label('Address 1') {
        stretchy false
      }
      
      address_form(address1)
      
      horizontal_separator {
        stretchy false
      }
      
      label('Address 1 (Saved)') {
        stretchy false
      }
      
      address_view(address1)
    }
    
    vertical_separator {
      stretchy false
    }
    
    vertical_box {
      label('Address 2') {
        stretchy false
      }
      
      address_form(address2)
      
      horizontal_separator {
        stretchy false
      }
      
      label('Address 2 (Saved)') {
        stretchy false
      }
      
      address_view(address2)
    }
  }
}.show
```

## Class-Based Custom Controls

[Custom keywords](#custom-keywords) can be defined to represent custom controls (components) that provide new features or act as composites of existing controls that need to be reused multiple times in an application or across multiple applications. Custom keywords save a lot of development time, improving productivity and maintainability immensely.
  
This example defines `form_field`, `address_form`, `label_pair`, and `address` as custom controls (keywords).

The custom keywords are defined via classes that include `Glimmer::LibUI::CustomControl` (thus are "class-based"), thus enabling offloading each custom control into its own file when needed for better code organization.

[examples/class_based_custom_controls.rb](/examples/class_based_custom_controls.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/class_based_custom_controls.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/class_based_custom_controls'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-method-based-custom-keyword.png](/images/glimmer-dsl-libui-mac-method-based-custom-keyword.png) | ![glimmer-dsl-libui-windows-method-based-custom-keyword.png](/images/glimmer-dsl-libui-windows-method-based-custom-keyword.png) | ![glimmer-dsl-libui-linux-method-based-custom-keyword.png](/images/glimmer-dsl-libui-linux-method-based-custom-keyword.png)

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version (with [data-binding](#data-binding)):

```ruby
require 'glimmer-dsl-libui'
require 'facets'

Address = Struct.new(:street, :p_o_box, :city, :state, :zip_code)

class FormField
  include Glimmer::LibUI::CustomControl
  
  options :model, :attribute
  
  body {
    entry { |e|
      label attribute.to_s.underscore.split('_').map(&:capitalize).join(' ')
      text <=> [model, attribute]
    }
  }
end

class AddressForm
  include Glimmer::LibUI::CustomControl
  
  options :address
  
  body {
    form {
      form_field(model: address, attribute: :street)
      form_field(model: address, attribute: :p_o_box)
      form_field(model: address, attribute: :city)
      form_field(model: address, attribute: :state)
      form_field(model: address, attribute: :zip_code)
    }
  }
end

class LabelPair
  include Glimmer::LibUI::CustomControl
  
  options :model, :attribute, :value
  
  body {
    horizontal_box {
      label(attribute.to_s.underscore.split('_').map(&:capitalize).join(' '))
      label(value.to_s) {
        text <= [model, attribute]
      }
    }
  }
end

class AddressView
  include Glimmer::LibUI::CustomControl
  
  options :address
  
  body {
    vertical_box {
      address.each_pair do |attribute, value|
        label_pair(model: address, attribute: attribute, value: value)
      end
    }
  }
end

class ClassBasedCustomControls
  include Glimmer::LibUI::Application # alias: Glimmer::LibUI::CustomWindow
  
  before_body do
    @address1 = Address.new('123 Main St', '23923', 'Denver', 'Colorado', '80014')
    @address2 = Address.new('2038 Park Ave', '83272', 'Boston', 'Massachusetts', '02101')
  end
  
  body {
    window('Class-Based Custom Keyword') {
      margined true
      
      horizontal_box {
        vertical_box {
          label('Address 1') {
            stretchy false
          }
          
          address_form(address: @address1)
          
          horizontal_separator {
            stretchy false
          }
          
          label('Address 1 (Saved)') {
            stretchy false
          }
          
          address_view(address: @address1)
        }
        
        vertical_separator {
          stretchy false
        }
        
        vertical_box {
          label('Address 2') {
            stretchy false
          }
          
          address_form(address: @address2)
          
          horizontal_separator {
            stretchy false
          }
          
          label('Address 2 (Saved)') {
            stretchy false
          }
          
          address_view(address: @address2)
        }
      }
    }
  }
end

ClassBasedCustomControls.launch
```

## Area-Based Custom Controls

[Custom keywords](#custom-keywords) can be defined for graphical custom controls (components) built completely from scratch as vector-graphics on top of the [`area`](#area-api) control while leveraging keyboard and mouse listeners.

This example defines `text_label` and `push_button` as [`area`](#area-api)-based graphical custom controls that can have width, height, font, fill, stroke, border, and custom text location.
      
[examples/area_based_custom_controls.rb](/examples/area_based_custom_controls.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/area_based_custom_controls.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/area_based_custom_controls'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-area-based-custom-controls.png](/images/glimmer-dsl-libui-mac-area-based-custom-controls-text-label.png) ![glimmer-dsl-libui-mac-area-based-custom-controls.png](/images/glimmer-dsl-libui-mac-area-based-custom-controls-push-button.png) ![glimmer-dsl-libui-mac-area-based-custom-controls.png](/images/glimmer-dsl-libui-mac-area-based-custom-controls-push-button-clicked.png) | ![glimmer-dsl-libui-windows-area-based-custom-controls.png](/images/glimmer-dsl-libui-windows-area-based-custom-controls-text-label.png) ![glimmer-dsl-libui-windows-area-based-custom-controls.png](/images/glimmer-dsl-libui-windows-area-based-custom-controls-push-button.png) ![glimmer-dsl-libui-windows-area-based-custom-controls.png](/images/glimmer-dsl-libui-windows-area-based-custom-controls-push-button-clicked.png) | ![glimmer-dsl-libui-linux-area-based-custom-controls.png](/images/glimmer-dsl-libui-linux-area-based-custom-controls-text-label.png) ![glimmer-dsl-libui-linux-area-based-custom-controls.png](/images/glimmer-dsl-libui-linux-area-based-custom-controls-push-button.png) ![glimmer-dsl-libui-linux-area-based-custom-controls.png](/images/glimmer-dsl-libui-linux-area-based-custom-controls-push-button-clicked.png)

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version:

```ruby
require 'glimmer-dsl-libui'

class AreaBasedCustomControls
  include Glimmer
  
  attr_accessor :label_width, :label_height, :label_font_descriptor,
                :label_text_color, :label_background_fill, :label_border_stroke,
                :label_text_x, :label_text_y,
                :button_width, :button_height, :button_font_descriptor,
                :button_text_color, :button_background_fill, :button_border_stroke,
                :button_text_x, :button_text_y
  
  def initialize
    self.label_width = 335
    self.label_height = 50
    self.label_font_descriptor = {family: OS.linux? ? 'Monospace Bold Italic' : 'Courier New', size: 16, weight: :bold, italic: :italic}
    self.label_text_color = :red
    self.label_background_fill = :yellow
    self.label_border_stroke = :limegreen
    
    self.button_width = 150
    self.button_height = 50
    self.button_font_descriptor = {family: OS.linux? ? 'Monospace Bold Italic' : 'Courier New', size: 36, weight: OS.linux? ? :normal : :bold, italic: :italic}
    self.button_text_color = :green
    self.button_background_fill = :yellow
    self.button_border_stroke = :limegreen
  end
  
  def rebuild_text_label
    @text_label.destroy
    @text_label_vertical_box.content { # re-open vertical box content and shove in a new label
      @text_label = text_label('This is a text label.',
                               width: label_width, height: label_height, font_descriptor: label_font_descriptor,
                               background_fill: label_background_fill, text_color: label_text_color, border_stroke: label_border_stroke,
                               text_x: label_text_x, text_y: label_text_y)
    }
  end
  
  def rebuild_push_button
    @push_button.destroy
    @push_button_vertical_box.content { # re-open vertical box content and shove in a new button
      @push_button = push_button('Push',
                                 width: button_width, height: button_height, font_descriptor: button_font_descriptor,
                                 background_fill: button_background_fill, text_color: button_text_color, border_stroke: button_border_stroke,
                                 text_x: button_text_x, text_y: button_text_y) {
        on_mouse_up do
          message_box('Button Pushed', 'Thank you for pushing the button!')
        end
      }
    }
  end
  
  def launch
    window('Area-Based Custom Controls', 385, 385) { |w|
      margined true
      
      tab {
        tab_item('Text Label') {
          @text_label_vertical_box = vertical_box {
            vertical_box {
              text_label('Text Label Form:', width: 385, height: 30, background_fill: OS.windows? ? :white : {a: 0}, border_stroke: OS.windows? ? :white : {a: 0}, font_descriptor: {size: 16, weight: :bold}, text_x: 0, text_y: OS.windows? ? 0 : 5)

              horizontal_box {
                label('Width')
                spinbox(1, 1000) {
                  value <=> [self, :label_width, after_write: method(:rebuild_text_label)]
                }
              }
              
              horizontal_box {
                label('Height')
                spinbox(1, 1000) {
                  value <=> [self, :label_height, after_write: method(:rebuild_text_label)]
                }
              }
              
              horizontal_box {
                label('Font')
                font_button {
                  font <=> [self, :label_font_descriptor, after_write: method(:rebuild_text_label)]
                }
              }
              
              horizontal_box {
                label('Text Color')
                color_button {
                  color <=> [self, :label_text_color, after_write: method(:rebuild_text_label)]
                }
              }
              
              horizontal_box {
                label('Background Color')
                color_button {
                  color <=> [self, :label_background_fill, after_write: method(:rebuild_text_label)]
                }
              }
              
              horizontal_box {
                label('Border Color')
                color_button {
                  color <=> [self, :label_border_stroke, after_write: method(:rebuild_text_label)]
                }
              }
              
              horizontal_box {
                label('Text X (0=centered)')
                spinbox(0, 1000) {
                  value <=> [self, :label_text_x, on_read: ->(x) {x.nil? ? 0 : x}, on_write: ->(x) {x == 0 ? nil : x}, after_write: method(:rebuild_text_label)]
                }
              }
              
              horizontal_box {
                label('Text Y (0=centered)')
                spinbox(0, 1000) {
                  value <=> [self, :label_text_y, on_read: ->(y) {y.nil? ? 0 : y}, on_write: ->(y) {y == 0 ? nil : y}, after_write: method(:rebuild_text_label)]
                }
              }
            }
            
            @text_label = text_label('This is a text label.',
                                     width: label_width, height: label_height, font_descriptor: label_font_descriptor,
                                     background_fill: label_background_fill, text_color: label_text_color, border_stroke: label_border_stroke,
                                     text_x: label_text_x, text_y: label_text_y)
          }
        }
        
        tab_item('Push Button') {
          @push_button_vertical_box = vertical_box {
            vertical_box {
              text_label('Push Button Form:', width: 385, height: 30, background_fill: OS.windows? ? :white : {a: 0}, border_stroke: OS.windows? ? :white : {a: 0}, font_descriptor: {size: 16, weight: :bold}, text_x: 0, text_y: OS.windows? ? 0 : 5)
              
              horizontal_box {
                label('Width')
                spinbox(1, 1000) {
                  value <=> [self, :button_width, after_write: method(:rebuild_push_button)]
                }
              }
              
              horizontal_box {
                label('Height')
                spinbox(1, 1000) {
                  value <=> [self, :button_height, after_write: method(:rebuild_push_button)]
                }
              }
              
              horizontal_box {
                label('Font')
                font_button {
                  font <=> [self, :button_font_descriptor, after_write: method(:rebuild_push_button)]
                }
              }
              
              horizontal_box {
                label('Text Color')
                color_button {
                  color <=> [self, :button_text_color, after_write: method(:rebuild_push_button)]
                }
              }
              
              horizontal_box {
                label('Background Color')
                color_button {
                  color <=> [self, :button_background_fill, after_write: method(:rebuild_push_button)]
                }
              }
              
              horizontal_box {
                label('Border Color')
                color_button {
                  color <=> [self, :button_border_stroke, after_write: method(:rebuild_push_button)]
                }
              }
              
              horizontal_box {
                label('Text X (0=centered)')
                spinbox(0, 1000) {
                  value <=> [self, :button_text_x, on_read: ->(x) {x.nil? ? 0 : x}, on_write: ->(x) {x == 0 ? nil : x}, after_write: method(:rebuild_push_button)]
                }
              }
              
              horizontal_box {
                label('Text Y (0=centered)')
                spinbox(0, 1000) {
                  value <=> [self, :button_text_y, on_read: ->(y) {y.nil? ? 0 : y}, on_write: ->(y) {y == 0 ? nil : y}, after_write: method(:rebuild_push_button)]
                }
              }
            }
            
            @push_button = push_button('Push',
                                       width: button_width, height: button_height, font_descriptor: button_font_descriptor,
                                       background_fill: button_background_fill, text_color: button_text_color, border_stroke: button_border_stroke,
                                       text_x: button_text_x, text_y: button_text_y) {
              on_mouse_up do
                message_box('Button Pushed', 'Thank you for pushing the button!')
              end
            }
          }
        }
      }
    }.show
  end
    
  # text label (area-based custom control) built with vector graphics on top of area.
  #
  # background_fill is transparent by default.
  # background_fill can accept a single color or gradient stops just as per `fill` property in README.
  # border_stroke is transparent by default.
  # border_stroke can accept thickness and dashes in addition to color just as per `stroke` property in README.
  # text_x and text_y are the offset of the label text in relation to its top-left corner.
  # When text_x, text_y are left nil, the text is automatically centered in the label area.
  # Sometimes, the centering calculation is not perfect due to using a custom font, so
  # in that case, pass in text_x, and text_y manually.
  def text_label(label_text,
                  width: 80, height: 30, font_descriptor: {},
                  background_fill: {a: 0}, text_color: :black, border_stroke: {a: 0},
                  text_x: nil, text_y: nil,
                  &content)
    area { |the_area|
      rectangle(1, 1, width, height) {
        fill background_fill
      }
      rectangle(1, 1, width, height) {
        stroke border_stroke
      }
      
      text_height = (font_descriptor[:size] || 12) * (OS.mac? ? 0.75 : 1.35)
      text_width = (text_height * label_text.size) * (OS.mac? ? 0.75 : 0.60)
      text_x ||= (width - text_width) / 2.0
      text_y ||= (height - 4 - text_height) / 2.0
      text(text_x, text_y, width) {
        string(label_text) {
          color text_color
          font font_descriptor
        }
      }
      
      content&.call(the_area)
    }
  end
  
  # push button (area-based custom control) built with vector graphics on top of area.
  #
  # background_fill is white by default.
  # background_fill can accept a single color or gradient stops just as per `fill` property in README.
  # border_stroke is black by default.
  # border_stroke can accept thickness and dashes in addition to color just as per `stroke` property in README.
  # text_x and text_y are the offset of the button text in relation to its top-left corner.
  # When text_x, text_y are left nil, the text is automatically centered in the button area.
  # Sometimes, the centering calculation is not perfect due to using a custom font, so
  # in that case, pass in text_x, and text_y manually.
  #
  # reuses the text_label custom control
  def push_button(button_text,
                  width: 80, height: 30, font_descriptor: {},
                  background_fill: :white, text_color: :black, border_stroke: {r: 201, g: 201, b: 201},
                  text_x: nil, text_y: nil,
                  &content)
    text_label(button_text,
                  width: width, height: height, font_descriptor: font_descriptor,
                  background_fill: background_fill, text_color: text_color, border_stroke: border_stroke,
                  text_x: text_x, text_y: text_y) { |the_area|
      
      # dig into the_area content and grab elements to modify in mouse listeners below
      background_rectangle = the_area.children[0]
      button_string = the_area.children[2].children[0]
      
      on_mouse_down do
        background_rectangle.fill = {x0: 0, y0: 0, x1: 0, y1: height, stops: [{pos: 0, r: 72, g: 146, b: 247}, {pos: 1, r: 12, g: 85, b: 214}]}
        button_string.color = :white
      end
      
      on_mouse_up do
        background_rectangle.fill = background_fill
        button_string.color = text_color
      end
      
      content&.call(the_area)
    }
  end
end

AreaBasedCustomControls.new.launch
```

## Midi Player

To run this example, install [TiMidity](http://timidity.sourceforge.net) and ensure `timidity` command is in `PATH` (can be installed via [Homebrew](https://brew.sh) on Mac or [apt-get](https://help.ubuntu.com/community/AptGet/Howto) on Linux).

[examples/midi_player.rb](/examples/midi_player.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/midi_player.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/midi_player'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-midi-player.png](/images/glimmer-dsl-libui-mac-midi-player.png) ![glimmer-dsl-libui-mac-midi-player-msg-box.png](/images/glimmer-dsl-libui-mac-midi-player-msg-box.png) | ![glimmer-dsl-libui-windows-midi-player.png](/images/glimmer-dsl-libui-windows-midi-player.png) ![glimmer-dsl-libui-windows-midi-player-msg-box.png](/images/glimmer-dsl-libui-windows-midi-player-msg-box.png) | ![glimmer-dsl-libui-linux-midi-player.png](/images/glimmer-dsl-libui-linux-midi-player.png) ![glimmer-dsl-libui-linux-midi-player-msg-box.png](/images/glimmer-dsl-libui-linux-midi-player-msg-box.png)

[LibUI](https://github.com/kojix2/LibUI) Original Version:

```ruby
require 'libui'
UI = LibUI

class TinyMidiPlayer
  VERSION = '0.0.1'

  def initialize
    UI.init
    @pid = nil
    @music_directory = File.expand_path(ARGV[0] || '~/Music/')
    @midi_files      = Dir.glob(File.join(@music_directory, '**/*.mid'))
                          .sort_by { |path| File.basename(path) }
    at_exit { stop_midi }
    create_gui
  end

  def stop_midi
    if @pid
      Process.kill(:SIGKILL, @pid) if @th.alive?
      @pid = nil
    end
  end

  def play_midi
    stop_midi
    if @pid.nil? && @selected_file
      begin
        @pid = spawn "timidity #{@selected_file}"
        @th = Process.detach @pid
      rescue Errno::ENOENT
        warn 'Timidty++ not found. Please install Timidity++.'
        warn 'https://sourceforge.net/projects/timidity/'
      end
    end
  end

  def show_version(main_window)
    UI.msg_box(main_window,
               'Tiny Midi Player',
               "Written in Ruby\n" \
               "https://github.com/kojix2/libui\n" \
               "Version #{VERSION}")
  end

  def create_gui
    # loop_menu = UI.new_menu('Repeat')
    # items = %w[Off One].map do |item_name|
    #   item = UI.menu_append_check_item(loop_menu, item_name)
    # end
    # items.each_with_index do |item, idx|
    #   UI.menu_item_on_clicked(item) do
    #     @repeat = idx
    #     (items - [item]).each do |i|
    #       UI.menu_item_set_checked(i, 0)
    #     end
    #     0
    #   end
    # end

    help_menu = UI.new_menu('Help')
    version_item = UI.menu_append_item(help_menu, 'Version')

    UI.new_window('Tiny Midi Player', 200, 50, 1).tap do |main_window|
      UI.menu_item_on_clicked(version_item) { show_version(main_window) }

      UI.window_on_closing(main_window) do
        UI.control_destroy(main_window)
        UI.quit
        0
      end

      UI.new_horizontal_box.tap do |hbox|
        UI.new_vertical_box.tap do |vbox|
          UI.new_button('▶').tap do |button1|
            UI.button_on_clicked(button1) { play_midi }
            UI.box_append(vbox, button1, 1)
          end
          UI.new_button('■').tap do |button2|
            UI.button_on_clicked(button2) { stop_midi }
            UI.box_append(vbox, button2, 1)
          end
          UI.box_append(hbox, vbox, 0)
        end
        UI.window_set_child(main_window, hbox)

        UI.new_combobox.tap do |cbox|
          @midi_files.each do |path|
            name = File.basename(path)
            UI.combobox_append(cbox, name)
          end
          UI.combobox_on_selected(cbox) do |ptr|
            @selected_file = @midi_files[UI.combobox_selected(ptr)]
            play_midi if @th&.alive?
            0
          end
          UI.box_append(hbox, cbox, 1)
        end
      end
      UI.control_show(main_window)
    end
    UI.main
    UI.quit
  end
end

TinyMidiPlayer.new
```

[Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version (with [data-binding](#data-binding)):

```ruby
# frozen_string_literal: true

require 'glimmer-dsl-libui'

class TinyMidiPlayer
  include Glimmer
  
  VERSION = '0.0.1'
  
  attr_accessor :selected_file

  def initialize
    @pid = nil
    @music_directory = File.expand_path('../sounds', __dir__)
    @midi_files      = Dir.glob(File.join(@music_directory, '**/*.mid'))
                          .sort_by { |path| File.basename(path) }
    at_exit { stop_midi }
    create_gui
  end

  def stop_midi
    if @pid
      Process.kill(:SIGKILL, @pid) if @th.alive?
      @pid = nil
    end
  end

  def play_midi
    stop_midi
    if @pid.nil? && @selected_file
      begin
        @pid = spawn "timidity #{@selected_file}"
        @th = Process.detach @pid
      rescue Errno::ENOENT
        warn 'Timidty++ not found. Please install Timidity++.'
        warn 'https://sourceforge.net/projects/timidity/'
      end
    end
  end

  def show_version
    msg_box('Tiny Midi Player',
              "Written in Ruby\n" \
                "https://github.com/kojix2/libui\n" \
                "Version #{VERSION}")
  end

  def create_gui
    menu('Help') {
      menu_item('Version') {
        on_clicked do
          show_version
        end
      }
    }
    window('Tiny Midi Player', 200, 50) {
      horizontal_box {
        vertical_box {
          stretchy false
          
          button('▶') {
            on_clicked do
              play_midi
            end
          }
          button('■') {
            on_clicked do
              stop_midi
            end
          }
        }

        combobox {
          items @midi_files.map { |path| File.basename(path) }
          # data-bind selected item (String) to self.selected_file with on-read/on-write converters and after_write operation
          selected_item <=> [self, :selected_file, on_read: ->(f) {File.basename(f.to_s)}, on_write: ->(f) {File.join(@music_directory, f)}, after_write: -> { play_midi if @th&.alive? }]
        }
      }
    }.show
  end
end

TinyMidiPlayer.new
```

[Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 2 (with [data-binding](#data-binding)):

```ruby
require 'glimmer-dsl-libui'

class TinyMidiPlayer
  include Glimmer
  
  VERSION = '0.0.1'
  
  attr_accessor :selected_file

  def initialize
    @pid = nil
    @music_directory = File.expand_path('../sounds', __dir__)
    @midi_files      = Dir.glob(File.join(@music_directory, '**/*.mid'))
                          .sort_by { |path| File.basename(path) }
    at_exit { stop_midi }
    create_gui
  end

  def stop_midi
    if @pid
      Process.kill(:SIGKILL, @pid) if @th.alive?
      @pid = nil
    end
  end

  def play_midi
    stop_midi
    if @pid.nil? && @selected_file
      begin
        @pid = spawn "timidity #{@selected_file}"
        @th = Process.detach @pid
      rescue Errno::ENOENT
        warn 'Timidty++ not found. Please install Timidity++.'
        warn 'https://sourceforge.net/projects/timidity/'
      end
    end
  end

  def show_version
    msg_box('Tiny Midi Player',
              "Written in Ruby\n" \
                "https://github.com/kojix2/libui\n" \
                "Version #{VERSION}")
  end

  def create_gui
    menu('Help') {
      menu_item('Version') {
        on_clicked do
          show_version
        end
      }
    }
    window('Tiny Midi Player', 200, 50) {
      horizontal_box {
        vertical_box {
          stretchy false
          
          button('▶') {
            on_clicked do
              play_midi
            end
          }
          button('■') {
            on_clicked do
              stop_midi
            end
          }
        }

        combobox {
          items @midi_files.map { |path| File.basename(path) }
          # data-bind selected index (Integer) to self.selected_file with on-read/on-write converters and after_write operation
          selected <=> [self, :selected_file, on_read: ->(f) {@midi_files.index(f)}, on_write: ->(i) {@midi_files[i]}, after_write: -> { play_midi if @th&.alive? }]
        }
      }
    }.show
  end
end

TinyMidiPlayer.new
```

[Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 3 (without [data-binding](#data-binding)):

```ruby
require 'glimmer-dsl-libui'

class TinyMidiPlayer
  include Glimmer
  
  VERSION = '0.0.1'

  def initialize
    @pid = nil
    @music_directory = File.expand_path('../sounds', __dir__)
    @midi_files      = Dir.glob(File.join(@music_directory, '**/*.mid'))
                          .sort_by { |path| File.basename(path) }
    at_exit { stop_midi }
    create_gui
  end

  def stop_midi
    if @pid
      Process.kill(:SIGKILL, @pid) if @th.alive?
      @pid = nil
    end
  end

  def play_midi
    stop_midi
    if @pid.nil? && @selected_file
      begin
        @pid = spawn "timidity #{@selected_file}"
        @th = Process.detach @pid
      rescue Errno::ENOENT
        warn 'Timidty++ not found. Please install Timidity++.'
        warn 'https://sourceforge.net/projects/timidity/'
      end
    end
  end

  def show_version
    msg_box('Tiny Midi Player',
              "Written in Ruby\n" \
                "https://github.com/kojix2/libui\n" \
                "Version #{VERSION}")
  end

  def create_gui
    menu('Help') {
      menu_item('Version') {
        on_clicked do
          show_version
        end
      }
    }
    window('Tiny Midi Player', 200, 50) {
      horizontal_box {
        vertical_box {
          stretchy false
          
          button('▶') {
            on_clicked do
              play_midi
            end
          }
          button('■') {
            on_clicked do
              stop_midi
            end
          }
        }

        combobox { |c|
          items @midi_files.map { |path| File.basename(path) }
          
          on_selected do
            @selected_file = @midi_files[c.selected]
            play_midi if @th&.alive?
          end
        }
      }
    }.show
  end
end

TinyMidiPlayer.new
```

## Snake

Snake provides an example of building a desktop application [test-first](/spec/examples/snake/model/game_spec.rb) following the MVP ([Model](/examples/snake/model/game.rb) / [View](/examples/snake.rb) / [Presenter](/examples/snake/presenter/grid.rb)) architectural pattern.

Use arrows to move and spacebar to pause/resume.

Note that Snake relies on the new [Ruby Pattern Matching feature](https://docs.ruby-lang.org/en/3.0/doc/syntax/pattern_matching_rdoc.html) available starting in Ruby 2.7 experimentally and in Ruby 3.0 officially.

[examples/snake.rb](/examples/snake.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/snake.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/snake'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-snake.png](/images/glimmer-dsl-libui-mac-snake.png) ![glimmer-dsl-libui-mac-snake-game-over.png](/images/glimmer-dsl-libui-mac-snake-game-over.png) | ![glimmer-dsl-libui-windows-snake.png](/images/glimmer-dsl-libui-windows-snake.png) ![glimmer-dsl-libui-windows-snake-game-over.png](/images/glimmer-dsl-libui-windows-snake-game-over.png) | ![glimmer-dsl-libui-linux-snake.png](/images/glimmer-dsl-libui-linux-snake.png) ![glimmer-dsl-libui-linux-snake-game-over.png](/images/glimmer-dsl-libui-linux-snake-game-over.png)

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version (with [data-binding](#data-binding)):

```ruby
require 'glimmer-dsl-libui'

require_relative 'snake/presenter/grid'

class Snake
  include Glimmer
  
  CELL_SIZE = 15
  SNAKE_MOVE_DELAY = 0.1
  
  def initialize
    @game = Model::Game.new
    @grid = Presenter::Grid.new(@game)
    @game.start
    @keypress_queue = []
    create_gui
    register_observers
  end
  
  def launch
    @main_window.show
  end
  
  def register_observers
    observe(@game, :over) do |game_over|
      Glimmer::LibUI.queue_main do
        if game_over
          msg_box('Game Over!', "Score: #{@game.score} | High Score: #{@game.high_score}")
          @game.start
        end
      end
    end
    
    Glimmer::LibUI.timer(SNAKE_MOVE_DELAY) do
      unless @game.paused? || @game.over?
        process_queued_keypress
        @game.snake.move
      end
    end
  end
  
  def process_queued_keypress
    # key press queue ensures one turn per snake move to avoid a double-turn resulting in instant death (due to snake illogically going back against itself)
    key = @keypress_queue.shift
    case [@game.snake.head.orientation, key]
    in [:north, :right] | [:east, :down] | [:south, :left] | [:west, :up]
      @game.snake.turn_right
    in [:north, :left] | [:west, :down] | [:south, :right] | [:east, :up]
      @game.snake.turn_left
    else
      # No Op
    end
  end
  
  def create_gui
    @main_window = window {
      # data-bind window title to game score, converting it to a title string on read from the model
      title <= [@game, :score, on_read: -> (score) {"Snake (Score: #{@game.score})"}]
      content_size @game.width * CELL_SIZE, @game.height * CELL_SIZE
      resizable false
      
      vertical_box {
        padded false
        
        @game.height.times do |row|
          horizontal_box {
            padded false
            
            @game.width.times do |column|
              area {
                square(0, 0, CELL_SIZE) {
                  fill <= [@grid.cells[row][column], :color] # data-bind square fill to grid cell color
                }
                
                on_key_up do |area_key_event|
                  if area_key_event[:key] == ' '
                    @game.toggle_pause
                  else
                    @keypress_queue << area_key_event[:ext_key]
                  end
                end
              }
            end
          }
        end
      }
    }
  end
end

Snake.new.launch
```

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 2 (without [data-binding](#data-binding)):

```ruby
require 'glimmer-dsl-libui'

require_relative 'snake/presenter/grid'

class Snake
  include Glimmer
  
  CELL_SIZE = 15
  SNAKE_MOVE_DELAY = 0.1
  
  def initialize
    @game = Model::Game.new
    @grid = Presenter::Grid.new(@game)
    @game.start
    @keypress_queue = []
    create_gui
    register_observers
  end
  
  def launch
    @main_window.show
  end
  
  def register_observers
    @game.height.times do |row|
      @game.width.times do |column|
        observe(@grid.cells[row][column], :color) do |new_color|
          @cell_grid[row][column].fill = new_color
        end
      end
    end
    
    observe(@game, :over) do |game_over|
      Glimmer::LibUI.queue_main do
        if game_over
          msg_box('Game Over!', "Score: #{@game.score} | High Score: #{@game.high_score}")
          @game.start
        end
      end
    end
    
    Glimmer::LibUI.timer(SNAKE_MOVE_DELAY) do
      unless @game.paused? || @game.over?
        process_queued_keypress
        @game.snake.move
      end
    end
  end
  
  def process_queued_keypress
    # key press queue ensures one turn per snake move to avoid a double-turn resulting in instant death (due to snake illogically going back against itself)
    key = @keypress_queue.shift
    case [@game.snake.head.orientation, key]
    in [:north, :right] | [:east, :down] | [:south, :left] | [:west, :up]
      @game.snake.turn_right
    in [:north, :left] | [:west, :down] | [:south, :right] | [:east, :up]
      @game.snake.turn_left
    else
      # No Op
    end
  end
  
  def create_gui
    @cell_grid = []
    @main_window = window {
      # data-bind window title to game score, converting it to a title string on read from the model
      title <= [@game, :score, on_read: -> (score) {"Snake (Score: #{@game.score})"}]
      content_size @game.width * CELL_SIZE, @game.height * CELL_SIZE
      resizable false
      
      vertical_box {
        padded false
        
        @game.height.times do |row|
          @cell_grid << []
          horizontal_box {
            padded false
            
            @game.width.times do |column|
              area {
                @cell_grid.last << square(0, 0, CELL_SIZE) {
                  fill Presenter::Cell::COLOR_CLEAR
                }
                
                on_key_up do |area_key_event|
                  if area_key_event[:key] == ' '
                    @game.toggle_pause
                  else
                    @keypress_queue << area_key_event[:ext_key]
                  end
                end
              }
            end
          }
        end
      }
    }
  end
end

Snake.new.launch
```

## Tetris

Glimmer Tetris utilizes many small areas to represent Tetromino blocks because this ensures smaller redraws per tetromino block color change, thus achieving higher performance than redrawing one large area on every little change.

Note that Tetris relies on the new [Ruby Pattern Matching feature](https://docs.ruby-lang.org/en/3.0/doc/syntax/pattern_matching_rdoc.html) available starting in Ruby 2.7 experimentally and in Ruby 3.0 officially.

[examples/tetris.rb](/examples/tetris.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/tetris.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/tetris'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-tetris.png](/images/glimmer-dsl-libui-mac-tetris.png) | ![glimmer-dsl-libui-windows-tetris.png](/images/glimmer-dsl-libui-windows-tetris.png) | ![glimmer-dsl-libui-linux-tetris.png](/images/glimmer-dsl-libui-linux-tetris.png)

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version:

```ruby
require 'glimmer-dsl-libui'

require_relative 'tetris/model/game'

class Tetris
  include Glimmer
  
  BLOCK_SIZE = 25
  BEVEL_CONSTANT = 20
  COLOR_GRAY = {r: 192, g: 192, b: 192}
    
  def initialize
    @game = Model::Game.new
  end
  
  def launch
    create_gui
    register_observers
    @game.start!
    @main_window.show
  end
  
  def create_gui
    menu_bar
    
    @main_window = window('Glimmer Tetris') {
      content_size Model::Game::PLAYFIELD_WIDTH * BLOCK_SIZE, Model::Game::PLAYFIELD_HEIGHT * BLOCK_SIZE + 98
      resizable false
      
      vertical_box {
        label { # filler
          stretchy false
        }
        
        score_board(block_size: BLOCK_SIZE) {
          stretchy false
        }
        
        @playfield_blocks = playfield(playfield_width: Model::Game::PLAYFIELD_WIDTH, playfield_height: Model::Game::PLAYFIELD_HEIGHT, block_size: BLOCK_SIZE)
      }
    }
  end
  
  def register_observers
    observe(@game, :game_over) do |game_over|
      if game_over
        @pause_menu_item.enabled = false
        show_game_over_dialog
      else
        @pause_menu_item.enabled = true
        start_moving_tetrominos_down
      end
    end
    
    Model::Game::PLAYFIELD_HEIGHT.times do |row|
      Model::Game::PLAYFIELD_WIDTH.times do |column|
        observe(@game.playfield[row][column], :color) do |new_color|
          Glimmer::LibUI.queue_main do
            color = Glimmer::LibUI.interpret_color(new_color)
            block = @playfield_blocks[row][column]
            block[:background_square].fill = color
            block[:top_bevel_edge].fill = {r: color[:r] + 4*BEVEL_CONSTANT, g: color[:g] + 4*BEVEL_CONSTANT, b: color[:b] + 4*BEVEL_CONSTANT}
            block[:right_bevel_edge].fill = {r: color[:r] - BEVEL_CONSTANT, g: color[:g] - BEVEL_CONSTANT, b: color[:b] - BEVEL_CONSTANT}
            block[:bottom_bevel_edge].fill = {r: color[:r] - BEVEL_CONSTANT, g: color[:g] - BEVEL_CONSTANT, b: color[:b] - BEVEL_CONSTANT}
            block[:left_bevel_edge].fill = {r: color[:r] - BEVEL_CONSTANT, g: color[:g] - BEVEL_CONSTANT, b: color[:b] - BEVEL_CONSTANT}
            block[:border_square].stroke = new_color == Model::Block::COLOR_CLEAR ? COLOR_GRAY : color
          end
        end
      end
    end
    
    Model::Game::PREVIEW_PLAYFIELD_HEIGHT.times do |row|
      Model::Game::PREVIEW_PLAYFIELD_WIDTH.times do |column|
        preview_updater = proc do
          Glimmer::LibUI.queue_main do
            new_color = @game.preview_playfield[row][column].color
            color = Glimmer::LibUI.interpret_color(new_color)
            block = @preview_playfield_blocks[row][column]
            if @game.show_preview_tetromino?
              block[:background_square].fill = color
              block[:top_bevel_edge].fill = {r: color[:r] + 4*BEVEL_CONSTANT, g: color[:g] + 4*BEVEL_CONSTANT, b: color[:b] + 4*BEVEL_CONSTANT}
              block[:right_bevel_edge].fill = {r: color[:r] - BEVEL_CONSTANT, g: color[:g] - BEVEL_CONSTANT, b: color[:b] - BEVEL_CONSTANT}
              block[:bottom_bevel_edge].fill = {r: color[:r] - BEVEL_CONSTANT, g: color[:g] - BEVEL_CONSTANT, b: color[:b] - BEVEL_CONSTANT}
              block[:left_bevel_edge].fill = {r: color[:r] - BEVEL_CONSTANT, g: color[:g] - BEVEL_CONSTANT, b: color[:b] - BEVEL_CONSTANT}
              block[:border_square].stroke = new_color == Model::Block::COLOR_CLEAR ? COLOR_GRAY : color
            else
              transparent_color = {r: 255, g: 255, b: 255, a: 0}
              block[:background_square].fill = transparent_color
              block[:top_bevel_edge].fill = transparent_color
              block[:right_bevel_edge].fill = transparent_color
              block[:bottom_bevel_edge].fill = transparent_color
              block[:left_bevel_edge].fill = transparent_color
              block[:border_square].stroke = transparent_color
            end
          end
        end
        observe(@game.preview_playfield[row][column], :color, &preview_updater)
        observe(@game, :show_preview_tetromino, &preview_updater)
      end
    end

    observe(@game, :score) do |new_score|
      Glimmer::LibUI.queue_main do
        @score_label.text = new_score.to_s
      end
    end

    observe(@game, :lines) do |new_lines|
      Glimmer::LibUI.queue_main do
        @lines_label.text = new_lines.to_s
      end
    end

    observe(@game, :level) do |new_level|
      Glimmer::LibUI.queue_main do
        @level_label.text = new_level.to_s
      end
    end
  end
  
  def menu_bar
    menu('Game') {
      @pause_menu_item = check_menu_item('Pause') {
        enabled false
        checked <=> [@game, :paused]
      }
      
      menu_item('Restart') {
        on_clicked do
          @game.restart!
        end
      }
      
      separator_menu_item
      
      menu_item('Exit') {
        on_clicked do
          exit(0)
        end
      }
      
      quit_menu_item if OS.mac?
    }
    
    menu('View') {
      check_menu_item('Show Next Block Preview') {
        checked <=> [@game, :show_preview_tetromino]
      }
      
      separator_menu_item
      
      menu_item('Show High Scores') {
        on_clicked do
          show_high_scores
        end
      }
      
      menu_item('Clear High Scores') {
        on_clicked {
          @game.clear_high_scores!
        }
      }
      
      separator_menu_item
    }

    menu('Options') {
      radio_menu_item('Instant Down on Up Arrow') {
        checked <=> [@game, :instant_down_on_up]
      }
      
      radio_menu_item('Rotate Right on Up Arrow') {
        checked <=> [@game, :rotate_right_on_up]
      }
      
      radio_menu_item('Rotate Left on Up Arrow') {
        checked <=> [@game, :rotate_left_on_up]
      }
    }

    menu('Help') {
      if OS.mac?
        about_menu_item {
          on_clicked do
            show_about_dialog
          end
        }
      end
      
      menu_item('About') {
        on_clicked do
          show_about_dialog
        end
      }
    }
  end
  
  def playfield(playfield_width: , playfield_height: , block_size: , &extra_content)
    blocks = []
    vertical_box {
      padded false
      
      playfield_height.times.map do |row|
        blocks << []
        horizontal_box {
          padded false
          
          playfield_width.times.map do |column|
            blocks.last << block(row: row, column: column, block_size: block_size)
          end
        }
      end
      
      extra_content&.call
    }
    blocks
  end
  
  def block(row: , column: , block_size: , &extra_content)
    block = {}
    bevel_pixel_size = 0.16 * block_size.to_f
    color = Glimmer::LibUI.interpret_color(Model::Block::COLOR_CLEAR)
    block[:area] = area {
      block[:background_square] = square(0, 0, block_size) {
        fill color
      }
      
      block[:top_bevel_edge] = polygon {
        point_array 0, 0, block_size, 0, block_size - bevel_pixel_size, bevel_pixel_size, bevel_pixel_size, bevel_pixel_size
        fill r: color[:r] + 4*BEVEL_CONSTANT, g: color[:g] + 4*BEVEL_CONSTANT, b: color[:b] + 4*BEVEL_CONSTANT
      }
      
      block[:right_bevel_edge] = polygon {
        point_array block_size, 0, block_size - bevel_pixel_size, bevel_pixel_size, block_size - bevel_pixel_size, block_size - bevel_pixel_size, block_size, block_size
        fill r: color[:r] - BEVEL_CONSTANT, g: color[:g] - BEVEL_CONSTANT, b: color[:b] - BEVEL_CONSTANT
      }
      
      block[:bottom_bevel_edge] = polygon {
        point_array block_size, block_size, 0, block_size, bevel_pixel_size, block_size - bevel_pixel_size, block_size - bevel_pixel_size, block_size - bevel_pixel_size
        fill r: color[:r] - BEVEL_CONSTANT, g: color[:g] - BEVEL_CONSTANT, b: color[:b] - BEVEL_CONSTANT
      }
      
      block[:left_bevel_edge] = polygon {
        point_array 0, 0, 0, block_size, bevel_pixel_size, block_size - bevel_pixel_size, bevel_pixel_size, bevel_pixel_size
        fill r: color[:r] - BEVEL_CONSTANT, g: color[:g] - BEVEL_CONSTANT, b: color[:b] - BEVEL_CONSTANT
      }
      
      block[:border_square] = square(0, 0, block_size) {
        stroke COLOR_GRAY
      }
      
      on_key_down do |key_event|
        case key_event
        in ext_key: :down
          if OS.windows?
            # rate limit downs in Windows as they go too fast when key is held
            @queued_downs ||= 0
            if @queued_downs < 2
              @queued_downs += 1
              Glimmer::LibUI.timer(0.01, repeat: false) do
                @game.down! if @queued_downs < 2
                @queued_downs -= 1
              end
            end
          else
            @game.down!
          end
        in key: ' '
          @game.down!(instant: true)
        in ext_key: :up
          case @game.up_arrow_action
          when :instant_down
            @game.down!(instant: true)
          when :rotate_right
            @game.rotate!(:right)
          when :rotate_left
            @game.rotate!(:left)
          end
        in ext_key: :left
          @game.left!
        in ext_key: :right
          @game.right!
        in modifier: :shift
          @game.rotate!(:right)
        in modifier: :control
          @game.rotate!(:left)
        else
          # Do Nothing
        end
      end
      
      extra_content&.call
    }
    block
  end
  
  def score_board(block_size: , &extra_content)
    vertical_box {
      horizontal_box {
        label # filler
        grid {
          stretchy false
          
          label('Score') {
            left 0
            top 0
            halign :fill
          }
          @score_label = label {
            left 0
            top 1
            halign :center
          }
    
          label('Lines') {
            left 1
            top 0
            halign :fill
          }
          @lines_label = label {
            left 1
            top 1
            halign :center
          }
    
          label('Level') {
            left 2
            top 0
            halign :fill
          }
          @level_label = label {
            left 2
            top 1
            halign :center
          }
        }
        label # filler
      }
      
      horizontal_box {
        label # filler
        @preview_playfield_blocks = playfield(playfield_width: Model::Game::PREVIEW_PLAYFIELD_WIDTH, playfield_height: Model::Game::PREVIEW_PLAYFIELD_HEIGHT, block_size: block_size)
        label # filler
      }
    
      extra_content&.call
    }
  end
  
  def start_moving_tetrominos_down
    unless @tetrominos_start_moving_down
      @tetrominos_start_moving_down = true
      Glimmer::LibUI.timer(@game.delay) do
        @game.down! if !@game.game_over? && !@game.paused?
      end
    end
  end
  
  def show_game_over_dialog
    Glimmer::LibUI.queue_main do
      msg_box('Game Over!', "Score: #{@game.high_scores.first.score}\nLines: #{@game.high_scores.first.lines}\nLevel: #{@game.high_scores.first.level}")
      @game.restart!
    end
  end
  
  def show_high_scores
    Glimmer::LibUI.queue_main do
      game_paused = !!@game.paused
      @game.paused = true
      if @game.high_scores.empty?
        high_scores_string = "No games have been scored yet."
      else
        high_scores_string = @game.high_scores.map do |high_score|
          "#{high_score.name} | Score: #{high_score.score} | Lines: #{high_score.lines} | Level: #{high_score.level}"
        end.join("\n")
      end
      msg_box('High Scores', high_scores_string)
      @game.paused = game_paused
    end
  end
  
  def show_about_dialog
    Glimmer::LibUI.queue_main do
      msg_box('About', 'Glimmer Tetris - Glimmer DSL for LibUI Example - Copyright (c) 2021-2022 Andy Maleh')
    end
  end
end

Tetris.new.launch
```

## Tic Tac Toe

[examples/tic_tac_toe.rb](/examples/tic_tac_toe.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/tic_tac_toe.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/tic_tac_toe'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-tic-tac-toe.png](/images/glimmer-dsl-libui-mac-tic-tac-toe.png) ![glimmer-dsl-libui-mac-tic-tac-toe-player-o-wins.png](/images/glimmer-dsl-libui-mac-tic-tac-toe-player-o-wins.png) ![glimmer-dsl-libui-mac-tic-tac-toe-player-x-wins.png](/images/glimmer-dsl-libui-mac-tic-tac-toe-player-x-wins.png) ![glimmer-dsl-libui-mac-tic-tac-toe-draw.png](/images/glimmer-dsl-libui-mac-tic-tac-toe-draw.png) | ![glimmer-dsl-libui-windows-tic-tac-toe.png](/images/glimmer-dsl-libui-windows-tic-tac-toe.png) ![glimmer-dsl-libui-windows-tic-tac-toe-player-o-wins.png](/images/glimmer-dsl-libui-windows-tic-tac-toe-player-o-wins.png) ![glimmer-dsl-libui-windows-tic-tac-toe-player-x-wins.png](/images/glimmer-dsl-libui-windows-tic-tac-toe-player-x-wins.png) ![glimmer-dsl-libui-windows-tic-tac-toe-draw.png](/images/glimmer-dsl-libui-windows-tic-tac-toe-draw.png) | ![glimmer-dsl-libui-linux-tic-tac-toe.png](/images/glimmer-dsl-libui-linux-tic-tac-toe.png) ![glimmer-dsl-libui-linux-tic-tac-toe-player-o-wins.png](/images/glimmer-dsl-libui-linux-tic-tac-toe-player-o-wins.png) ![glimmer-dsl-libui-linux-tic-tac-toe-player-x-wins.png](/images/glimmer-dsl-libui-linux-tic-tac-toe-player-x-wins.png) ![glimmer-dsl-libui-linux-tic-tac-toe-draw.png](/images/glimmer-dsl-libui-linux-tic-tac-toe-draw.png)

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version (with [data-binding](#data-binding)):

```ruby
require 'glimmer-dsl-libui'

require_relative "tic_tac_toe/board"

class TicTacToe
  include Glimmer

  def initialize
    @tic_tac_toe_board = Board.new
  end
  
  def launch
    create_gui
    register_observers
    @main_window.show
  end
  
  def register_observers
    observe(@tic_tac_toe_board, :game_status) do |game_status|
      display_win_message if game_status == Board::WIN
      display_draw_message if game_status == Board::DRAW
    end
  end

  def create_gui
    @main_window = window('Tic-Tac-Toe', 180, 180) {
      resizable false
      
      vertical_box {
        padded false
        
        3.times.map do |row|
          horizontal_box {
            padded false
            
            3.times.map do |column|
              area {
                square(0, 0, 60) {
                  stroke :black, thickness: 2
                }
                text(23, 19) {
                  string {
                    font family: 'Arial', size: OS.mac? ? 20 : 16
                    # data-bind string property of area text attributed string to tic tac toe board cell sign
                    string <= [@tic_tac_toe_board[row + 1, column + 1], :sign] # board model is 1-based
                  }
                }
                on_mouse_up do
                  @tic_tac_toe_board.mark(row + 1, column + 1) # board model is 1-based
                end
              }
            end
          }
        end
      }
    }
  end

  def display_win_message
    display_game_over_message("Player #{@tic_tac_toe_board.winning_sign} has won!")
  end

  def display_draw_message
    display_game_over_message("Draw!")
  end

  def display_game_over_message(message_text)
    Glimmer::LibUI.queue_main do
      msg_box('Game Over', message_text)
      @tic_tac_toe_board.reset!
    end
  end
end

TicTacToe.new.launch
```

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 2 (without [data-binding](#data-binding)):

```ruby

require 'glimmer-dsl-libui'

require_relative "tic_tac_toe/board"

class TicTacToe
  include Glimmer

  def initialize
    @tic_tac_toe_board = Board.new
  end
  
  def launch
    create_gui
    register_observers
    @main_window.show
  end
  
  def register_observers
    observe(@tic_tac_toe_board, :game_status) do |game_status|
      display_win_message if game_status == Board::WIN
      display_draw_message if game_status == Board::DRAW
    end
    
    3.times.map do |row|
      3.times.map do |column|
        observe(@tic_tac_toe_board[row + 1, column + 1], :sign) do |sign| # board model is 1-based
          @cells[row][column].string = sign
        end
      end
    end
  end
  
  def create_gui
    @main_window = window('Tic-Tac-Toe', 180, 180) {
      resizable false
      
      @cells = []
      vertical_box {
        padded false
        
        3.times.map do |row|
          @cells << []
          horizontal_box {
            padded false
            
            3.times.map do |column|
              area {
                square(0, 0, 60) {
                  stroke :black, thickness: 2
                }
                text(23, 19) {
                  @cells[row] << string('') {
                    font family: 'Arial', size: OS.mac? ? 20 : 16
                  }
                }
                on_mouse_up do
                  @tic_tac_toe_board.mark(row + 1, column + 1) # board model is 1-based
                end
              }
            end
          }
        end
      }
    }
  end

  def display_win_message
    display_game_over_message("Player #{@tic_tac_toe_board.winning_sign} has won!")
  end

  def display_draw_message
    display_game_over_message("Draw!")
  end

  def display_game_over_message(message_text)
    Glimmer::LibUI.queue_main do
      msg_box('Game Over', message_text)
      @tic_tac_toe_board.reset!
    end
  end
end

TicTacToe.new.launch
```

## Timer

To run this example, install [TiMidity](http://timidity.sourceforge.net) and ensure `timidity` command is in `PATH` (can be installed via [Homebrew](https://brew.sh) on Mac or [apt-get](https://help.ubuntu.com/community/AptGet/Howto) on Linux).

[examples/timer.rb](/examples/timer.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/timer.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/timer'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-timer.png](/images/glimmer-dsl-libui-mac-timer.png) ![glimmer-dsl-libui-mac-timer-in-progress.png](/images/glimmer-dsl-libui-mac-timer-in-progress.png) | ![glimmer-dsl-libui-windows-timer.png](/images/glimmer-dsl-libui-windows-timer.png) ![glimmer-dsl-libui-windows-timer-in-progress.png](/images/glimmer-dsl-libui-windows-timer-in-progress.png) | ![glimmer-dsl-libui-linux-timer.png](/images/glimmer-dsl-libui-linux-timer.png) ![glimmer-dsl-libui-linux-timer-in-progress.png](/images/glimmer-dsl-libui-linux-timer-in-progress.png)

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version (with [data-binding](#data-binding)):

```ruby
require 'glimmer-dsl-libui'

class Timer
  include Glimmer
  
  SECOND_MAX = 59
  MINUTE_MAX = 59
  HOUR_MAX = 23
  
  attr_accessor :hour, :min, :sec, :started, :played
  
  def initialize
    @pid = nil
    @alarm_file = File.expand_path('../sounds/AlanWalker-Faded.mid', __dir__)
    @hour = @min = @sec = 0
    at_exit { stop_alarm }
    setup_timer
    create_gui
  end

  def stop_alarm
    if @pid
      Process.kill(:SIGKILL, @pid) if @th.alive?
      @pid = nil
    end
  end

  def play_alarm
    stop_alarm
    if @pid.nil?
      begin
        @pid = spawn "timidity -G 0.0-10.0 #{@alarm_file}"
        @th = Process.detach @pid
      rescue Errno::ENOENT
        warn 'Timidty++ not found. Please install Timidity++.'
        warn 'https://sourceforge.net/projects/timidity/'
      end
    end
  end

  def setup_timer
    unless @setup_timer
      Glimmer::LibUI.timer(1) do
        if @started
          seconds = @sec
          minutes = @min
          hours = @hour
          if seconds > 0
            self.sec = seconds -= 1
          end
          if seconds == 0
            if minutes > 0
              self.min = minutes -= 1
              self.sec = seconds = SECOND_MAX
            end
            if minutes == 0
              if hours > 0
                self.hour = hours -= 1
                self.min = minutes = MINUTE_MAX
                self.sec = seconds = SECOND_MAX
              end
              if hours == 0 && minutes == 0 && seconds == 0
                self.started = false
                unless @played
                  play_alarm
                  msg_box('Alarm', 'Countdown Is Finished!')
                  self.played = true
                end
              end
            end
          end
        end
      end
      @setup_timer = true
    end
  end

  def create_gui
    window('Timer') {
      margined true
      
      group('Countdown') {
        vertical_box {
          horizontal_box {
            spinbox(0, HOUR_MAX) {
              stretchy false
              value <=> [self, :hour]
            }
            label(':') {
              stretchy false
            }
            spinbox(0, MINUTE_MAX) {
              stretchy false
              value <=> [self, :min]
            }
            label(':') {
              stretchy false
            }
            spinbox(0, SECOND_MAX) {
              stretchy false
              value <=> [self, :sec]
            }
          }
          horizontal_box {
            button('Start') {
              enabled <= [self, :started, on_read: :!]
              
              on_clicked do
                self.started = true
                self.played = false
              end
            }
            
            button('Stop') {
              enabled <= [self, :started]
              
              on_clicked do
                self.started = false
              end
            }
          }
        }
      }
    }.show
  end
end

Timer.new
```

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 2 (without [data-binding](#data-binding)):

```ruby
require 'glimmer-dsl-libui'

class Timer
  include Glimmer
  
  SECOND_MAX = 59
  MINUTE_MAX = 59
  HOUR_MAX = 23
  
  def initialize
    @pid = nil
    @alarm_file = File.expand_path('../sounds/AlanWalker-Faded.mid', __dir__)
    at_exit { stop_alarm }
    setup_timer
    create_gui
  end

  def stop_alarm
    if @pid
      Process.kill(:SIGKILL, @pid) if @th.alive?
      @pid = nil
    end
  end

  def play_alarm
    stop_alarm
    if @pid.nil?
      begin
        @pid = spawn "timidity -G 0.0-10.0 #{@alarm_file}"
        @th = Process.detach @pid
      rescue Errno::ENOENT
        warn 'Timidty++ not found. Please install Timidity++.'
        warn 'https://sourceforge.net/projects/timidity/'
      end
    end
  end

  def setup_timer
    unless @setup_timer
      Glimmer::LibUI.timer(1) do
        if @started
          seconds = @sec_spinbox.value
          minutes = @min_spinbox.value
          hours = @hour_spinbox.value
          if seconds > 0
            @sec_spinbox.value = seconds -= 1
          end
          if seconds == 0
            if minutes > 0
              @min_spinbox.value = minutes -= 1
              @sec_spinbox.value = seconds = SECOND_MAX
            end
            if minutes == 0
              if hours > 0
                @hour_spinbox.value = hours -= 1
                @min_spinbox.value = minutes = MINUTE_MAX
                @sec_spinbox.value = seconds = SECOND_MAX
              end
              if hours == 0 && minutes == 0 && seconds == 0
                @start_button.enabled = true
                @stop_button.enabled = false
                @started = false
                unless @played
                  play_alarm
                  msg_box('Alarm', 'Countdown Is Finished!')
                  @played = true
                end
              end
            end
          end
        end
      end
      @setup_timer = true
    end
  end

  def create_gui
    window('Timer') {
      margined true
      
      group('Countdown') {
        vertical_box {
          horizontal_box {
            @hour_spinbox = spinbox(0, HOUR_MAX) {
              stretchy false
              value 0
            }
            label(':') {
              stretchy false
            }
            @min_spinbox = spinbox(0, MINUTE_MAX) {
              stretchy false
              value 0
            }
            label(':') {
              stretchy false
            }
            @sec_spinbox = spinbox(0, SECOND_MAX) {
              stretchy false
              value 0
            }
          }
          horizontal_box {
            @start_button = button('Start') {
              on_clicked do
                @start_button.enabled = false
                @stop_button.enabled = true
                @started = true
                @played = false
              end
            }
            
            @stop_button = button('Stop') {
              enabled false
              
              on_clicked do
                @start_button.enabled = true
                @stop_button.enabled = false
                @started = false
              end
            }
          }
        }
      }
    }.show
  end
end

Timer.new
```

## Shape Coloring

This example demonstrates being able to nest listeners within shapes directly, and [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) will automatically detect when the mouse lands inside the shapes to notify listeners.

This example also demonstrates very basic drag and drop support, implemented manually with shape listeners.

[examples/shape_coloring.rb](/examples/shape_coloring.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/shape_coloring.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/shape_coloring'"
```

Shape Coloring Example

![glimmer-dsl-libui-mac-shape-coloring.png](/images/glimmer-dsl-libui-mac-shape-coloring.png)

![glimmer-dsl-libui-mac-shape-coloring-drag-and-drop.png](/images/glimmer-dsl-libui-mac-shape-coloring-drag-and-drop.png)

![glimmer-dsl-libui-mac-shape-coloring-color-dialog.png](/images/glimmer-dsl-libui-mac-shape-coloring-color-dialog.png)

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version:

```ruby
require 'glimmer-dsl-libui'

class ShapeColoring
  include Glimmer::LibUI::Application
  
  COLOR_SELECTION = Glimmer::LibUI.interpret_color(:red)
  
  before_body {
    @shapes = []
  }
  
  body {
    window('Shape Coloring', 200, 220) {
      margined false
      
      grid {
        label("Drag & drop shapes to move or\nclick a shape to select and\nchange color via color button") {
          left 0
          top 0
          hexpand true
          halign :center
          vexpand false
        }
        
        color_button { |cb|
          left 0
          top 1
          hexpand true
          vexpand false
          
          on_changed do
            @selected_shape&.fill = cb.color
          end
        }
      
        area {
          left 0
          top 2
          hexpand true
          vexpand true
          
          rectangle(0, 0, 600, 400) { # background shape
            fill :white
          }
          
          @shapes << colorable(:rectangle, 20, 20, 40, 20) {
            fill :lime
          }
          
          @shapes << colorable(:square, 80, 20, 20) {
            fill :blue
          }
          
          @shapes << colorable(:circle, 75, 70, 20) {
            fill :green
          }
          
          @shapes << colorable(:arc, 120, 70, 40, 0, 145) {
            fill :orange
          }
          
          @shapes << colorable(:polygon, 120, 10, 120, 50, 150, 10, 150, 50) {
            fill :cyan
          }
          
          @shapes << colorable(:polybezier, 20, 40,
                     30, 100, 50, 80, 80, 110,
                     40, 120, 20, 120, 30, 91) {
            fill :pink
          }
          
          on_mouse_dragged do |area_mouse_event|
            mouse_dragged(area_mouse_event)
          end
          
          on_mouse_dropped do |area_mouse_event|
            mouse_dropped(area_mouse_event)
          end
        }
      }
    }
  }
  
  def colorable(shape_symbol, *args, &content)
    send(shape_symbol, *args) do |shape|
      on_mouse_up do |area_mouse_event|
        unless @dragged_shape
          old_stroke = Glimmer::LibUI.interpret_color(shape.stroke).slice(:r, :g, :b)
          @shapes.each {|sh| sh.stroke = nil}
          @selected_shape = nil
          unless old_stroke == COLOR_SELECTION
            shape.stroke = COLOR_SELECTION.merge(thickness: 2)
            @selected_shape = shape
          end
        end
      end
      
      on_mouse_drag_started do |area_mouse_event|
        mouse_drag_started(shape, area_mouse_event)
      end
      
      on_mouse_dragged do |area_mouse_event|
        mouse_dragged(area_mouse_event)
      end
      
      on_mouse_dropped do |area_mouse_event|
        mouse_dropped(area_mouse_event)
      end
      
      content.call(shape)
    end
  end
  
  def mouse_drag_started(dragged_shape, area_mouse_event)
    @dragged_shape = dragged_shape
    @dragged_shape_x = area_mouse_event[:x]
    @dragged_shape_y = area_mouse_event[:y]
  end
  
  def mouse_dragged(area_mouse_event)
    if @dragged_shape && @dragged_shape_x && @dragged_shape_y
      x_delta = area_mouse_event[:x] - @dragged_shape_x
      y_delta = area_mouse_event[:y] - @dragged_shape_y
      @dragged_shape.move_by(x_delta, y_delta)
      @dragged_shape_x = area_mouse_event[:x]
      @dragged_shape_y = area_mouse_event[:y]
    end
  end
  
  def mouse_dropped(area_mouse_event)
    @dragged_shape = nil
    @dragged_shape_x = nil
    @dragged_shape_y = nil
  end
end

ShapeColoring.launch
```
