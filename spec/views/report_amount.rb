require 'rails_helper'
require 'devise'

RSpec.describe 'Extrato', type: :system do
  let(:user) { User.new( name: 'user',email: 'user@mail.com', password: '12345678')}
  let(:user2) { User.new( name: 'user2',email: 'user2@mail.com', password: '12345678')}

	describe "Realizar Transações e consultar extrato" do

    it "Consultar extrato simples" do
      user.save
      user2.save
			visit "/"
			fill_in "user_email", with: user.email
			fill_in "user_password", with: user.password
			click_button "Entrar"

      click_link "Transações"
      click_link "Depósito"
      fill_in "value", with: 100000
      click_button "Efetuar"

      click_link "Transações"
      click_link "Saque"
      fill_in "value", with: 10000
      click_button "Efetuar"

      click_link "Transações"
      click_link "Transferência"
      fill_in "value", with: 10000
      fill_in "account_recipient", with: user2.accounts.first.id

      click_button "Efetuar"

      click_link "Extratos"
      click_link "Extrato"

      expect(page).to have_content('Extrato')
      expect(page).to have_content('Depósito')
      expect(page).to have_content('Saque')
      expect(page).to have_content('Transferência')
		end

    it "Consultar extrato periodo" do
      user.save
      user2.save
			visit "/"
			fill_in "user_email", with: user.email
			fill_in "user_password", with: user.password
			click_button "Entrar"

      click_link "Transações"
      click_link "Depósito"
      fill_in "value", with: 100000
      click_button "Efetuar"

      click_link "Transações"
      click_link "Transferência"
      fill_in "value", with: 10000
      fill_in "account_recipient", with: user2.accounts.first.id
      click_button "Efetuar"

      click_link "Extratos"
      click_link "Extrato por período"

      fill_in "start_date",with: (Time.zone.now - 7.days).strftime('%d/%m/%Y')
      fill_in "end_date",with: (Time.zone.now).strftime('%d/%m/%Y')
      click_button "Filtrar"      

      expect(page).to have_content('Extrato')
      expect(page).to have_content('Transferência')
      expect(page).to have_content('Depósito')

		end

	end

end
