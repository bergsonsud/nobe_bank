require 'rails_helper'
require 'devise'

RSpec.describe 'Transações', type: :system do
  let(:user) { User.new( name: 'user',email: 'user@mail.com', password: '12345678')}
  let(:user2) { User.new( name: 'user2',email: 'user2@mail.com', password: '12345678')}

	describe "Realizar Transações" do

    it "Realizar depósito" do
      user.save
			visit "/"
			fill_in "user_email", with: user.email
			fill_in "user_password", with: user.password
			click_button "Entrar"
      click_link "Transações"
      click_link "Depósito"
      fill_in "value", with: 100
      click_button "Efetuar"
      expect(page).to have_content('Operação realizada com sucesso!')
		end

    it "Realizar saque" do
      user.save
      user.accounts.first.update({:amount => 1000})
			visit "/"
			fill_in "user_email", with: user.email
			fill_in "user_password", with: user.password
			click_button "Entrar"
      click_link "Transações"
      click_link "Saque"
      fill_in "value", with: 100
      click_button "Efetuar"
      expect(page).to have_content('Operação realizada com sucesso!')
		end

    it "Não realizar saque: saldo insuficiente" do
      user.save
			visit "/"
			fill_in "user_email", with: user.email
			fill_in "user_password", with: user.password
			click_button "Entrar"
      click_link "Transações"
      click_link "Saque"
      fill_in "value", with: 100
      click_button "Efetuar"
      expect(page).to have_content('Saldo insuficiente!')
		end

    it "Realizar transferência entre contas" do
      user.save
      user.accounts.first.update({:amount => 1000})
      user2.save
			visit "/"
			fill_in "user_email", with: user.email
			fill_in "user_password", with: user.password
			click_button "Entrar"
      click_link "Transações"
      click_link "Transferência"
      fill_in "value", with: 100
      fill_in "account_recipient", with: user2.accounts.first.id
      click_button "Efetuar"
      expect(page).to have_content('Operação realizada com sucesso!')
		end

    it "Não realizar transferência: Conta inexistente" do
      user.save
      user.accounts.first.update({:amount => 1000})
			visit "/"
			fill_in "user_email", with: user.email
			fill_in "user_password", with: user.password
			click_button "Entrar"
      click_link "Transações"
      click_link "Transferência"
      fill_in "value", with: 100
      fill_in "account_recipient", with: 99999
      click_button "Efetuar"
      expect(page).to have_content('Conta inexistente!')
		end

    it "Não realizar transferência: trasnferência para sua própria conta" do
      user.save
      user.accounts.first.update({:amount => 1000})
			visit "/"
			fill_in "user_email", with: user.email
			fill_in "user_password", with: user.password
			click_button "Entrar"
      click_link "Transações"
      click_link "Transferência"
      fill_in "value", with: 100
      fill_in "account_recipient", with: user.accounts.first.id
      click_button "Efetuar"
      expect(page).to have_content('Não é permitido fazer trasnferência para sua própria conta!')
		end

	end

end
