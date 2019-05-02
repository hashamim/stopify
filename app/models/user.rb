# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#

class User < ApplicationRecord
    validates :email, :session_token, presence: true, uniqueness: true
    validates :password_digest, presence: true
    validates :password, length: {minimum: 6, maximum: 25, message: "Must be between 6 andd 25 characters"}, allow_nil: true
    #attr_reader necessary for line validates :password line to work
    attr_reader :password

    after_initialize :ensure_session_token

    def self.find_by_credentials(email,password)
        u = User.find_by(email: email)
        if u && u.is_password?(password)
            u
        else
            nil
        end
    end

    def is_password?(password)
        encrypted_pw = BCrypt::Password.new(self.password_digest)
        encrypted_pw.is_password?(password)
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def self.generate_session_token
        SecureRandom::urlsafe_base64
    end

    def ensure_session_token
        self.session_token ||= self.class.generate_session_token
    end

    def reset_session_token!
        self.session_token = self.class.generate_session_token
        self.save
        self.session_token
    end
end
