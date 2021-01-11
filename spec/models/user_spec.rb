require 'rails_helper'


describe User do 
	let(:admin) { User.new( name: 'admin',email: 'admin@mail.com', password: '12345678') }
	let(:gerente) { User.new( name: 'gerente',email: 'admin@mail.com', password: '12345678') }
	let(:joao) { User.new( name: 'João', password: '12345678') }

	it "Iniciar usuário válido" do 		
		expect(admin).to be_valid 
	end 

	it "Iniciar usuário inválido" do 		
		expect(joao).to be_invalid 
	end 

	it "Salvar usuário valido" do
		expect(admin.save).to eq(true)
	end

	it "Não salvar usuário inválido" do
		expect(joao.save).to eq(false)
	end	

	it "Não salvar usuário com email repetido" do 
		admin.save
		expect(gerente.save).to eq(false)
	end 	
end