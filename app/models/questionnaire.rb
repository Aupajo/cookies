class Questionnaire
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name
  field :max_entries, :type => Integer, :default => 5
  embeds_many :entries
  
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_numericality_of :max_entries, :greater_than => 0
  
  def open?
    entries.count < max_entries
  end
  
  def remaining
    max_entries - entries.count
  end
end