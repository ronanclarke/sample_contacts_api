class Appointment < ActiveRecord::Base
  attr_accessible :duration, :note, :start_time

  validates_presence_of :note


end
