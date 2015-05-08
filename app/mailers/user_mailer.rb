class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def send(user)
    # byebug
    if block_given?
      # yield
      Proc.new.call
    else
      @user = user
      mail to: user.email, subject: "Hello"
    end
  end

  def account_activation user
    send user
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset user
    send user
  end
end
