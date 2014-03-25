class Contact < ActiveRecord::Base
  attr_accessible :email, :name, :phone ,:phone_country_code

  validates_presence_of :name
  validates_presence_of :email, :if => "phone.blank?", :message => "Phone or Email must be supplied"
  validates_presence_of :phone, :if => "email.blank?", :message => "Phone or Email must be supplied"
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :allow_blank => true


  def self.generate_test_data

    100.times do

      Contact.create!({
                          :name => Faker::Name.name,
                          :email => Faker::Internet.email,
                          :phone => Faker::PhoneNumber.phone_number
                      }

      )
    end
  end


end
