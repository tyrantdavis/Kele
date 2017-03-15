class InvalidCredentialsError < StandardError
  def initialize(response = "Email or pasword incorrect. Please try again.")
    super(response)
  end
end