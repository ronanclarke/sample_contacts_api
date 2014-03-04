class AppointmentsController < ApplicationController
  # GET /appointments
  # GET /appointments.json

  before_filter :set_default_response_format
  skip_before_filter :verify_authenticity_token

  def set_default_response_format
    request.format = :json
  end

  
  api :GET, 'appointments', "Return all appointments"
  example 'curl http://hidden-oasis-1864.herokuapp.com/appointments'
  example 'Example Response
[
  {
    "contact_id": null,
    "created_at": "2013-08-19T22:35:15Z",
    "duration": 500,
    "id": 1,
    "note": "test",
    "start_time": "2013-08-19T22:35:00Z",
    "updated_at": "2013-08-20T19:33:39Z"
  },
  {
    "contact_id": null,
    "created_at": "2013-08-19T22:35:40Z",
    "duration": 4343,
    "id": 2,
    "note": "one more",
    "start_time": "2013-09-19T22:35:00Z",
    "updated_at": "2013-08-19T22:35:40Z"
  },
  {
    "contact_id": null,
    "created_at": "2013-08-20T22:59:06Z",
    "duration": null,
    "id": 3,
    "note": "test",
    "start_time": null,
    "updated_at": "2013-08-20T22:59:06Z"
  }
]'

  def index
    @appointments = Appointment.all
    render json: @appointments
  end


  api :GET, 'appointments/{:id}', "Return a single appointment"
  example 'curl http://hidden-oasis-1864.herokuapp.com/appointments/1'
  example 'Example Response
  {
    "contact_id": null,
    "created_at": "2013-08-19T22:35:15Z",
    "duration": 500,
    "id": 1,
    "note": "test",
    "start_time": "2013-08-19T22:35:00Z",
    "updated_at": "2013-08-20T19:33:39Z"
  }'
  def show
    @appointment = Appointment.find(params[:id])
    render json: @appointment
  end


  api :POST, 'appointments', "Create a new appointment"
  param :note, String, :desc => "Note on the appointment"
  param :start_time, String, :desc => "Time the appointment commences at"
  param :duration, Integer, :desc => "Duration of the appointment in seconds"
  param :contact_id, Integer, :desc => "Id of the contact linked to this appointment"
  example 'curl -X POST -d "note=test&duration=500&contact_id=2&start_time=2013-08-20T20:23:36Z" http://hidden-oasis-1864.herokuapp.com/appointments'
  example 'Example Response
{
  "contact_id": 2,
  "created_at": "2013-08-20T23:05:39Z",
  "duration": 500,
  "id": 10,
  "note": "test",
  "start_time": "2013-08-20T20:23:36Z",
  "updated_at": "2013-08-20T23:05:39Z"
}'
  # POST /appointments
  # POST /appointments.json
  def create
    @appointment = Appointment.new(
        :note => params[:note],
        :start_time => params[:start_time],
        :duration => params[:duration],
        :contact_id => params[:contact_id]
    )

    if @appointment.save
      render json: @appointment, status: :created, location: @appointment
    else
      render json: @appointment.errors, status: :unprocessable_entity
    end

  end

  api :PUT, 'appointments/{:id}', "Update an appointment"
  param :note, String, :desc => "Note on the appointment"
  param :start_time, String, :desc => "Time the appointment commences at"
  param :duration, String, :desc => "Duration of the appointment in seconds"
  param :contact_id, String, :desc => "Id of the contact linked to this appointment"
  example 'curl -X PUT -d "note=updated&duration=500&contact_id=2&start_time=2013-08-20T20:23:36Z" http://hidden-oasis-1864.herokuapp.com/appointments/10'
  example 'Example Response
{
  "contact_id": 2,
  "created_at": "2013-08-20T23:05:39Z",
  "duration": 500,
  "id": 10,
  "note": "updated",
  "start_time": "2013-08-20T20:23:36Z",
  "updated_at": "2013-08-20T23:15:11Z"
}'

  def update
    @appointment = Appointment.find(params[:id])

    @appointment.start_time= params[:start_time]
    @appointment.duration= params[:duration]
    @appointment.note= params[:note]
    @appointment.contact_id= params[:contact_id]

    if @appointment.save
      render json: @appointment, status: :ok, location: @appointment
    else
      render json: @appointment.errors, status: :unprocessable_entity
    end

  end

  # DELETE /appointments/1
  # DELETE /appointments/1.json
  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.destroy

    respond_to do |format|
      format.html { redirect_to appointments_url }
      format.json { head :no_content }
    end
  end
end
