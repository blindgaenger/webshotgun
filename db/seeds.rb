# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

Page.create :name => 'Google',        :url => 'http://www.google.de/'
Page.create :name => 'Yahoo',         :url => 'http://www.yahoo.de/'
Page.create :name => 'Avocado Store', :url => 'http://www.avocadostore.de/'
Page.create :name => 'blindgaenger',  :url => 'http://blindgaenger.net/'