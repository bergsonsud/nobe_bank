require 'rails_helper'
require 'devise'

RSpec.describe 'Acesso', type: :system do
  let(:user) { User.new( name: 'user',email: 'user@mail.com', password: '12345678')}
  let(:user2) { User.new( name: 'user2',email: 'user2@mail.com', password: '12345678')}

	describe "Acesso a conta" do
		it "Registrando novo usuário" do
			visit "/"
			click_link "Criar nova conta"
			fill_in "user_name", with: user.name
			fill_in "user_email", with: user.email
			fill_in "user_password", with: user.password
			click_button "Criar"
		end

    it "Acessar conta" do
      user2.save
			visit "/"
			fill_in "user_email", with: user2.email
			fill_in "user_password", with: user2.password
			click_button "Entrar"
		end

    it "Logout" do
      user2.save
			visit "/"
			fill_in "user_email", with: user2.email
			fill_in "user_password", with: user2.password
			click_button "Entrar"
      click_link user2.name
      click_link "Sair"
      page.driver.browser.switch_to.alert.accept
		end
	end

end
