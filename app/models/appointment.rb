class Appointment < ActiveRecord::Base
  attr_accessible :duration, :note, :start_time
end
