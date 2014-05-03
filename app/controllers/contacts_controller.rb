class ContactsController < ApplicationController
  # GET /contacts
  # GET /contacts.json


  before_filter :set_default_response_format


  def set_default_response_format
    request.format = :json
  end


  api :GET, 'contacts', "Return all contacts"
  example 'curl http://hidden-oasis-1864.herokuapp.com/contacts'
  api :GET, 'contacts?q=param', "Return all contacts with a name, email or phone that contains 'param'"
  example 'curl http://hidden-oasis-1864.herokuapp.com/contacts?q=974'
  example 'Example Response
[
  {
    "created_at": "2013-08-20T20:58:41Z",
    "email": "arianna_labadie@schmeler.net",
    "id": 8,
    "name": "Nicklaus Jerde",
    "phone": "759-786-0974 x13952",
    "phone_country_code": "IE"
    "updated_at": "2013-08-20T20:58:41Z"
  },
  {
    "created_at": "2013-08-20T20:58:49Z",
    "email": "bud.boyle@schuster.com",
    "id": 871,
    "name": "Burnice Goyette",
    "phone": "974-926-5643",
    "phone_country_code": "IE"
    "updated_at": "2013-08-20T20:58:49Z"
  }
]'

  def index


    if params[:q].blank?
      @contacts = Contact.all
    else
      q = "%#{params[:q]}%"
      @contacts = Contact.where("name like ? or email like ? or phone like ? ", q, q, q)
    end


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contacts }
    end
  end

  api :GET, 'contacts/{:id}', "Return a single contact"
  example 'curl http://hidden-oasis-1864.herokuapp.com/contacts/8'

  example 'Example Response

  {
    "created_at": "2013-08-20T20:58:41Z",
    "email": "arianna_labadie@schmeler.net",
    "id": 8,
    "name": "Nicklaus Jerde",
    "phone": "759-786-0974 x13952",
    "phone_country_code": "IE"
    "updated_at": "2013-08-20T20:58:41Z"
  },
'

  def show
    @contact = Contact.find(params[:id])


    render json: @contact
  []
  end

  api :POST, 'contacts', 'Create a Contact'
  param :name, String, :required => true, :desc => 'Contact Name'
  param :phone, String, :desc => 'Either phone or email must be present'
  param :phone_country_code, String, :desc => 'ISO country code'
  param :email, String, :desc => 'Either phone or email must be present'
  example 'curl -d "name=test&phone=123@email=test@test.com" http://hidden-oasis-1864.herokuapp.com/contacts'
  example 'Example Response
{
  "created_at": "2013-08-20T22:36:39Z",
  "email": null,
  "id": 1011,
  "name": "test",
  "phone": "0989080809809",
  "phone_country_code": "IE"
  "updated_at": "2013-08-20T22:36:39Z"
}'


  def create
    @contact = Contact.new(
        :name => params[:name],
        :email => params[:email],
        :phone => params[:phone],
        :phone_country_code => params[:phone_country_code]
    )

    if @contact.save
      render json: @contact, status: :created, location: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end

  end

  api :PUT, 'contacts/{:id}', 'Update a Contact'
  param :name, String, :required => true, :desc => 'Contact Name'
  param :phone, String, :desc => 'Either phone or email must be present'
  param :email, String, :desc => 'Either phone or email must be present'
  example 'curl -X PUT -d "name=updatedname&phone=123&email=test@test.com" http://hidden-oasis-1864.herokuapp.com/contacts/2'
  example 'Example Response
{
  "created_at": "2013-08-20T20:23:36Z",
  "email": "test@test.com",
  "id": 2,
  "name": "updatedname",
  "phone": "123",
  "phone_country_code": "IE"
  "updated_at": "2013-08-20T22:50:13Z"
}'

  def update
    @contact = Contact.find(params[:id])

    @contact.name = params[:name] if params[:name]
    @contact.email = params[:email] if params[:email]
    @contact.phone = params[:phone] if params[:phone]
    @contact.phone_country_code = params[:phone_country_code] if params[:phone_country_code]


    if @contact.save

      render json: @contact
    else

      render json: @contact.errors, status: :unprocessable_entity
    end

  end

# DELETE /contacts/1
# DELETE /contacts/1.json
  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy

    respond_to do |format|
      format.html { redirect_to contacts_url }
      format.json { head :no_content }
    end
  end

end
