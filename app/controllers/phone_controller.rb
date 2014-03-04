class PhoneController < ApplicationController


  api :GET, 'check-phone-number/{:country_code}/{:phone_number}', "Check if a phone number is valid"
  param :country_code, String, :desc => "ISO country code of the phone number we wish to test"
  param :phone_number, String, :desc => "The phone number as entered by the user"
  example 'curl http://hidden-oasis-1864.herokuapp.com/check-phone-number/ie/0879899989'
  example 'Example Response
{
"valid": true,
"country": "ie",
"number": "0879899989"
}'
  def check

    country = params[:country_id]
    number = params[:phone_number]

    begin

      is_valid = Phonelib.valid_for_country? number, country

    rescue
      error = {
          message: "Invalid input - is your country code correct"
      }
      return render json: error, status: :unprocessable_entity
    end


    response = {
        :valid => is_valid,
        :country => country,
        :number => number
    }

    render json: response


  end


end