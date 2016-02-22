# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# ----------------------------------------
# Reset Database
# ----------------------------------------

if Rails.env == 'development'
  puts 'Destroying old data'
  Rake::Task['db:migrate:reset'].invoke
  puts 'Data destroyed!'
end


# ----------------------------------------
# Config and Helpers
# ----------------------------------------

MULTIPLIER = 1
NUM_SETTING_TYPES = 5
NUM_SETTINGS = 100
NUM_SLUGS = 50
NUM_TEMPLATE_LAYOUTS = 5
NUM_PAGES = 10
NUM_PARTIALS = 10


$uid = 0
def get_unique_id
  $uid += 1
end


def random_setting_type
  {
    :name => "#{Faker::Hacker.noun} #{get_unique_id}".titleize
  }
end


def random_setting(setting_type)
  {
    :key => "#{Faker::Hacker.verb}_#{get_unique_id}",
    :value => "#{Faker::Hacker.say_something_smart}",
    :setting_type_id => setting_type.id
  }
end


def random_template_layout(file_type)
  unique_id = get_unique_id
  {
    :name => "#{Faker::Team.creature}_#{unique_id}",
    :data_file_attributes => {
      :file_type_id => file_type.id,
      :body => %Q;<!DOCTYPE>
<html>
  <head>
    <title>Layout #{unique_id}</title>
  </head>
  <body>
    <h1>Layout #{unique_id}</h1>
    {{ yield }}
  </body>
</html>
;
    }
  }
end


def random_data_file_body(file_type)
  {
    'md' => '# This is a Markdown template',
    'html' => '<p>This is an HTML template</p>',
    'md.liquid' => '# This is a Liquid Markdown template',
    'html.liquid' => '<p>This is an Liquid HTML template</p>'
  }[file_type.extension]
end


def random_page(template_layout, file_type, title=nil)
  title ||= "#{Faker::Hacker.say_something_smart} #{get_unique_id}"
  {
    :title => title,
    :slug_attributes => {
      :uri => title.slugify_trim
    },
    :view_attributes => {
      :template_layout_id => template_layout ? template_layout.id : nil,
      :data_file_attributes => {
        :body => random_data_file_body(file_type),
        :file_type_id => file_type.id
      }
    }
  }
end


def random_partial(file_type)
  name = "#{Faker::Team.creature}_#{get_unique_id}"
  {
    :name => name,
    :data_file_attributes => {
      :body => random_data_file_body(file_type),
      :file_type_id => file_type.id
    }
  }
end


# ----------------------------------------
# Create Users
# ----------------------------------------

puts 'Creating users'

User.new(
  :username => 'foobar',
  :email => 'foo@bar.com',
  :password => 'password'
).save!(:validate => false)
user = User.first


# ----------------------------------------
# Create SettingTypes
# ----------------------------------------

puts 'Creating SettingTypes'

setting_types = []
(MULTIPLIER * NUM_SETTING_TYPES).times do
  setting_types << random_setting_type
end
SettingType.create(setting_types)
setting_types = SettingType.all


# ----------------------------------------
# Create Settings
# ----------------------------------------

puts 'Creating Settings'

settings = []
(MULTIPLIER * NUM_SETTINGS).times do
  settings << random_setting(setting_types.sample)
end
Setting.create(settings)
settings = Setting.all


# ----------------------------------------
# Create File Types
# ----------------------------------------

puts 'Creating FileTypes'

file_types = [
  {
    :name => 'Markdown',
    :extension => 'md'
  },
  {
    :name => 'HTML',
    :extension => 'html'
  },
  {
    :name => 'Liquid Markdown',
    :extension => 'md.liquid'
  },
  {
    :name => 'Liquid HTML',
    :extension => 'html.liquid'
  }
]
FileType.create(file_types)
file_types = FileType.all


# ----------------------------------------
# Create Partials
# ----------------------------------------

puts 'Creating Partials'

partials = []
NUM_PARTIALS.times do
  partials << random_partial(file_types.sample)
end
Partial.create(partials)
partials = Partial.all


# ----------------------------------------
# Create TemplateLayouts
# ----------------------------------------

puts 'Creating TemplateLayouts'

template_layouts = []
liquid_html_file_type = file_types.where(:name => 'Liquid HTML').first
NUM_TEMPLATE_LAYOUTS.times do
  template_layouts << random_template_layout(liquid_html_file_type)
end
TemplateLayout.create(template_layouts)
template_layouts = TemplateLayout.all


# ----------------------------------------
# Create Pages
# ----------------------------------------

puts 'Creating Pages'

pages = [
  random_page(nil, file_types.sample, 'Home')
]
NUM_PAGES.times do
  template_layout = [template_layouts.sample, nil].sample
  pages << random_page(template_layout, file_types.sample)
end
Page.create(pages)
pages = Page.all


# ----------------------------------------
# Add Partial Rendering Calls
# ----------------------------------------

puts 'Adding Partial Rendering Calls'

(MULTIPLIER * NUM_PARTIALS).times do
  data_file = [partials.sample, pages.sample.view, template_layouts.sample].sample.data_file
  if data_file.data_fileable.is_a?(Partial)
    partial = partials.where('id != ?', data_file.data_fileable.id)
  else
    partial = partials.sample
  end
  data_file.body << "{% partial '#{partial.name}' %}"
  data_file.save!
end


# ----------------------------------------
# Finished Seeding!
# ----------------------------------------

puts 'done!'







