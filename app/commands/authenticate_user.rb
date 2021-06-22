class AuthenticateUser
    prepend SimpleCommand
  
    def initialize(email, password)
      @email = email
      @password = password
    end
  
    def call
      secret_key= Rails.application.secrets.secret_key_base[0]
      JWT.encode(user.id, secret_key) if user
      #JsonWebToken.encode(2) if user
    end
  
    private
  
    attr_accessor :email, :password
  
    def user
      user = User.find_by(email: email);
    #   puts("Alooo");
    #   puts(user.authenticate(password).id);
    #   puts("Alooo");
      return user if user && user.authenticate(password)
  
      errors.add :user_authentication, 'invalid credentials'
      nil
    end
end