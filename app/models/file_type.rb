class FileType < ActiveRecord::Base
  HTML = 'html'
  MARKDOWN = 'md'
  LIQUID_HTML = 'html.liquid'
  LIQUID_MARKDOWN = 'md.liquid'


  has_many :data_files, :dependent => :nullify


  def liquid?
    [LIQUID_HTML, LIQUID_MARKDOWN].include?(extension)
  end


  def markdown?
    [MARKDOWN, LIQUID_MARKDOWN].include?(extension)
  end


  def html?
    [HTML, LIQUID_HTML].include?(extension)
  end
end
