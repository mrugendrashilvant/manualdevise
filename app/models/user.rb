class User < ApplicationRecord
    attr_accessor :password  #temporary storage, not available as a column

    # add validations
    validates :f_name, :l_name, :email, :date_of_birth, :password, presence: true
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i  
    validates :email, presence: true, length: { maximum: 105 },            
                        uniqueness: { case_sensitive: false },            
                        format: { with: VALID_EMAIL_REGEX }
    validates :password, length: {minimum: 6}
    before_save {self.email = email.downcase}
    before_save :encrypt_password

    def self.authenticate(user_email, user_pass)
        user = User.find_by_email(user_email)
        return user if user && user.password_valid?(user_pass)
    end

    def password_valid?(pass)
        self.hashed_password == encrypt(pass)
    end

        def encrypt_password
            return if password.blank?
            self.hashed_password = encrypt(password)
        end

        def encrypt(string)
            Digest::SHA1.hexdigest(string)
        end
end
