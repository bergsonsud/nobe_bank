require 'rails_helper'

describe Transaction do
	let(:user) { User.new( name: 'user',email: 'user@mail.com', password: '12345678')}
	let(:account) { Account.new(user_id: user.id, amount: 0)}
	
	let(:saque) { Transaction.new(type_transaction: 1, account_id: account.id,  value: 30, description: nil, date: Time.zone.now)}
	let(:deposito) { Transaction.new(type_transaction: 2, account_id: account.id,  value: 100, description: nil, date: Time.zone.now)}
	let(:transferencia) { Transaction.new(type_transaction: 3, account_id: account.id, value: 20, description: nil, date: Time.zone.now)}

	let(:domingo) { Date.parse('10-01-2021') }
	let(:quarta_manha) {Time.local(2021, 1, 06, 9, 0, 0).to_datetime}
	let(:quarta_noite) {Time.local(2021, 1, 06, 19, 0, 0).to_datetime}

	let(:transferencia2) { Transaction.new(type_transaction: 3, account_id: account.id, value: 20, description: nil, date: domingo)}	
	let(:transferencia3) { Transaction.new(type_transaction: 3, account_id: account.id, value: 10, description: nil, date: quarta_manha)}	
	let(:transferencia4) { Transaction.new(type_transaction: 3, account_id: account.id, value: 100, description: nil, date: quarta_noite)}	
	let(:transferencia5) { Transaction.new(type_transaction: 3, account_id: account.id, value: 1100, description: nil, date: quarta_manha)}	
	let(:transferencia6) { Transaction.new(type_transaction: 3, account_id: account.id, value: 1100, description: nil, date: quarta_noite)}	
	let(:transferencia7) { Transaction.new(type_transaction: 3, account_id: account.id, value: 0, description: nil, date: quarta_noite)}	

	let(:normal) {5}
	let(:fim_semana_ou_noite) {7}
	let(:extra) {10}

	it "Realizar depósito sem saldo em conta" do
		user.save
		account.save 		
		expect(deposito).to be_valid 
	end 

	it "Realizar depósito com saldo em conta" do
		user.save
		account.amount = 100
		account.save 		
		expect(deposito).to be_valid 
	end 

	it "Realizar saque sem saldo em conta" do
		user.save
		account.save 			
		expect(saque).to be_invalid 
	end 

	it "Realizar saque com saldo em conta" do
		user.save		
		account.save 		
		deposito.save	
		expect(saque).to be_valid 
	end 

	it "Realizar transferência sem saldo sem saldo" do
		user.save
		account.save 			
		expect(transferencia).to be_invalid 
	end 

	it "Realizar transferência com saldo com saldo" do
		user.save		
		account.save 		
		deposito.save	
		expect(transferencia).to be_valid 
	end

	it "Não salvar transferência com valor zero" do
		user.save		
		account.save 		
		deposito.save	
		expect(transferencia7.save).to eq(false)
	end	

	it "Verificar taxa com transferência no final de semana" do
		user.save		
		account.amount = 500
		account.save				
		transferencia2.save
		expect(transferencia2.tax).to eq(fim_semana_ou_noite)
	end

	it "Verificar taxa com transferência no final de semana" do
		user.save		
		account.amount = 500
		account.save				
		transferencia2.save
		expect(transferencia2.tax).to eq(fim_semana_ou_noite)
	end	

	it "Verificar taxa com transferência semana em horário normal" do
		user.save		
		account.amount = 500
		account.save				
		transferencia3.save		
		expect(transferencia3.tax).to eq(normal)
	end	

	it "Verificar taxa com transferência semana durante a noite" do
		user.save		
		account.amount = 500
		account.save				
		transferencia4.save		
		expect(transferencia4.tax).to eq(fim_semana_ou_noite)
	end	

	it "Verificar taxa extra com transferência semana em horário normal" do
		user.save		
		account.amount = 500
		account.save				
		transferencia5.save		
		expect(transferencia5.tax).to eq(normal+extra)
	end	

	it "Verificar taxa extra com transferência semana durante a noite" do
		user.save		
		account.amount = 500
		account.save				
		transferencia6.save		
		expect(transferencia6.tax).to eq(fim_semana_ou_noite+extra)
	end	
end