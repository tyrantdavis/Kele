require 'httparty'
require 'kele/errors'

class Kele
  include HTTParty

  def initialize(email, password)
    response = self.class.post(base_url('sessions'), body: {email: email, password: password} )
    raise InvalidCredentialsError.new if response.code == 401

    @auth_token = response['auth_token'] || (raise 'Nil returned.')
  end

  private

  def base_url(endpoint)
    "https://www.bloc.io/api/v1/#{endpoint}"
  end

end
