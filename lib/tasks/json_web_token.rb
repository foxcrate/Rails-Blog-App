class JsonWebToken
    class << self
      def encode(id)
        #payload[:exp] = exp.to_i
            # puts("Alooo From JWT Class");
            # puts(payload);
            # puts("Alooo From JWT Class");
        secret_key= Rails.application.secrets.secret_key_base[0]
        JWT.encode(id, secret_key)
        #JWT.encode user.id, secret_key
      end
   
      def decode(token)
        body = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
        HashWithIndifferentAccess.new body
      rescue
        nil
      end
    end
   end