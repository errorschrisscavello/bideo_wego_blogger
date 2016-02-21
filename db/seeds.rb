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
    :key => "#{Faker::Hacker.verb}-#{get_unique_id}",
    :value => "#{Faker::Hacker.say_something_smart}",
    :setting_type_id => setting_type.id
  }
end


def random_template_layout(file_type)
  unique_id = get_unique_id
  {
    :name => "#{Faker::Team.creature} #{unique_id}",
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


def random_template_body(file_type)
  {
    'md' => '# This is a Markdown template',
    'html' => '<p>This is an HTML template</p>',
    'md.liquid' => '# This is a Liquid Markdown template',
    'html.liquid' => '<p>This is an Liquid HTML template</p>'
  }[file_type.extension]
end


def random_page(template_layout, file_type)
  title = "#{Faker::Hacker.say_something_smart} #{get_unique_id}"
  {
    :title => title,
    :slug_attributes => {
      :uri => title.slugify_trim
    },
    :view_attributes => {
      :template_layout_id => template_layout ? template_layout.id : nil,
      :data_file_attributes => {
        :body => random_template_body(file_type),
        :file_type_id => file_type.id
      }
    }
  }
end


# ----------------------------------------
# Create Users
# ----------------------------------------

puts 'Creating users'

User.create(
  :username => 'foobar1234',
  :email => 'foo1234@bar.com',
  :password => 'password'
)
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

pages = []
NUM_PAGES.times do
  template_layout = [template_layouts.sample, nil].sample
  pages << random_page(template_layout, file_types.sample)
end
Page.create(pages)
pages = Page.all


# ----------------------------------------
# Finished Seeding!
# ----------------------------------------

puts 'done!'







