require 'rails_helper'

describe Account do
	let(:user) { User.new( name: 'user',email: 'user@mail.com', password: '12345678')}
	let(:account) { Account.new(user_id: user.id, amount: 0)}

	let(:user2) { User.new( name: 'user2',email: 'user2@mail.com', password: '12345678')}
	let(:account2) { Account.new(user_id: user.id)}

	it "Iniciar conta válida" do
		user.save 		
		expect(account).to be_valid 
	end 

	it "Iniciar conta inválida" do	
		user2.save 		 		
		expect(account2).to be_invalid 
	end 

	it "Iniciar conta sem existência do usuário" do		 		
		expect(account2).to be_invalid 
	end 	

	it "Salvar conta válida" do
		user.save
		expect(account.save).to eq(true)
	end

	it "Não salvar conta inválida" do
		user2.save		
		expect(account2.save).to eq(false)
	end	

	it "Inativar conta" do
		user.save
		account.save

		account.active = false
		expect(account.active).to eq(false)
	end

	it "Ativar conta" do
		user.save
		account.save

		account.active = true
		expect(account.active).to eq(true)
	end

end