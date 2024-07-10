# frozen_string_literal: true

json.zipcode @address['cep']
json.street @address['logradouro']
json.complement @address['complemento']
json.neighborhood @address['bairro']
json.uf @address['uf']
json.city @address['localidade']
