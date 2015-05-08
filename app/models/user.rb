class User < ActiveRecord::Base


	validates_confirmation_of :password#, :if=>:password_changed?

    before_save :email_downcase, :hash_password

	  attr_accessor :new_password,:password_confirmation, :signin, :remember_token
    attr_accessor :activation_token, :reset_token
    validates :username,  presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

    # def password_changed?
    #   !@new_password.blank?
    # end
    
    def self.digest string 
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def self.authenticate(signin, password)
      if user = where('email = :value or username= :value',{ value: signin}).first
        if BCrypt::Password.new(user.password).is_password? password
          return user
        end
      end
      return nil
    end

    def self.new_token
      SecureRandom.urlsafe_base64
    end

    def forget
      update_attribute(:remember_digest, nil)
    end

    def remember
      self.remember_token = self.new_token
      update_attribute(:remember_digest, self.digest(remember_token) )
    end



    def send_activation_email
      UserMailer.account_activation(self).deliver_now
    end

    def activate
      update_attribute(:activated,    true)
      update_attribute(:activated_at, Time.zone.now)
    end

    def create_reset_digest
      self.reset_token = User.new_token
      update_attribute(:reset_digest, User.digest(reset_token))
      update_attribute(:reset_sent_at, Time.zone.now)
    end

    def send_password_reset_email
      UserMailer.password_reset(self).deliver_now
    end


    # def authenticated?(remember_token)
    #   BCrypt::Password.new(remember_digest).is_password?(remember_token)
    # end

    def authenticated?(attribute, token)
      digest = self.send("#{attribute}_digest")
      return false if digest.nil?
      BCrypt::Password.new(digest).is_password?(token)
    end

    protected

      def email_downcase
        self.email = email.downcase 
      end

      def create_activition_digest
        self.activition_token = User.new_token
        self.activition_digest = User.digest(activition_token)
      end

	    def hash_password
	      if self.password_digest != self.password
	        self.password = User.digest self.password
	        self.password_digest = self.password
	      end
	    end
end
