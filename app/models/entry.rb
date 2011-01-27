class Entry
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name
  field :twitter
  field :street
  field :suburb
  field :city
  field :country, :default => 'New Zealand'
  
  validates_presence_of :name, :twitter, :street, :city, :country
  validates_uniqueness_of :twitter
  
  embedded_in :questionnaire, :inverse_of => :entries
end