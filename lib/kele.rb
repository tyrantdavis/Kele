require 'httparty'
require 'kele/errors'
require 'kele/roadmap'
require 'kele/messages'
require 'json'

class Kele
  include HTTParty
  include Roadmap
  include Messages

  def initialize(email, password)
    response = self.class.post(base_url('sessions'), body: {email: email, password: password} )
    raise InvalidCredentialsError.new if response.code == 401

    @auth_token = response['auth_token'] || (raise 'Nil returned.')
  end

  def get_me
    response = self.class.get(base_url('users/me'), headers: { authorization: @auth_token })
    @data = JSON.parse(response.body)
  end

  def get_mentor_availability(mentor_id)
    response = self.class.get(base_url("mentors/#{mentor_id}/student_availability"), headers: {authorization: @auth_token})
    @mentor_availability = JSON.parse(response.body)
  end

  def create_submission(enrollment_id, assignment_branch, assignment_commit_link, checkpoint_id, comment)
    response = self.class.post(base_url('checkpoint_submissions'), body: { enrollment_id: enrollment_id, assignment_branch: assignment_branch, assignment_commit_link: assignment_commit_link, checkpoint_id: checkpoint_id, comment: comment }, headers: { authorization: @auth_token } )
 puts response
  end


  private

  def base_url(endpoint)
    "https://www.bloc.io/api/v1/#{endpoint}"
  end

end
