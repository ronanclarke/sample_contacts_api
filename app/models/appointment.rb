class Appointment < ActiveRecord::Base
  attr_accessible :duration, :note, :start_time, :contact_id

  validates_presence_of :note


end
