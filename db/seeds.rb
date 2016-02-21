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


$uid = 0
def get_unique_id
  $uid += 1
end


def random_slug
  {
    :uri => "#{Faker::Hacker.say_something_smart} #{get_unique_id}".slugify_trim,
    :sluggable_type => 'Page',
    :sluggable_id => get_unique_id
  }
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
# Create Settings
# ----------------------------------------

puts 'Creating Slugs'

slugs = []
(MULTIPLIER * NUM_SLUGS).times do
  slugs << random_slug
end
Slug.create(slugs)
slugs = Slug.all


# ----------------------------------------
# Create Template File Types
# ----------------------------------------

puts 'Creating TemplateFileTypes'

template_file_types = [
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
TemplateFileType.create(template_file_types)
template_file_types = TemplateFileType.all



# ----------------------------------------
# Finished Seeding!
# ----------------------------------------

puts 'done!'







