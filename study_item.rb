require 'sqlite3'
require_relative 'study'

class StudyItem
  attr_reader :id, :title, :category

  @@next_id = 1
  @@study_items = []

  def initialize(title:, category:)
    @id = @@next_id
    @title = title
    @category = category

    @@next_id += 1
    @@study_items << self
  end

  def include?(query)
    title.include?(query) || category.include?(query)
  end

end