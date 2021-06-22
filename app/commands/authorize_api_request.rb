class AuthorizeApiRequest
    prepend SimpleCommand
  
    # def initialize(headers = {})
    #   @headers = headers
    # end

    def initialize(header)
      @header = header
    end
  
    def call
      user
    end
  
    private
  
    attr_reader :header
  
    def user
      @user ||= User.find(decoded_auth_token) if decoded_auth_token
      @user || errors.add(:token, 'Invalid token') && nil
    end
  
    def decoded_auth_token
      secret_key= Rails.application.secrets.secret_key_base[0]
      #if headers['Authorization'].present?
        #header = headers['Authorization'].split(' ').last
        decoded_auth_token = JWT.decode(header, secret_key , false)
      #else
        errors.add(:token, 'Missing token')
      # end
      # nil

      ##decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
      # secret_key= Rails.application.secrets.secret_key_base[0]
      # decoded_auth_token ||= JWT.decode(http_auth_header , secret_key , false)
    end
  
    # def http_auth_header
    #   if headers['Authorization'].present?
    #     return headers['Authorization'].split(' ').last
    #   else
    #     errors.add(:token, 'Missing token')
    #   end
    #   nil
    # end
  end